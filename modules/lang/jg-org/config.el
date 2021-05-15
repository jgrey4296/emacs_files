;; set pomodoro log variable

(load! "+funcs")
(load! "+pomodoro-funcs")
(load! "+clean-funcs")
(load! "+dired")
(load! "+vars")
(load! "+tags")
(load! "+text-utils")
(after! evil
  (load! "+org-standard-bindings.el")
  (load! "+bindings")
  )

(use-package! link-hint
  :config
  ;; override default org link to open externally sometimes
  (link-hint-define-type 'org-link
    :next #'link-hint--next-org-link
    :at-point-p #'link-hint--org-link-at-point-p
    :vars '(org-mode org-agenda-mode org-link-minor-mode)
    :open #'+jg-org-link-hint-external
    :open-multiple t
    :copy #'kill-new)
  (push 'org-link link-hint-types)
  )

(add-hook 'doom-first-input-hook #'+jg-org-setup-tags-hook 100)
(add-hook 'doom-first-input-hook #'+jg-org-general-binding-hook)

(add-hook 'org-load-hook         #'+jg-org-main-bindings-hook 90)
(add-hook 'org-load-hook         #'+jg-org-personal-binding-hook 100)

(add-hook 'org-agenda-mode-hook  #'+jg-org-agenda-bind-fix-hook)

(after! evil-org
  (add-hook 'evil-org-mode-hook #'+jg-org-evil-standard-bindings-hook 90)
  (add-hook 'evil-org-mode-hook #'+jg-org-evil-binding-hook 100)
)
