;;; domain-specific/bibtex/+bindings.el -*- lexical-binding: t; -*-
;; Bibtex bindings
(map! :map bibtex-mode-map
      :desc "Clean entry" :n "C-c C-c"    #'+jg-bibtex-clean-entry
      :desc "Edit Field"         :n  "\\" #'+jg-bibtex-edit-field
      :desc "Change Entry Type " :n "|"   #'+jg-bibtex-edit-entry-type
      :desc "Select Entry"       :v "i e" #'+jg-bibtex-visual-select-entry
      )
(map! :map bibtex-mode-map
      :localleader
      :desc "Bibtex Hydra"        "." #'+jg-bibtex-hydra/body
      :desc "Build Bibliography"  "B" #'org-ref-build-full-bibliography
      :desc "New Entry"           "n" #'org-ref-bibtex-new-entry/body
      :desc "Count Entries"       "C" #'bibtex-count-entries
      :desc "Refile"              "r" #'+jg-bibtex-refile-by-year
      :desc "Scholar Search"      "s" #'+jg-bibtex-google-scholar
      (:prefix ("c" . "Copy")
       :desc "Copy Entry"        "e"    #'+jg-bibtex-copy-entry
       :desc "Copy Key"          "k"    #'+jg-bibtex-copy-key
       )
      (:prefix ("e" . "Edit")
       :desc "Change Entry Type" "t"  #'+jg-bibtex-edit-entry-type
        :desc "Update Entry"      "U" #'bibtex-entry-update
        :desc "Update Field"      "f" #'+jg-bibtex-edit-field
        :desc "Sort Buffer"       "s" #'bibtex-sort-buffer
        :desc "Validate"          "V" #'bibtex-validate
        )
      (:prefix ("j" . "Jump")
      :desc "Jump to Pdf"          "p" #'+jg-bibtex-open-pdf
      :desc "Jump to Pdf Folder"   "P" #'+jg-bibtex-find-folder
      :desc "Jump to url"          "u" #'+jg-bibtex-open-url
      :desc "Jump to doi"          "d" #'+jg-bibtex-open-doi
      :desc "Jump to Crossref"     "c" #'+jg-bibtex-goto-crossref-entry)
      ;; TODO search in crossref
      )

;; Reftex binding override
(map! :map reftex-mode-map
      "C-c [" nil)

(map! :leader
      :desc "Bibtex Helm"               "a h b" #'+jg-tag-helm-bibtex
      (:prefix ("a b" . "Bibtex")
       :desc "Load Random Bibtex entry"  "r" #'+jg-bibtex-load-random)
      )

(after! (helm evil)
  (evil-ex-define-cmd "ci[te]" #'+jg-bibtex-insert-wrapped)
  )
