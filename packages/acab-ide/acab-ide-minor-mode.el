;; -*- mode: emacs-lisp; lexical-binding: t; -*-

;;based On https://www.emacswiki.org/emacs/ModeTutorial
(require 'acab-comint)
(require 'acab-face)
(require 'acab-hydras)
(require 'acab-log-mode)
(require 'acab-inst-mode)
(require 'acab-rule-mode)
(require 'acab-sequence-mode)

(require 'trie-explore-mode)
(require 'trie-management)
(require 'trie-minor-mode)
(require 'trie-mode)
(require 'trie-data)
(require 'trie-company)

(provide 'acab-ide-minor-mode)

(defgroup acab-ide '() "Acab Mode Customizations")
;;--------------------
;; Mode Variables
;;--------------------
(defcustom acab-ide-minor-mode-hook nil "Basic Hook For Acab Mode" :type '(hook))
(defvar acab-ide/ide-data-loc nil)

;;--------------------
;;Utilities
;;--------------------
;;Utilities
(defun acab-ide/no-op ()
  (interactive)
  )

;;--------------------
;;Key bindings.
;;use sparse-keymap if only a few bindings
;;--------------------
(defvar acab-ide-minor-mode-map
  (make-sparse-keymap)
  "Keymap for Acab ide mode")

;; --------------------
;;Entry Function
;;--------------------
(define-minor-mode acab-ide-minor-mode
  "Major Mode for creating rules using Acab"
  nil
  :lighter "Acab-IDE"
  :keymap acab-ide-minor-mode-map
  :global t
  (if acab-ide-minor-mode
      (progn
        (message "Acab IDE: Enabled")
        ;; Init management variables
        (acab-ide/init)
        ;; start acab-window-manager
        (acab-wm/init)
        ;; start up acab-comint
        (acab-comint/init)
        ;; Setup acab-company
        (acab-company-minor-mode)
        ;; Setup trie-company
        (trie-company-minor-mode)
        )
    (progn
      (message "Acab IDE: Disabled")
      ;; Cleanup the IDE
      ))
 )
