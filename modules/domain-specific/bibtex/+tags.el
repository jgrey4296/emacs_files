;;; domain-specific/bibtex/+tags.el -*- lexical-binding: t; -*-

(defun +jg-bibtex-tag-setup-hook ()
  (+jg-tag-add-mode-handler 'bibtex-mode
                            '+jg-bibtex-set-tags
                            '+jg-bibtex-set-new-tag
                            )

  )
(defun +jg-bibtex-split-tags (x)
  (split-string x "," t "+")
  )
(defun +jg-bibtex-set-tags (x)
  " Set tags in bibtex entries "
  (let* ((visual-candidates (helm-marked-candidates))
         (actual-candidates (mapcar (lambda (x) (cadr (assoc x jg-bibtex-candidates-names))) visual-candidates))
         (prior-point 1)
         (end-pos +jg-bibtex-marker)
         (current-tags '())
         (tag-regexp "\\(OPT\\)?tags")
         (has-real-tags-field nil)
         (add-func (lambda (candidate)
                     (if (not (-contains? current-tags candidate))
                         (progn
                           (push candidate current-tags)
                           (puthash candidate 1 +jg-bibtex-global-tags))
                       (progn
                         (setq current-tags (remove candidate current-tags))
                         (puthash candidate (- (gethash candidate +jg-bibtex-global-tags) 1) jg-tag-global-tags))
                       )))
         )
    (save-excursion
      (setq prior-point (- (point) 1))
      (while (and (/= prior-point (point)) (< (point) end-pos))
        (progn
          (setq current-tags (+jg-bibtex-split-tags (bibtex-autokey-get-field tag-regexp))
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
(defun +jg-bibtex-set-new-tag (x)
  "A Fallback function to set tags of bibtex entries "
  (save-excursion
    (let ((prior-point (- (point) 1))
          (end-pos +jg-bibtex-marker)
          (stripped_tags (+jg-bibtex-split-tags (+jg-text-strip-spaces x)))
          (tag-regexp "\\(OPT\\)?tags")
          )
      (while (and (/= prior-point (point)) (< (point) end-pos))
        (setq prior-point (point))
        (let* ((current-tags (+jg-bibtex-split-tags (bibtex-autokey-get-field tag-regexp)))
               (filtered-tags (-filter (lambda (x) (not (-contains? current-tags x))) stripped_tags))
               (total-tags (-concat current-tags filtered-tags))
               (has-real-tags-field (not (string-empty-p (bibtex-autokey-get-field "tags"))))
               )
          (bibtex-set-field (if has-real-tags-field "tags" "OPTtags")
                            (string-join total-tags ","))
          (mapc (lambda (x) (puthash x 1 +jg-bibtex-global-tags)) filtered-tags)
          ;;(org-ref-bibtex-next-entry)
          (evil-forward-section-begin)
          ))))
  )

