;; netlogo packages.el
;; loads second

(defconst netlogo-packages
  '(
    (netlogo-mode :location local)
    ;; package from EPA
    ;; eg: some-package
    ;; (some-package :location elpa)
    ;; (some-package :location local)
    ;; (some-package :location (recipe :fetcher github :repo "some/repo"))
    ;;(some-package :excluded t)
    )

  )

;; (defun <layer>/pre-init-<package>)
;; (defun <layer>/init-<package>)
;; (defun <layer>/post-init-<package>)

(defun netlogo/init-netlogo ()
  (use-package netlogo-mode
    :commands (netlogo-mode)
    ))
