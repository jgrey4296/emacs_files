;; -*- no-byte-compile: t; -*-
;;; config/default/packages.el

(package! avy :pin "509471bad0e8094b8639729ec39ca141fae7d4bd")
(package! link-hint :pin "7440704cacb5c0fab35fff8ec59d30fbea17f44a")
(package! iedit)
(unless (featurep! :editor evil)
  (package! expand-region :pin "ea6b4cbb9985ddae532bd2faf9bb00570c9f2781"))

(package! mouse :disable t)
(package! ibuffer)
