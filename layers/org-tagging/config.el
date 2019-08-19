(setq org-tagging/org-tagging-candidates-names '()
      org-tagging/org-tagging-candidate-counts '()
      ;; Start Position -> End Line number because of changes in positions from tag add/retract
      org-tagging/org-tagging-region '()
      org-tagging/org-tagging-helm `((name . "Helm Tagging")
                                  (action . (("set" . org-tagging/org-set-tags)))
                                  )
      org-tagging/org-tagging-fallback-source `((name . "")
                                                (action . (("Create" . org-tagging/org-set-new-tag)))
                                                (filtered-candidate-transformer
                                                 (lambda (_c _s) (list helm-pattern)))
                                                )
 )
