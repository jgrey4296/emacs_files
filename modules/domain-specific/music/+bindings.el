;; sclang keybindings.el
;; loaded fifth

(defun +music-binding-hook ()
  (map! :leader
        :prefix ("a s" . "Systems")
        :desc "Start Music System" "M" 'jg-music-layer/start-system
        )
)
