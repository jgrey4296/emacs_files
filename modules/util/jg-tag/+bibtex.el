;; bibtex

(defhydra jg-org-ref-bibtex-hydra (:color blue)
  "
_w_: WOS
_c_: WOS citing
_a_: WOS related
_R_: Crossref
_U_: Update from doi
"
  ("w" #'org-ref-bibtex-wos)
  ("c" #'org-ref-bibtex-wos-citing)
  ("a" #'org-ref-bibtex-wos-related)
  ("R" #'org-ref-bibtex-crossref)
  ("U" (doi-utils-update-bibtex-entry-from-doi (org-ref-bibtex-entry-doi)))
  ("q" nil))


(defun jg-tag-build-bibtex-list ()
  "Build a list of all bibtex files to use for bibtex-helm "
  (setq bibtex-completion-bibliography (directory-files jg-tag-loc-bibtex 't "\.bib$")))
(defun jg-tag-split-tags (x)
  (split-string x "," t "+")
  )
(defun jg-tag-bibtex-set-tags (x)
  " Set tags in bibtex entries "
  (let* ((visual-candidates (helm-marked-candidates))
         (actual-candidates (mapcar (lambda (x) (cadr (assoc x jg-tag-candidates-names))) visual-candidates))
         (prior-point 1)
         (end-pos jg-tag-marker)
         (current-tags '())
         (tag-regexp "\\(OPT\\)?tags")
         (has-real-tags-field nil)
         (add-func (lambda (candidate)
                     (if (not (-contains? current-tags candidate))
                         (progn
                           (push candidate current-tags)
                           (puthash candidate 1 jg-tag-global-tags))
                       (progn
                         (setq current-tags (remove candidate current-tags))
                         (puthash candidate (- (gethash candidate jg-tag-global-tags) 1) jg-tag-global-tags))
                       )))
         )
    (save-excursion
      (setq prior-point (- (point) 1))
      (while (and (/= prior-point (point)) (< (point) end-pos))
        (progn
          (setq current-tags (jg-tag-split-tags (bibtex-autokey-get-field tag-regexp))
                prior-point (point)
                has-real-tags-field (not (string-empty-p (bibtex-autokey-get-field "tags")))
                )
          (mapc add-func actual-candidates)
          (bibtex-set-field (if has-real-tags-field "tags" "OPTtags")
                            (string-join current-tags ","))
          ;;(org-ref-bibtex-next-entry)
          (evil-forward-section-begin)
          )))
    )
)
(defun jg-tag-bibtex-set-new-tag (x)
  "A Fallback function to set tags of bibtex entries "
  (save-excursion
    (let ((prior-point (- (point) 1))
          (end-pos jg-tag-marker)
          (stripped_tags (jg-tag-split-tags (jg-tag-strip_spaces x)))
          (tag-regexp "\\(OPT\\)?tags")
          )
      (while (and (/= prior-point (point)) (< (point) end-pos))
        (setq prior-point (point))
        (let* ((current-tags (jg-tag-split-tags (bibtex-autokey-get-field tag-regexp)))
               (filtered-tags (-filter (lambda (x) (not (-contains? current-tags x))) stripped_tags))
               (total-tags (-concat current-tags filtered-tags))
               (has-real-tags-field (not (string-empty-p (bibtex-autokey-get-field "tags"))))
               )
          (bibtex-set-field (if has-real-tags-field "tags" "OPTtags")
                            (string-join total-tags ","))
          (mapc (lambda (x) (puthash x 1 jg-tag-global-tags)) filtered-tags)
          ;;(org-ref-bibtex-next-entry)
          (evil-forward-section-begin)
          ))))
  )
(defun jg-tag-unify-pdf-locations-in-file (name)
  "Change all pdf locations in bibtex file to relative,
ensuring they work across machines "
  (message "Unifying Locations in %s" name)
  (with-temp-buffer
    (insert-file-contents name t)
    (goto-char (point-min))
    (while (re-search-forward "file[[:digit:]]* ?= *{\\(.+mega\\)/\\(.+pdflibrary\\)?" nil t)
      (replace-match "~/Mega" nil nil nil 1)
      (if (eq 6 (length (match-data)))
          (replace-match "pdflibrary" t nil nil 2))
      )
    (write-file name)
    )
  )
(defun jg-tag-unify-pdf-locations ()
  "Unify bibtex pdf paths of marked files"
  (interactive)
  (let ((files (dired-get-marked-files)))
    (seq-each 'jg-tag-unify-pdf-locations-in-file files)
    )
  )
(defun jg-org-ref-bibtex-google-scholar ()
  "Open the bibtex entry at point in google-scholar by its doi."
  (interactive)
  (let* ((search-texts (mapcar #'bibtex-autokey-get-field jg-scholar-search-fields))
         (exact-texts (mapcar #'bibtex-autokey-get-field jg-scholar-search-fields-exact))
         (exact-string (s-join " " (mapcar #'(lambda (x) (format "\"%s\"" x))
                                           (-filter #'(lambda (x) (not (string-empty-p x))) exact-texts))))
         (all-terms (s-concat exact-string (s-join " " search-texts)))
         (search-string (format jg-scholar-search-string all-terms))
         )
    (browse-url search-string)
    )
  )
(defun jg-org-ref-edit-entry-type (newtype)
  (interactive "s")
  (save-excursion
    (bibtex-beginning-of-entry)
    (when (search-forward-regexp "@\\(.+?\\){" (line-end-position))
      (replace-match newtype t nil nil 1)
      )
    )
  )
(defun jg-org-ref-copy-entry ()
  (interactive)
  (save-excursion
    (let (start end)
      (bibtex-beginning-of-entry)
      (setq start (point))
      (bibtex-end-of-entry)
      (setq end (point))
      (copy-region-as-kill start end)
      )
    )
  )
(defun jg-org-ref-copy-key ()
  (interactive)
  (kill-new (bibtex-completion-get-key-bibtex))
  )
(defun jg-org-ref-open-folder ()
  (interactive)
  (when (bibtex-text-in-field "file")
    (shell-command (format "open %s" (f-parent (bibtex-text-in-field "file"))))
    )
  )
(defun jg-org-ref-open-url ()
  (interactive)
  (when (bibtex-text-in-field "url")
    (browse-url (bibtex-text-in-field "url")))
  )
(defun jg-org-ref-open-doi()
  (interactive)
  (when (bibtex-text-in-field "doi")
    (browse-url (format "https://doi.org/%s" (bibtex-text-in-field "doi")))
    )
  )
(defun jg-org-ref-refile-by-year ()
  (interactive)
  (bibtex-beginning-of-entry)
  (let* ((year (bibtex-text-in-field "year"))
         (year-file (format "%s.bib" year))
         (bib-path jg-tag-loc-bibtex)
         (response (if year (read-string (format "Refile to %s? " year-file))))
         (target (if (and year (or (s-equals? "y" response) (string-empty-p response)))
                     (f-join bib-path year-file)
                   (completing-read "Bibtex file: "
                                    (f-entries bib-path
                                               (lambda (f) (f-ext? f "bib"))))))
         )
      (bibtex-kill-entry)
      (with-temp-buffer
        (if (f-exists? target)
            (insert-file-contents target))
        (goto-char (point-max))
        (insert "\n")
        (bibtex-yank)
        (write-file target nil)
      )
    )
  )
(defun jg-org-visual-select-entry ()
  (interactive)
  (evil-visual-make-region (bibtex-beginning-of-entry)
                           (bibtex-end-of-entry))
)
(defun jg-org-goto-crossref-entry ()
  (interactive)
  (when (bibtex-text-in-field "crossref")
    (bibtex-find-crossref (bibtex-text-in-field "crossref"))
    )
  )
(defun jg-org-edit-field ()
  (interactive)
  (save-excursion
    (bibtex-beginning-of-entry)
    (let* ((fields (mapcar #'car (bibtex-parse-entry)))
           (chosen (completing-read "Field: " fields))
           (curr-value (bibtex-autokey-get-field chosen))
           (new-value (read-string "New Value: "))
           )
      (bibtex-set-field chosen new-value)
      )
    )
  )


;; Clean bibtex hooks:
;; adapted from org-ref/org-ref-core.el: orcb-key-comma
;; For org-ref-clean-bibtex-entry-hook
(defun jg-tag-dont-break-lines-hook()
  "Fix File paths and URLs to not have linebreaks"
  (bibtex-beginning-of-entry)
  (beginning-of-line)
  (let* ((keys (mapcar #'car (bibtex-parse-entry)))
         (paths (-filter #'(lambda (x) (string-match jg-tag-remove-field-newlines-regexp x)) keys))
         (path-texts (mapcar #'bibtex-text-in-field paths))
         (path-cleaned (mapcar #'(lambda (x) (replace-regexp-in-string "\n +" " " x)) path-texts))
         )
    ;; Then update:
    (mapc #'(lambda (x) (bibtex-set-field (car x) (cdr x))) (-zip paths path-cleaned))
    )
  )
(defun jg-orcb-clean-doi ()
  "Remove http://dx.doi.org/ in the doi field."
  (let ((doi (bibtex-autokey-get-field "doi")))
    (when (ffap-url-p  doi)
      (bibtex-beginning-of-entry)
      (goto-char (car (cdr (bibtex-search-forward-field "doi" t))))
      (bibtex-kill-field)
      (bibtex-make-field "doi")
      (backward-char)
      (insert (replace-regexp-in-string "^http.*?\.org/" "" doi)))))
