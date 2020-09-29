(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ibuffer-saved-filter-groups
   '(("Dired"
      ("Dired"
       (used-mode . dired-mode)))
     ("my-default"
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
      ("Dired"
       (saved . "Dired"))
      ("Starred"
       (starred-name))
      ("Project: emacs_files"
       (projectile-root "emacs_files" . "/Volumes/documents/github/emacs_files/"))
      ("Project: doom-emacs"
       (projectile-root "doom-emacs" . "/Volumes/documents/github/otherLibs/doom-emacs/"))
      ("Project: writing"
       (projectile-root "writing" . "/Volumes/documents/github/writing/"))
      ("Project: Dropbox"
       (projectile-root "Dropbox" . "/Users/johngrey/Dropbox/")))
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
       (mode . debugger-mode)))))
 '(ibuffer-saved-filters
   '(("default"
      (saved . "anti-helm-and-magit"))
     ("Dired"
      (used-mode . dired-mode))
     ("star"
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
       (mode . gnus-article-mode)))))
 '(org-agenda-files '("/Users/johngrey/.doom.d/setup_files/base_agenda.org")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-comment-face ((t (:foreground "mediumorchid1" :slant italic))))
 '(vimish-fold-fringe ((t (:foreground "indianred"))))
 '(vimish-fold-overlay ((t (:background "dodgerblue" :foreground "black" :weight light))))
 '(whitespace-tab ((t (:background "firebrick" :foreground "#505050")))))
