;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; from https://github.com/kiwanami/emacs-epc/issues/35
(setq byte-compile-warnings '(not cl-functions))

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Grey"
      user-mail-address "johngrey4296 at gmail.com")

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)

(setq +doom-quit-messages nil
      backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/")))
      display-line-numbers-width 4
      evil-move-beyond-eol t
      evil-move-cursor-back nil
      evil-snipe-repeat-scope nil
      ispell-personal-dictionary (expand-file-name "~/.doom.d/setup_files/.ispell_english")
      line-move-ignore-invisible t
      overflow-newline-into-fringe t
      pyvenv-default-virtual-env-name "~/anaconda3/envs/"
      tab-always-indent t
      which-key-idle-secondary-delay 0.05
      which-key-sort-order 'which-key-key-order-alpha
      custom-theme-load-path (cons "~/.doom.d/packages/jg-themes" custom-theme-load-path)
      highlight-indent-guides-suppress-auto-error t
      outline-blank-line nil
      line-move-ignore-invisible t
      ibuffer-old-time 2
      )

(progn
  (defun doom-highlight-non-default-indentation-h () )
  (setq whitespace-style '(face tabs spaces trailing lines space-before-tab newline indentation empty space-after-tab space-mark tab-mark newline-mark))
  )

(+jg-misc-late-config-popup)

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-Iosvkem)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/github/writing/orgfiles/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

