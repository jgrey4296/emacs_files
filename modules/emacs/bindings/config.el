;;; config/default/config.el -*- lexical-binding: t; -*-

(load! "+misc")
(load! "+funcs")
(load! "+vars")
(when (featurep! +bindings)
  (after! evil
    (load! "+leader-bindings")
    (load! "+leaderless-bindings")
    (load! "+evil-bindings")
    )
)

;;; C-S doom conventions
(when (featurep! +bindings)
  ;; A Doom convention where C-s on popups and interactive searches will invoke
  ;; ivy/helm for their superior filtering.
  (when-let (command (cond ((featurep! :completion ivy)
                            #'counsel-minibuffer-history)
                           ((featurep! :completion helm)
                            #'helm-minibuffer-history)))
    (define-key!
      :keymaps (append +default-minibuffer-maps
                       (when (featurep! :editor evil +everywhere)
                         '(evil-ex-completion-map)))
      "C-s" command))

  ;; Smarter C-a/C-e for both Emacs and Evil. C-a will jump to indentation.
  ;; Pressing it again will send you to the true bol. Same goes for C-e, except
  ;; it will ignore comments+trailing whitespace before jumping to eol.
  (map! :gi "C-a" #'doom/backward-to-bol-or-indent
        :gi "C-e" #'doom/forward-to-last-non-comment-or-eol
        ;; Standardizes the behavior of modified RET to match the behavior of
        ;; other editors, particularly Atom, textedit, textmate, and vscode, in
        ;; which ctrl+RET will add a new "item" below the current one and
        ;; cmd+RET (Mac) / meta+RET (elsewhere) will add a new, blank line below
        ;; the current one.

        ;; C-<mouse-scroll-up>   = text scale increase
        ;; C-<mouse-scroll-down> = text scale decrease
        ;; [C-down-mouse-2] (cmd! (text-scale-set 0))

        ;; auto-indent on newline by default
        :gi [remap newline] #'newline-and-indent
        ;; insert literal newline
        :gi "S-RET"         #'+default/newline
        :gi [S-return]      #'+default/newline
        :gi "C-j"           #'+default/newline

        ;; Add new item below current (without splitting current line).
        :gi "C-RET"         #'+default/newline-below
        :gn [C-return]      #'+default/newline-below
        ;; Add new item above current (without splitting current line)
        :gi "C-S-RET"       #'+default/newline-above
        :gn [C-S-return]    #'+default/newline-above

        (:when IS-MAC
         :gn "s-RET"        #'+default/newline-below
         :gn [s-return]     #'+default/newline-below
         :gn "S-s-RET"      #'+default/newline-above
         :gn [S-s-return]   #'+default/newline-above)))



;; (general-define-key :states
;;                     '(normal visual motion emacs insert)
;;                     :major-modes t :prefix doom-localleader-key :non-normal-prefix doom-localleader-alt-key :states 'normal :keymaps
;;                     '(shell-mode-map)
;;                     "h" #'counsel-shell-history)


(after! ibuffer
  (add-hook 'ibuffer-mode-hook #'+jg-ibuffer-filter-setup)
  )

(after! flycheck
  (map! :leader
        :desc "Flycheck" "!" flycheck-command-map
        :prefix "c"
        :desc "Flycheck" "!" flycheck-command-map
        )
  )
