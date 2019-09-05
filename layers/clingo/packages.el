(defconst clingo-packages
  '(
    prolog
    (ob-clingo :location local)
    )
  )

(defun clingo/init-ob-clingo ()
  (use-package ob-clingo
    :init
    (org-babel-do-load-languages
     'org-babel-load-languages '((clingo . t)))
    (push '("clingo" . prolog-mode) org-src-lang-modes)
    )

  )
