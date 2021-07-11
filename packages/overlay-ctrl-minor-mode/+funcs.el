;; General Functions
(cl-defstruct overlay_control/overlay-struct regexp face bounds)

(defun overlay_control/set-overlay (candidate)
  "Set the default overlay to be used"
  (setq overlay_control/current-overlay-type candidate)
  )
(defun overlay_control/set-hide-text (str)
  (interactive "s Hide Text: ")
  (setq overlay_control/hide-text str)
  )

;; Application Functions
(defun overlay_control/apply-hide-overlay ()
  (interactive)
  (let ((overlay_control/current-overlay-type `(display ,overlay_control/hide-text)))
    (overlay_control/apply-to-region)
    )
  )
(defun overlay_control/apply-to-region ()
  (interactive)
  (message "Starting application to region")
  (let* ((inhibit-modification-hooks t)
         (bounds (if (evil-visual-state-p) (evil-visual-range) `(,(point-min) ,(point-max))))
         (regexp (read-string "Overlay Regexp: "))
         (properties (-concat '(font-lock-ignore t overlay-control t)
                              (if (eq :display overlay_control/current-overlay-type)
                                  `(display ,overlay_control/hide-text)
                                overlay_control/current-overlay-type)))
         (struct (make-overlay_control/overlay-struct :regexp regexp
                                                      :face overlay_control/current-overlay-type
                                                      :bounds bounds))
         )
    (push struct overlay_control/overlays)
    (goto-char (car bounds))
    (save-excursion
      (while (re-search-forward regexp (cadr bounds) t)
        (add-text-properties (match-beginning 0) (point) properties)
        )
      )
    )
  (message "Finishing application to region")
  )
(defun overlay_control/overlay-word ()
  (interactive)
  (let* ((bounds `(,(point-min) ,(point-max)))
         (regexp (if (evil-visual-state-p) (buffer-substring-no-properties evil-visual-beginning
                                                                           evil-visual-end)
                   (current-word)))
         (properties (-concat '(font-lock-ignore t overlay-control t)
                              (if (eq :display overlay_control/current-overlay-type)
                                  `(display ,overlay_control/hide-text)
                                overlay_control/current-overlay-type)))
         (struct (make-overlay_control/overlay-struct :regexp regexp
                                                      :face overlay_control/current-overlay-type
                                                      :bounds bounds))
         )
    (push struct overlay_control/overlays)
    (save-excursion
      (goto-char (car bounds))
      (while (re-search-forward regexp (cadr bounds) t)
        (add-text-properties (match-beginning 0) (point) properties)
        )
      )
    )
  )
(defun overlay_control/clear-on-buffer ()
  (interactive)
  (setq overlay_control/overlays '())
  (remove-text-properties (point-min) (point-max)
                          '(font-lock-ignore t overlay-control t display t invisible t))
  )
(defun overlay_control/re-run-overlays ()
  (interactive)
  (save-excursion
    (mapc (lambda (x)
            (let* ((regexp (overlay_control/overlay-struct-regexp x))
                   (bounds (overlay_control/overlay-struct-bounds x))
                   (end (cadr bounds))
                   (face   (overlay_control/overlay-struct-face x))
                   (properties (-concat '(font-lock-ignore t overlay-control t)
                                        (if (eq :display face)
                                            `(display ,overlay_control/hide-text)
                                          face)))
                   )
              (goto-char (car bounds))
              (save-match-data
                (while (re-search-forward regexp end t)
                  (add-text-properties (match-beginning 0) (point) properties)
                  )
                )
              )
            )
          overlay_control/overlays)
    )
  )

;; Register Functions
(defun overlay_control/apply-overlay-register (r)
  (interactive "c")
  (setq overlay_control/overlays (-concat overlay_control/overlays (registerv-data (get-register r))))
  (overlay_control/re-run-overlays)
  )
(defun overlay_control/add-to-register (r)
  (interactive "c")
  (let* ((register-struct (get-register r))
         (register-overlays (if (null register-struct) nil (registerv-data register-struct)))
         (current-overlays overlay_control/overlays)
         (concat-overlays (-concat register-overlays current-overlays))
         )
    (set-register r (registerv-make concat-overlays
                                    :print-func 'overlay_control/register-print-fn
                                    :jump-func nil
                                    :insert-func nil))
    )
  )
(defun overlay_control/clear-register (r)
  (interactive "c")
  (set-register r nil)
  )
(defun overlay_control/register-print-fn (data)
  (princ "A Set of Overlays")
  (mapc (lambda (x)
          (let ((bounds (overlay_control/overlay-struct-bounds x))
                (regexp (overlay_control/overlay-struct-regexp x))
                (face   (overlay_control/overlay-struct-face   x)))
            (princ (format "\n %s %s : %s"
                           (if (null bounds) "" bounds)
                           regexp face))
            )
          ) data)
  )
