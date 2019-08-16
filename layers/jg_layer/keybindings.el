;; jg_layer keybindings.el
;; loaded fifth

;;(configuration-layer/declare-layer)
;;(configuration-layer/declare-layers)
;;(configuration-layer/layer-usedp)
;;(configuration-layer/package-usedp)

(global-set-key (kbd "C-c [") 'jg_layer/insert-lparen)
(global-set-key (kbd "C-c ]") 'jg_layer/insert-rparen)
(spacemacs/declare-prefix "x i" "Indent")
(spacemacs/set-leader-keys
  ;; Registers:
  "r v" 'view-register
  "r l" 'list-registers
  "r w" 'window-configuration-to-register
  "r x" 'copy-to-register
  "r j" 'jump-to-register
  "r f" 'frameset-to-register
  "r i" 'insert-register
  ;; Expression:
  "x e" 'eval-expression
  ;; Clearing
  "b c" 'jg_layer/clear-buffer
  ;;Indirect buffer
  "b i" 'clone-indirect-buffer-other-window
  ;; Indenting
  "x i c" 'indent-to-column
  ;; toggles
  "t o" 'dired-omit-mode
  ;; searching
  "s o" 'helm-occur
  ;; mode select
   "m"   'helm-switch-major-mode
  ;; mark buffer
  "x m" 'mark-whole-buffer
  ;; Access to old school emacs help:
  "h h" 'help
  ;; ac trigger
  ;;"a a" 'jg_layer/ac-trigger
  ;; goto org agenda file
  "b a" 'jg_layer/goto-org-agenda-file
)
