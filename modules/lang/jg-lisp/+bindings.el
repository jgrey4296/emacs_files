;;; lang/emacs-lisp/+bindings.el -*- lexical-binding: t; -*-

(map! :map emacs-lisp-mode-map
      :localleader
      :desc "Sort Defuns" "S" #'+jg-lisp-sort-defuns
      :desc "Lisp Reference" "g 1" (cmd! (+jg-browse-url "https://www.gnu.org/software/emacs/manual/html_node/elisp/index.html"))
      )
