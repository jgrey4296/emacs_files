;Personalised .emacs file
;John Grey, Wed May 28 17:50:31 PDT 2014

;(setq debug-on-error 1)

;; Load paths
;;(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(package-initialize)

(setq load-path (cons "~/.emacs.setup/lisp-lib/" load-path))
<<<<<<< HEAD


=======
;;(require 'tidal)
(setq tidal-interpreter "/usr/local/bin/ghci")
>>>>>>> 84169cfec733237f76b51950bfeaa340dc2bd8ad

(let ((default-directory (expand-file-name "~/.emacs.setup/")))
  (normal-top-level-add-subdirs-to-load-path))

(add-to-list 'load-path (expand-file-name "~/.emacs.setup/lisp"))
(add-to-list 'load-path (expand-file-name "~/.emacs.setup/lisp-lib"))
;; PAY ATTENTION TO THE USER NAME
(add-to-list 'load-path "/Users/jgrey/github/otherlibs/python-django.el")
(add-to-list 'load-path "/Users/jgrey/github/otherlibs/pony-mode/src")

;;load path for erlang tools
(add-to-list 'load-path "/usr/local/opt/erlang/lib/erlang/lib/tools-3.0.1/emacs")

(load "my-functions")
(load "my-aliases")
(load "my-variables")
(load "my-keybindings")
(load "my-modes")
(load "my-hooks")
(load "my-colours")



