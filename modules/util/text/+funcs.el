;;; util/text/+funcs.el -*- lexical-binding: t; -*-
(defun +jg-text-strip_spaces (str)
  "Utility to replace spaces with underscores in a string.
Used to guard inputs in tag strings"
  (s-replace " " "_" (string-trim str))
  )
(defun +jg-text-split-on-char-n (beg end n)
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
(defun +jg-text-next-similar-string ()
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
