;;; domain-specific/bibtex/config.el -*- lexical-binding: t; -*-

(load! "+funcs")
(load! "+helm")
(load! "+hooks")
(load! "+vars")
(load! "+helm")
(load! "+tags")
(after! evil
  (load! "+bindings")
  )


(use-package! bibtex
  :init
  (add-hook 'bibtex-mode-hook #'org-ref-version)
  )
(use-package! helm-bibtex
  :defer t
  :commands (bibtex-completion-init)
)
(use-package! org-ref
  :after-call org-ref-version
  :init
  (custom-set-variables '(org-ref-insert-cite-key "C-c i"))
  (add-hook 'bibtex-mode-hook #'yas-minor-mode)
  (add-hook 'bibtex-mode-hook #'reftex-mode)
  :config
  (loop for a-hook in jg-bibtex-clean-remove-hooks
        do (remove-hook 'org-ref-clean-bibtex-entry-hook a-hook))
  (loop for a-hook in jg-bibtex-clean-add-hooks
        do (add-hook 'org-ref-clean-bibtex-entry-hook a-hook 100))
  )
(after! (f helm-bibtex)
  (jg-tag-build-bibtex-list)
)

(when (featurep! :emacs jg-tag)
  (+jg-tag-add-mode-handler 'bibtex-mode
                            '+jg-bibtex-set-tags
                            '+jg-bibtex-set-new-tag
                            )
  )
