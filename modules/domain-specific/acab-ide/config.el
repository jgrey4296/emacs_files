;; trie config.el
;; loaded fourth

(load! "+vars")
(after! evil
  (load! "+bindings")
  )
(after! org
  ;; TODO upgrade to org-superstar?
  (add-hook 'trie-mode-hook 'org-bullets-mode)
)
(after! helm
  (load! "+helms")
  )
(after! hydra
  (load! "+hydra")
  )


(use-package! acab-mode
  :defer

  )
