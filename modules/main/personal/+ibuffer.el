
(setq!
   '(ibuffer-saved-filter-groups
     (quote
      (("my-default"
        ("star"
         (saved . "star"))
        ("org"
         (saved . "org"))
        ("programming"
         (saved . "programming"))
        ("dired"
         (saved . "dired")))
       ("progorg"
        ("org"
         (saved . "org"))
        ("programming"
         (saved . "programming")))
       ("programming"
        ("programming"
         (saved . "programming")))
       ("default"
        ("org"
         (saved . "org"))
        ("dired"
         (saved . "dired"))
        ("git"
         (saved . "git")))
       ("dired"
        ("dired"
         (saved . "dired")))
       ("org"
        ("org"
         (saved . "org")))
       ("Home"
        ("helm-major-mode"
         (mode . helm-major-mode))
        ("log4e-mode"
         (mode . log4e-mode))
        ("prolog-mode"
         (mode . prolog-mode))
        ("emacs-lisp-mode"
         (mode . emacs-lisp-mode))
        ("spacemacs-buffer-mode"
         (mode . spacemacs-buffer-mode))
        ("org-mode"
         (mode . org-mode))
        ("text-mode"
         (mode . text-mode))
        ("dired-mode"
         (mode . dired-mode))
        ("debugger-mode"
         (mode . debugger-mode))))))
   '(ibuffer-saved-filters
     (quote
      (("star"
        (name . "^*"))
       ("anti-helm-and-magit"
        (saved . "anti-magit")
        (saved . "anti-helm"))
       ("anti-magit"
        (not derived-mode . magit-mode))
       ("git"
        (derived-mode . magit-mode)
        (saved . "anti-helm"))
       ("bibtex"
        (used-mode . bibtex-mode))
       ("music"
        (or
         (name . "*\\(tidal\\|SCLang\\)")
         (used-mode . sclang-mode)
         (used-mode . tidal-mode)
         (file-extension . "scd\\|hs\\|tidal")))
       ("org"
        (used-mode . org-mode))
       ("anti-helm"
        (not used-mode . helm-major-mode))
       ("python"
        (used-mode . python-mode))
       ("dired"
        (used-mode . dired-mode))
       ("programming"
        (or
         (derived-mode . prog-mode)
         (mode . ess-mode)
         (mode . compilation-mode)))
       ("text document"
        (and
         (derived-mode . text-mode)
         (not
          (starred-name))))
       ("TeX"
        (or
         (derived-mode . tex-mode)
         (mode . latex-mode)
         (mode . context-mode)
         (mode . ams-tex-mode)
         (mode . bibtex-mode)))
       ("web"
        (or
         (derived-mode . sgml-mode)
         (derived-mode . css-mode)
         (mode . javascript-mode)
         (mode . js2-mode)
         (mode . scss-mode)
         (derived-mode . haml-mode)
         (mode . sass-mode)))
       ("gnus"
        (or
         (mode . message-mode)
         (mode . mail-mode)
         (mode . gnus-group-mode)
         (mode . gnus-summary-mode)
         (mode . gnus-article-mode))))))
)
