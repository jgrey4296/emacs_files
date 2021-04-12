;;; util/text/+funcs.el -*- lexical-binding: t; -*-
(defun +jg-text-strip-spaces (str)
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
  (let* ((bound (or current-prefix-arg jg-text-last-similarity-arg))
         (curr-sim (+ bound 1))
         (s2 (downcase (string-trim (car (s-split ":" (buffer-substring (line-beginning-position) (line-end-position)))))))
         s1
         )
    (while (and (< (point) (point-max))
                (> curr-sim bound))
      (forward-line)
      (setq jg-text-last-similarity-arg bound)
      (setq s1 s2)
      (setq s2 (downcase (string-trim (car (s-split ":" (buffer-substring (line-beginning-position) (line-end-position)))))))
      (setq curr-sim (org-babel-edit-distance s1 s2))
      )
    )
  (message "Using distance %s" jg-text-last-similarity-arg)
  )
(defun +jg-get-line ()
  (buffer-substring-no-properties (line-beginning-position)
                                  (line-end-position))
  )
(defun +jg-misc-uniquify (L R)
  (interactive "r")
  (save-excursion
    (goto-char L)
    (let ((R-mark (set-marker (make-marker) R))
          (current (+jg-get-line))
          (kill-whole-line t))
      (forward-line 1)
      (while (<= (point) R-mark)
        ;; compare
        (if (s-equals? current (+jg-get-line))
            (kill-line)
          (progn (setq current (+jg-get-line))
                 (forward-line 1))
          )
        )
      )
    )
  )

(defun +jg-text-regex-reminder ()
  (interactive)
  (with-temp-buffer-window "*Regex Char Class Reminder*" 'display-buffer-pop-up-window
                           nil
    (princ (yas--template-content (yas-lookup-snippet "Char Classes" 'fundamental-mode)))
    )
  nil
  )

(defun +jg-text-simple-grep (reg)
  " Copy any matching line into a separate buffer "
  (interactive "sMatch Regexp: ")
  (with-temp-buffer-window "*Text-Results*" 'display-buffer-pop-up-window nil
    (goto-char (point-min))
    (while (re-search-forward reg nil t)
      (princ (format "%s : %s\n" (line-number-at-pos) (buffer-substring (line-beginning-position) (line-end-position))))
      )
    )
  (let ((inhibit-read-only t))
    (with-current-buffer "*Text-Results*"
      (align-regexp (point-min) (point-max) "\\(\s-*\\):")
      )
    )
  )
