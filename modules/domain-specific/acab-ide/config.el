;; trie config.el
;; loaded fourth

(defgroup trie-modes '() "Customization group for trie-related modes")

(defvar jg-trie-layer/rule-helm-source nil
  "Main Helm Source for rule loading / finding ")
(defvar jg-trie-layer/rule-helm-dummy-source)
(defvar jg-trie-layer/type-helm-source nil
  "Main Helm Source for type loading / finding ")
(defvar jg-trie-layer/type-helm-dummy-source)


;;Variables for the active ide
(setq jg-trie-layer/trie-ide-is-running nil
      jg-trie-layer/python-process nil
      jg-trie-layer/window-configuration nil
      jg-trie-layer/ide-data-loc nil
      jg-trie-layer/ide-pipeline-spec-buffer nil
      )

(defcustom jg-trie-layer/process-python-command
  "python3"
  "Name of the Python program to use")
(defcustom jg-trie-layer/process-python-args
  ""
  "Arguments to python to run IDE server")

;;Defaults
(setq-default
 jg-trie-layer/inputs-buffer-name "*Rule Inputs*"
 jg-trie-layer/outputs-buffer-name "*Rule Outputs*"
 jg-trie-layer/working-group-buffer-name "*Rule Working Group*"
 jg-trie-layer/logging-buffer-name "*Rule Logs*"
 jg-trie-layer/python-process-buffer-name "*Rule IDE*"
 jg-trie-layer/working-group-buffer-headings '("Defeaters"
                                               "Interferers"
                                               "Alternatives"
                                               "Equal Depth"
                                               "Relevant Types"
                                               "Meta"
                                               "Layer Stats"
                                               "Tests")
 jg-trie-layer/data-loc-subdirs '("rules"
                                  "types"
                                  "crosscuts"
                                  "patterns"
                                  "tests")

 )

;; TODO
(defhydra trie-help-hydra (:color pink)
  "
   | General           ^^|
   |-------------------^^+
   | [_q_] Quit          |
   |                   ^^|
   |                   ^^|
   |                   ^^|
  "

  ("q" nil :exit t)
  )

;; Defines all sub-trie modes: trie, trie-visual, sequence etc
;; TODO (spacemacs/declare-prefix "a s" "Start Editor")
;; TODO (spacemacs/set-leader-keys
;; "a s t" 'jg-trie-layer/toggle-trie-ide)
(evil-define-key 'normal trie-mode-map
  (kbd "#") 'trie/insert-tag
  (kbd "C") 'trie/insert-condition
  (kbd "A") 'trie/insert-action
  (kbd "T") 'trie/insert-transform
  )

;; TODO upgrade to org-superstar?
(add-hook 'trie-mode-hook 'org-bullets-mode)

(use-package! trie-sequence-mode
    :defer
    :commands (trie-sequence-mode)
    :config
    (map! :mode trie-sequence-mode
          :prefix ("," . "Trie-Sequence Mode Prefix"))
    (evil-define-key '(normal visual) trie-sequence-mode-map
      "l" 'trie-sequence/user-inc-column
      "h" 'trie-sequence/user-dec-column
      "k" 'trie-sequence/user-dec-line
      "j" 'trie-sequence/user-inc-line
      )
    (map! :mode trie-sequence-mode
      "."   'hydra-trie-sequence/body
      )
    ;; TODO Make hydra
    (defhydra trie-sequence_transient
      "
   | General           ^^| Change                    ^^| Motion             ^^| Remove              ^^| Sort                         ^^|
   |-------------------^^+---------------------------^^+--------------------^^+---------------------^^+------------------------------^^|
   | [_q_] Quit          | [_i_] Insert Rule           |                    ^^| [_d_] Delete Value    | [_s_] Sort Table Alpha         |
   | [_n_] New Table     |                           ^^|                    ^^| [_D_] Delete Column   |                              ^^|
   | [_v_] Table Inspect | [_r_] Rename Column         | [_c_] Centre Column  | [_m_] Merge Column    |                              ^^|
   | [_b_] Set Right Tab | [_t_] Insert Terminal       |                    ^^|                     ^^|                              ^^|
  "
      ("q" nil :exit t)
      ("n" trie-sequence/new-table ) ;; org create table, insert
      ("v" trie-sequence/inspect-table) ;; create a left temp buffer that shows selected column's values (plus highlights active ones)
      ("b" nil ) ;; create a right temp buffer that shows selected column's values (plus highlights active ones)
      ("i" trie-sequence/insert-rule) ;; specify LHS and RHS, insert into factbase, insert into appropriate columns
      ("r" trie-sequence/rename-column) ;; Rename the column from default
      ("t" trie-sequence/insert-terminal) ;; Insert an Input terminal
      ("c" trie-sequence/centre-column) ;; Centre the current column
      ("d" trie-sequence/delete-value) ;; Delete the value at point from the table
      ("D" trie-sequence/delete-column) ;; Delete the column from the table
      ("m" nil ) ;; Merge the left connections and the right connections
      ("s" trie-sequence/sort-table) ;; sort all columns alphabetically
      )
)
(use-package trie-explore-mode
  :after (trie-tree)
  :commands (trie-explore-mode trie-explore/explore-current-buffer)
  :init
  (map! :leader
        "a s e" 'trie-explore/explore-current-buffer)
  :config
  (map! :prefix ("," . "Trie-Explore Mode Prefix"))
  (map! :mode trie-explore-mode
       "i n" 'trie-explore/initial-setup
       "i N" #'(lambda () (interactive) (trie-explore/initial-setup t))
      )
  (evil-define-key '(normal visual) trie-explore-mode-map
    ;;Add motions here
    (kbd "<RET>") 'trie-explore/expand-entry
    ;; "\t" 'jg-trie-layer/no-op
    "\t" 'trie-explore/update-tree-data
    ;; h,l : Move column
    (kbd "h") 'trie-explore/layer-decrease
    (kbd "l") 'trie-explore/layer-increase
    ;;Insertion
    (kbd "I") 'trie-explore/insert-at-leaf
    ;;Deletion
    (kbd "D") 'trie-explore/delete-entry
    )
  (evil-define-key '(insert) trie-explore-mode-map
    (kbd "<RET>") 'trie-explore/insert-entry
    )
  (map! :mode 'trie-explore-mode
        :localleader
        "."   'trie-explore_transient/body
        )
  (defhydra trie-explore_transient
    "
   | General           ^^|
   |-------------------^^+
   | [_q_] Quit          |
  "
    ("q" nil :exit t)
    )
  )
(use-package! trie-minor-mode
  :defer
  :commands (trie-minor-mode)
  :config
  (map! :map 'trie-minor-mode-map
        "f r" 'jg-trie-layer/rule-helm
        "f t" 'jg-trie-layer/type-helm
        "f T" 'jg-trie-layer/test-helm
        "f c" 'jg-trie-layer/crosscut-helm
        "f s" 'jg-trie-layer/pattern-helm
        "d r" 'jg-trie-layer/delete-rule
        "d t" 'jg-trie-layer/delete-type
        "d c" 'jg-trie-layer/delete-crosscut
        "d s" 'jg-trie-layer/delete-sequence
        "l r" 'jg-trie-layer/list-rules
        "l t" 'jg-trie-layer/list-types
        "l c" 'jg-trie-layer/list-crosscuts
        "l s" 'jg-trie-layer/list-sequences
        "?"   'trie-help-hydra/body

        "e"   'jg-trie-layer/explore-trie
        )
    (evil-define-minor-mode-key 'normal 'trie-minor-mode
      (kbd "[ [") 'jg-trie-layer/decrement-priors-layer
      (kbd "] [") 'jg-trie-layer/increment-priors-layer
      (kbd "[ ]") 'jg-trie-layer/decrement-posts-layer
      (kbd "] ]") 'jg-trie-layer/increment-posts-layer
      )
    )

(after! helm
  ;;TODO: add helms for types, crosscuts, patterns, tests, tags,
  ;;strategies, performatives, channels
  (setq jg-trie-layer/rule-helm-source
        (helm-make-source "Rule Helm" 'helm-source-sync
          :action (helm-make-actions "Open Rule" 'trie/find-rule)
          :candidates 'trie/get-rule-helm-candidates
          )
        ;;--------------------
        jg-trie-layer/rule-helm-dummy-source
        (helm-make-source "Rule Dummy Helm" 'helm-source-dummy
          :action (helm-make-actions "Create Rule" 'trie/create-rule)
          )
        )
    ;----
  (setq jg-trie-layer/type-helm-source
        (helm-make-source "Type Helm" 'helm-source-sync
          :action (helm-make-actions "Open Type" 'trie/find-type)
          :candidates 'trie/get-type-helm-candidates
          )
          ;;--------------------
        jg-trie-layer/type-helm-dummy-source
        (helm-make-source "Type Dummy Helm" 'helm-source-dummy
          :action (helm-make-actions "Create Type" 'trie/create-type)
          )
        )
    ;----
  (setq jg-trie-layer/crosscut-helm-source
        (helm-make-source "Crosscut Helm" 'helm-source-sync
          :action (helm-make-actions "Open Crosscut" 'trie/find-crosscut)
          :candidates 'trie/get-crosscut-helm-candidates
          )
        )
    ;----
  (setq jg-trie-layer/pattern-helm-source
        (helm-make-source "Pattern Helm" 'helm-source-sync
          :action (helm-make-actions "Open Pattern" 'trie/find-pattern)
          :candidates 'trie/get-pattern-helm-candidates
          )
        ;;--------------------
        jg-trie-layer/pattern-helm-dummy-source
        (helm-make-source "Pattern Dummy Helm" 'helm-source-dummy
          :action (helm-make-actions "Create Pattern" 'trie/create-pattern)
          )
        )
    ;----
  (setq jg-trie-layer/test-helm-source
        (helm-make-source "Test Helm" 'helm-source-sync
          :action (helm-make-actions "Open Test" 'trie/find-test)
          :candidates 'trie/get-test-helm-candidates
          )
        ;;--------------------
        jg-trie-layer/test-helm-dummy-source
        (helm-make-source "Test Dummy Helm" 'helm-source-dummy
          :action (helm-make-actions "Create Test" 'trie/create-test)
          )
          )
    ;----
  (setq jg-trie-layer/tag-helm-source
        (helm-make-source "Tag Helm" 'helm-source-sync
          :action (helm-make-actions "Open Tag" 'trie/toggle-tag)
          :candidates 'trie/get-tag-helm-candidates
          )
        ;;--------------------
        jg-trie-layer/tag-helm-dummy-source
        (helm-make-source "Tag Dummy Helm" 'helm-source-dummy
          :action (helm-make-actions "Create Tag" 'trie/create-tag)
          )
          )
    ;----
  (setq jg-trie-layer/channel-helm-source
        (helm-make-source "Channel Helm" 'helm-source-sync
          :action (helm-make-actions "Open Channel" 'trie/find-channel)
          :candidates 'trie/get-channel-helm-candidates
          )
        ;;--------------------
        jg-trie-layer/channel-helm-dummy-source
        (helm-make-source "Channel Dummy Helm" 'helm-source-dummy
          :action (helm-make-actions "Create Channel" 'trie/create-channel)
          )
          )

  (defun jg-trie-layer/rule-helm ()
    "Helm for inserting and creating rules into jg-trie-layer/rule authoring mode"
    (interactive)
    (helm :sources '(jg-trie-layer/rule-helm-source jg-trie-layer/rule-helm-dummy-source)
          :full-frame t
          :buffer "*Rule Helm*"
          )
    )
  ;;add type helm
  (defun jg-trie-layer/type-helm ()
    "Helm for inserting and creating types into jg-trie-layer/type authoring mode"
    (interactive)
    (helm :sources '(jg-trie-layer/type-helm-source jg-trie-layer/type-helm-dummy-source)
          :full-frame t
          :buffer "*Type Helm*"
          )
    )
  ;;add crosscut helm
  (defun jg-trie-layer/crosscut-helm ()
    "Helm for inserting and creating crosscuts into jg-trie-layer/crosscut authoring mode"
    (interactive)
    (helm :sources '(jg-trie-layer/crosscut-helm-source jg-trie-layer/crosscut-helm-dummy-source)
          :full-frame t
          :buffer "*Crosscut Helm*"
          )
    )
  ;;add pattern helm
  (defun jg-trie-layer/pattern-helm ()
    "Helm for inserting and creating patterns into jg-trie-layer/pattern authoring mode"
    (interactive)
    (helm :sources '(jg-trie-layer/pattern-helm-source jg-trie-layer/pattern-helm-dummy-source)
          :full-frame t
          :buffer "*Pattern Helm*"
          )
    )
  ;;add test helm
  (defun jg-trie-layer/test-helm ()
    "Helm for inserting and creating tests into jg-trie-layer/test authoring mode"
    (interactive)
    (helm :sources '(jg-trie-layer/test-helm-source jg-trie-layer/test-helm-dummy-source)
          :full-frame t
          :buffer "*Test Helm*"
          )
    )
  ;;add tag helm
  (defun jg-trie-layer/tag-helm ()
    "Helm for inserting and creating tags into jg-trie-layer/tag authoring mode"
    (interactive)
    (helm :sources '(jg-trie-layer/tag-helm-source jg-trie-layer/tag-helm-dummy-source)
          :full-frame t
          :buffer "*Tag Helm*"
          )
    )
  ;;add channel helm
  (defun jg-trie-layer/channel-helm ()
    "Helm for inserting and creating channels into jg-trie-layer/channel authoring mode"
    (interactive)
    (helm :sources '(jg-trie-layer/channel-helm-source jg-trie-layer/channel-helm-dummy-source)
          :full-frame t
          :buffer "*Channel Helm*"
          )
    )
  )
