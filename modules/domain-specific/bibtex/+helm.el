;;; domain-specific/bibtex/+helm.el -*- lexical-binding: t; -*-

;; Actions
(defun +jg-bibtex-show-entry (keys)
  "Show the first entry in KEYS in the relevant BibTeX file.
modified from the original bibtex-completion-show-entry
"
  (let* ((bib-loc jg-bibtex-loc-bibtex)
         (entry (bibtex-completion-get-entry keys))
         (year (bibtex-completion-get-value "year" entry))
         (year-file (f-join bib-loc (format "%s.bib" year)))
         (todo-file (f-join bib-loc "todo.bib"))
         )
    (catch 'break
      (dolist (bib-file `(,year-file ,todo-file))
        (find-file bib-file)
        (if (buffer-narrowed-p)
            (widen))
        (goto-char (point-min))
        ;; find the key
        (bibtex-find-entry keys)
        (let ((bounds (+evil:defun-txtobj)))
          (narrow-to-region (car bounds) (cadr bounds))
          (throw 'break t)
          )))))
(defun +jg-bibtex-edit-notes (keys)
  "Show the first entry in KEYS in the relevant BibTeX file.
modified from the original bibtex-completion-show-entry
"
  (let* ((bib-loc jg-bibtex-loc-bibtex)
         (entry (bibtex-completion-get-entry keys))
         (year (bibtex-completion-get-value "year" entry))
         (year-file (f-join bib-loc (format "%s.bib" year)))
         (todo-file (f-join bib-loc "todo.bib"))
         )
    (catch 'break
      (dolist (bib-file `(,year-file ,todo-file))
        (find-file bib-file)
        (if (buffer-narrowed-p)
            (widen))
        ;; find the key
        (bibtex-find-entry keys)
        (let ((bounds (bibtex-search-forward-field "notes" t)))
          ;; create notes if not existing
          (if (not bounds)
              (progn
                (bibtex-end-of-entry)
                (evil-open-above 0)
                (insert " notes = {")
                (setq bounds `(nil ,(point) ,(+ (point) 2) ,(+ (point) 2)))
                (insert " }")
                ))
          (narrow-to-region (nth 1 bounds) (nth 2 bounds)))
        (org-mode)
        (throw 'break t)
        ))))
(defun +jg-bibtex-insert-simple(x)
  (let* ((entry (bibtex-completion-get-entry x))
         (name (cdr (assoc "title" entry 's-equals?)))
         )
    (insert name)
    )
  )
(defun +jg-bibtex-insert-wrapped ()
  (interactive)
  (save-excursion
    (let ((curr-word (current-word)))
      (evil-end-of-line)
      (insert " ")
      (+jg-bibtex-insert-simple curr-word)
      )
    )
  )

;; Utilities
(defun +jg-bibtex-helm-candidates-formatter (candidates _)
  "Format CANDIDATES for display in helm."
  (cl-loop
   with width = (with-helm-window (helm-bibtex-window-width))
   for entry in candidates
   for entry = (cdr entry)
   for entry-key = (bibtex-completion-get-value "=key=" entry)
   collect (cons (+jg-bibtex-completion-format-entry entry width) entry-key))
)

(defun +jg-bibtex-completion-format-entry (entry width)
  "Formats a BibTeX ENTRY for display in results list.
WIDTH is the width of the results list.  The display format is
governed by the variable `bibtex-completion-display-formats'."
  (let* ((format
          (or (assoc-string (bibtex-completion-get-value "=type=" entry)
                            bibtex-completion-display-formats-internal
                            'case-fold)
              (assoc t bibtex-completion-display-formats-internal)))
         (format-string (cadr format)))
    (s-format
     format-string
     (lambda (field)
       (let* ((field (split-string field ":"))
              (field-name (car field))
              (field-width (cadr field))
              (field-value (bibtex-completion-get-value field-name entry)))
         (when (and (string= field-name "author")
                    (not field-value))
           (setq field-value (bibtex-completion-get-value "editor" entry)))
         (when (and (string= field-name "year")
                    (not field-value))
           (setq field-value (car (split-string (bibtex-completion-get-value "date" entry "") "-"))))
         (setq field-value (bibtex-completion-clean-string (or field-value " ")))
         (when (member field-name '("author" "editor"))
           (setq field-value (bibtex-completion-shorten-authors field-value)))
         (if (not field-width)
             field-value
           (setq field-width (string-to-number field-width))
           (truncate-string-to-width
            field-value
            (if (> field-width 0)
                field-width
              (- width (cddr format)))
            0 ?\s)))))))
(defun +jg-bibtex-process-candidates (x)
  "Utility to tidy bibtex-completion-candidates for helm-bibtex"
  (cons (s-replace-regexp ",? +" " " (car x))
        (cdr x))
  )

(defun +jg-bibtex-sort-by-year (c1 c2)
  (let* ((c1year (alist-get "year" c1 nil nil 'string-equal))
         (c2year (alist-get "year" c2 nil nil 'string-equal)))
    (if (not c1year)
        (progn (message "MISSING YEAR: %s" c1)
               (setq c1year "0")))
    (if (not c2year)
        (progn (message "MISSING YEAR: %s" c2)
               (setq c2year "0")))
    (> (string-to-number c1year) (string-to-number c2year))
    )
  )
(defun +jg-year-sort-transformer (candidates source)
  (-sort #'+jg-bibtex-sort-by-year candidates)
  )

;; Actual Helm
(defun +jg-bibtex-helm-bibtex (&optional arg local-bib input)
  " Custom implementation of helm-bibtex"
  (interactive "P")
  (when arg
    (bibtex-completion-clear-cache))
  (let* ((bibtex-completion-additional-search-fields '("tags" "year"))
         (candidates (if (or arg (null jg-bibtex-helm-candidates))
                         (progn (message "Generating Candidates")
                                (bibtex-completion-init)
                                (setq jg-bibtex-helm-bibtex-candidates
                                      (mapcar '+jg-bibtex-process-candidates (bibtex-completion-candidates)))
                                jg-bibtex-helm-bibtex-candidates)
                       jg-bibtex-helm-bibtex-candidates
                       ))
         )
    (helm-set-local-variable
     'helm-candidate-number-limit 5000
     )
    (helm :sources `(,jg-bibtex-helm-source-bibtex)
          :full-frame helm-bibtex-full-frame
          :buffer "*helm bibtex*"
          :input input
          :bibtex-local-bib local-bib
          :bibtex-candidates candidates
          )))

(after! helm-bibtex
  ;; Define the bib helm

  (setq jg-bibtex-helm-source-bibtex
        (helm-build-sync-source "Bibtex Helm"
          :action (helm-make-actions  "Insert citation"      #'helm-bibtex-insert-citation
                                      "Open PDF"             #'helm-bibtex-open-pdf
                                      "Insert BibTeX key"    #'helm-bibtex-insert-key
                                      "Insert BibTeX entry"  #'helm-bibtex-insert-bibtex
                                      "Insert Bibtex simple" #'+jg-bibtex-insert-simple
                                      "Show entry"           #'+jg-bibtex-show-entry
                                      "Edit Notes"           #'+jg-bibtex-edit-notes
                                      )
          :candidates 'helm-bibtex-candidates
          :filtered-candidate-transformer  '(jg-year-sort-transformer
                                             +jg-bibtex-helm-candidates-formatter
                                             helm-fuzzy-highlight-matches)
          :multimatch
          :fuzzy-match
          )
        )
  )
