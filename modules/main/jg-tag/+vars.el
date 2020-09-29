;;; main/jg-tag/+vars.el -*- lexical-binding: t; -*-

(setq-default jg-tag-loc-bookmarks "~/github/writing/resources/main_bookmarks.html"
              jg-tag-loc-bibtex "~/github/writing/resources/years"
              jg-tag-twitter-account-index "~/.doom.d/setup_files/tw_acct.index"
              jg-tag-twitter-tag-index "~/.doom.d/setup_files/tw_tag.index"
              jg-tag-global-tags-location "~/github/writing/resources/collate.tags"

              jg-tag-twitter-helm-candidates nil
              jg-tag-twitter-heading-helm-candidates nil
              jg-tag-preferred-linecount-for-org 1500
              jg-tag-loc-master-tag-list ""
              jg-tag-org-clean-marker nil

              jg-scholar-search-string "https://scholar.google.com/scholar?hl=en&q=%s"

              bibtex-completion-bibliography nil
              bibtex-completion-additional-search-fields '("tags" "year")
              bibtex-completion-pdf-field "file"
              bibtex-completion-pdf-open-function #'(lambda (x) (org-open-link-from-string (format "[[file:%s]]" x)))

              jg-tag-helm-bibtex-candidates nil

              jg-tag-all-author-list '()
              jg-tag-all-tag-list '()
              jg-tag-global-tags (make-hash-table :test 'equal)
              jg-tag-candidates-names '()
              jg-tag-candidate-counts '()
              ;; Start Position -> End Line number because of changes in positions from tag add/retract
              jg-tag-marker (make-marker)
              jg-tag-last-similarity-arg 1

              ;; Bibtex optional fields
              bibtex-user-optional-fields '(("annotation" "Personal Annotation")
                                            ("tags" "Set of tags")
                                            ("isbn" "ISBN of file")
                                            ("doi" "DOI of file")
                                            ("url" "Url of file")
                                            ("file" "The path of the file")
                                            ("translator" "The Translators of the work")
                                            )
              )
