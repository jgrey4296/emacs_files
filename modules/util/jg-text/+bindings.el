;;; util/text/+bindings.el -*- lexical-binding: t; -*-
(message "Loading modules/util/text/+bindings.el")

(defun +jg-text-binding-hook ()
  ;; Get rid of zap to char:
  (map! "M-z" nil)

  ;; Text bindings
  ;; (map! :map jg-bindings-operator-map)

  (map! :leader
        (:prefix "t"
         "v r" #'rainbow-mode)
        )
  (map! :leader
        :prefix "h"
        :desc "Regex Reminder" "R" #'+jg-text-regex-reminder
        )
)
