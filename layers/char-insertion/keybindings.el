(evil-define-key* '(normal insert) global-map
                  ;; Greek Letters
                  (kbd "C-x 8ga") "α"
                  (kbd "C-x 8gb") "β"
                  (kbd "C-x 8gc") "γ"
                  (kbd "C-x 8gd") "δ"
                  (kbd "C-x 8ge") "ε"
                  (kbd "C-x 8gf") "ζ"
                  (kbd "C-x 8gg") "η"
                  (kbd "C-x 8gh") "θ"
                  (kbd "C-x 8gi") "ι"
                  (kbd "C-x 8gk") "κ"
                  (kbd "C-x 8gl") "λ"
                  (kbd "C-x 8gm") "μ"
                  (kbd "C-x 8gn") "ν"
                  (kbd "C-x 8gx") "ξ"
                  (kbd "C-x 8go") "ο"
                  (kbd "C-x 8gp") "π"
                  (kbd "C-x 8gr") "ρ"
                  (kbd "C-x 8gs") "σ"
                  (kbd "C-x 8gt") "τ"
                  (kbd "C-x 8gu") "υ"
                  (kbd "C-x 8gp") "φ"
                  (kbd "C-x 8gx") "χ"
                  (kbd "C-x 8gy") "ψ"
                  (kbd "C-x 8gz") "ω"
                  ;; Capital Greek
                  (kbd "C-x 8gA") "Α"
                  (kbd "C-x 8gB") "Β"
                  (kbd "C-x 8gC") "Γ"
                  (kbd "C-x 8gD") "Δ"
                  (kbd "C-x 8gE") "Ε"
                  (kbd "C-x 8gF") "Ζ"
                  (kbd "C-x 8gG") "Η"
                  (kbd "C-x 8gH") "Θ"
                  (kbd "C-x 8gI") "Ι"
                  (kbd "C-x 8gK") "Κ"
                  (kbd "C-x 8gL") "Λ"
                  (kbd "C-x 8gM") "Μ"
                  (kbd "C-x 8gN") "Ν"
                  (kbd "C-x 8gX") "Ξ"
                  (kbd "C-x 8gO") "Ο"
                  (kbd "C-x 8gP") "Π"
                  (kbd "C-x 8gR") "Ρ"
                  (kbd "C-x 8gS") "Σ"
                  (kbd "C-x 8gT") "Τ"
                  (kbd "C-x 8gU") "Υ"
                  (kbd "C-x 8gP") "Φ"
                  (kbd "C-x 8gX") "Χ"
                  (kbd "C-x 8gY") "Ψ"
                  (kbd "C-x 8gZ") "Ω"

                  ;; Subscript
                  (kbd "C-x 8s1") "₁"
                  (kbd "C-x 8s2") "₂"
                  (kbd "C-x 8s3") "₃"
                  (kbd "C-x 8s4") "₄"
                  (kbd "C-x 8s5") "₅"
                  (kbd "C-x 8s6") "₆"
                  (kbd "C-x 8s7") "₇"
                  (kbd "C-x 8s8") "₈"
                  (kbd "C-x 8s9") "₉"
                  (kbd "C-x 8s0") "₀"
                  (kbd "C-x 8sn") "ₙ"
                  (kbd "C-x 8sj") "ⱼ"
                  (kbd "C-x 8si") "ᵢ"
                  (kbd "C-x 8sm") "ₘ"
                  (kbd "C-x 8s+") "₊"
                  (kbd "C-x 8s-") "₋"

                  ;;Subscript

                  ;; Math - Sets
                  (kbd "C-x 8ms") "⊂"
                  (kbd "C-x 8mS") "⊃"
                  (kbd "C-x 8me") "⊆"
                  (kbd "C-x 8mE") "⊇"
                  (kbd "C-x 8mn") "∅"
                  (kbd "C-x 8mi") "∩"
                  (kbd "C-x 8mu") "∪"

                  ;; Math Misc
                  (kbd "C-x 8mq") "√"
                  (kbd "C-x 8m8") (lambda () (interactive) (insert "∞"))
                  ;; Logic
                  (kbd "C-x 8la") "∀"
                  (kbd "C-x 8lE") "∃"
                  (kbd "C-x 8lN") "∄"
                  (kbd "C-x 8le") "∈"
                  (kbd "C-x 8ln") (lambda () (interactive) (insert "¬"))
                  (kbd "C-x 8ld") (lambda () (iteractive) (insert "∨"))
                  (kbd "C-x 8lc") (lambda () (interactive) (insert "∧"))
                  (kbd "C-x 8l<") "⧼"
                  (kbd "C-x 8l>") "⧽"
                  (kbd "C-x 8li") (lambda () (interactive) (insert "⇒"))
                  (kbd "C-x 8lI") (lambda () (interactive) (insert "⇔ "))
                  (kbd "C-x 8lt") (lambda () (interactive) (insert "⟙"))
                  (kbd "C-x 8lb") (lambda () (interactive) (insert "⟘"))
                  (kbd "C-x 8l\\") "⊢"
                  (kbd "C-x 8l/") "⊨"
                  (kbd "C-x 8lT") "∴"
                  (kbd "C-x 8l[") "□"
                  (kbd "C-x 8l]") "◇"
                  )

