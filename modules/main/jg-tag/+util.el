;; utility

(defun jg-tag-strip_spaces (str)
  "Utility to replace spaces with underscores in a string.
Used to guard inputs in tag strings"
  (s-replace " " "_" (string-trim str))
  )
(defun jg-tag-sort-candidates (ap bp)
  " Sort routine to sort by colour then lexicographically "
  (let* ((a (car ap))
         (b (car bp))
         (aprop (get-text-property 0 'font-lock-face a))
         (bprop (get-text-property 0 'font-lock-face b))
         (lookup (lambda (x) (gethash (cadr x) jg-tag-global-tags))))
    (cond
     ((and aprop bprop (> (funcall lookup ap) (funcall lookup bp))) t)
     ((and aprop (not bprop)) t)
     ((and (not aprop) (not bprop) (> (funcall lookup ap) (funcall lookup bp))))
     )))
(defun jg-tag-candidates ()
  " Given Candidates, colour them if they are assigned, then sort them  "
  (let* ((buffer-cand-tags (jg-tag-get-buffer-tags))
         (global-tags jg-tag-global-tags))
    (if (not (hash-table-empty-p global-tags))
        (let* ((cand-keys (hash-table-keys global-tags))
               (cand-vals (hash-table-values global-tags))
               (cand-pairs (-zip cand-keys cand-vals))
               (maxTagLength (apply 'max (mapcar 'length cand-keys)))
               (maxTagAmount (apply 'max cand-vals))
               (bar-keys (jg-tag-make-bar-chart cand-pairs maxTagLength maxTagAmount))
               (display-pairs (-zip bar-keys cand-keys))
               (current-tags (org-get-tags nil t))
               (propertied-tags (cl-map 'list (lambda (candidate)
                                             (let ((candString (car candidate)))
                                               (if (-contains? current-tags (cdr candidate))
                                                   (progn (put-text-property 0 (length candString)
                                                                             'font-lock-face
                                                                             'rainbow-delimiters-depth-1-face
                                                                             candString)))
                                               `(,candString ,(cdr candidate)))) display-pairs))
               )
          (setq jg-tag-candidate-counts global-tags)
          (setq jg-tag-candidates-names (sort propertied-tags 'jg-tag-sort-candidates))
          )
      '()
      ))
  )
(defun jg-tag-split-on-char-n (beg end n)
  "Loop through buffer, inserting newlines between lines where
the nth char changes"
  (interactive "r\nnSplit on char number: ")
  (save-excursion
    (goto-char beg)
    (let ((last-char (downcase (char-after (+ (point) n))))
          curr-char)
      (while (< (point) end)
        (setq curr-char (downcase (char-after (+ (point) n))))
        (if (not (eq last-char curr-char))
            (progn
              (setq last-char curr-char)
              (goto-char (line-beginning-position))
              (insert "\n")
              )
          )
        (forward-line)
        )
      )
    )
  )

(defun jg-tag-next-similar-string ()
  " Go through lines, finding the next adjacent string pair
uses org-babel-edit-distance "
  (interactive)
  (let* ((bound (or current-prefix-arg jg-tag-last-similarity-arg))
         (curr-sim (+ bound 1))
         (s2 (downcase (string-trim (car (s-split ":" (buffer-substring (line-beginning-position) (line-end-position)))))))
         s1
         )
    (while (and (< (point) (point-max))
                (> curr-sim bound))
      (forward-line)
      (setq jg-tag-last-similarity-arg bound)
      (setq s1 s2)
      (setq s2 (downcase (string-trim (car (s-split ":" (buffer-substring (line-beginning-position) (line-end-position)))))))
      (setq curr-sim (org-babel-edit-distance s1 s2))
      )
    )
  (message "Using distance %s" jg-tag-last-similarity-arg)
  )
