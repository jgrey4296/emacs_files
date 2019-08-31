(defconst tag-unify-packages '(
                               helm
                               helm-bibtex
                               dash
                               f
                               org
                               )
  )

(defun tag-unify/init-f ()
  (use-package f :defer t)
  )
(defun tag-unify/init-dash ()
  (use-package dash :defer t)
  )
(defun tag-unify/pre-init-helm ()
  (spacemacs|use-package-add-hook helm
    :post-config
    (setq helm-grep-actions (append helm-grep-actions '(("Open Url" . tag-unify/open-url-action))))
    ;; Build a Custom grep for bookmarks
    (setq tag-unify/bookmark-helm-source
          (helm-make-source "Bookmark Helm" 'helm-grep-class
            :action (helm-make-actions "Open Url" 'tag-unify/open-url-action
                                       "Insert"   'tag-unify/insert-candidates
                                       "Insert Link" 'tag-unify/insert-links
                                       "Tweet Link"  'tag-unify/tweet-link-action
                                       )
            :filter-one-by-one 'tag-unify/grep-filter-one-by-one
            :nomark nil
            :backend helm-grep-default-command
            :pcre nil
            )
          )
    )

  (spacemacs/set-leader-keys
    "a B" 'tag-unify/helm-bookmarks)

  (defun tag-unify/helm-bookmarks ()
    (interactive)
    (helm-set-local-variable
     'helm-grep-include-files (format "--include=%s" tag-unify/loc-bookmarks)
     'helm-grep-last-targets `(,tag-unify/loc-bookmarks)
     'default-directory "~/github/writing/resources/"
     )
    (helm :sources tag-unify/bookmark-helm-source
          :full-frame t
          :buffer "*helm bookmarks*"
          :truncate-lines t
          )
    )
  )
(defun tag-unify/pre-init-helm-bibtex ()
  ;; load the bibliography directory on startup
  (setq bibtex-completion-bibliography (tag-unify/build-bibtex-list))
  ;; Keybind my bib helm
  (spacemacs/set-leader-keys "a b" 'tag-unify/helm-bibtex)

  ;; Define the bib helm
  (defvar tag-unify/helm-source-bibtex
    '((name . "BibTeX entries")
      (header-name . "Test")
      ;; (lambda (name) (format "%s%s: " name (if helm-bibtex-local-bib " (local)" ""))))
      (candidates . helm-bibtex-candidates)
      (match helm-mm-exact-match helm-mm-match helm-fuzzy-match)
      (fuzzy-match)
      (redisplay . identity)
      (multimatch)
      (group . helm)
      (filtered-candidate-transformer helm-bibtex-candidates-formatter helm-flx-fuzzy-matching-sort helm-fuzzy-highlight-matches)
      (action . (("Insert citation"     . helm-bibtex-insert-citation)
                 ("Open PDF"            . helm-bibtex-open-pdf)
                 ("Insert BibTeX key"   . helm-bibtex-insert-key)
                 ("Insert BibTeX entry" . helm-bibtex-insert-bibtex)
                 ("Show entry"          . helm-bibtex-show-entry)
                 )))
    "Simplified source for searching bibtex files")
  (defun tag-unify/helm-bibtex (&optional arg local-bib input)
    " Custom implementation of helm-bibtex"
    (interactive "P")
    (require 'helm-bibtex)
    (when arg
      (bibtex-completion-clear-cache))
    (let* ((bibtex-completion-additional-search-fields '("tags" "year"))
           (candidates (if (or arg (null tag-unify/helm-bibtex-candidates))
                           (progn (message "Generating Candidates")
                                  (bibtex-completion-init)
                                  (setq tag-unify/helm-bibtex-candidates
                                        (mapcar 'tag-unify/process-candidates (bibtex-completion-candidates)))
                                  tag-unify/helm-bibtex-candidates)
                         tag-unify/helm-bibtex-candidates
                         ))
           )
      (helm :sources `(,tag-unify/helm-source-bibtex)
            :full-frame helm-bibtex-full-frame
            :buffer "*helm bibtex*"
            :input input
            :bibtex-local-bib local-bib
            :bibtex-candidates candidates
            )))

  )
(defun tag-unify/post-init-org ()
  (spacemacs/set-leader-keys-for-major-mode 'org-mode
    ". c" 'tag-unify/clean-org
    )
  (evil-define-key 'normal 'evil-org-mode-map
    (kbd "g >") 'org-next-link
    )
  )
