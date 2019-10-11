;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

;;------------------------------------------------------------------------------
;;        LAYERS
;;------------------------------------------------------------------------------
(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs-base
   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused
   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t
   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '("~/.spacemacs.d/layers/")
   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
     ;;------------------------------------------------------------
     ;;MY LAYER:
     jg_layer
     ;;-----------------------------------------------------------
     (syntax-checking :variables syntax-checking-enable-tooltips nil)
     (shell :variables
            shell-default-height 30
            shell-default-position 'bottom)
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '()
   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()
   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '()
   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and uninstall any
   ;; unused packages as well as their unused dependencies.
   ;; `used-but-keep-unused' installs only the used packages but won't uninstall
   ;; them if they become unused. `all' installs *all* packages supported by
   ;; Spacemacs and never uninstall them. (default is `used-only')
   dotspacemacs-install-packages 'used-only))

;;------------------------------------------------------------------------------
;;     INIT
;;------------------------------------------------------------------------------
(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil
   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'.
   dotspacemacs-elpa-subdirectory nil
   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'."
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 3)
                                (projects . 3)
                                (bookmarks . 3)
                                (agenda . 3)
                                (todos . 3))
   ;; True if the home buffer should respond to resize events.
   dotspacemacs-startup-buffer-responsive t
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(spacemacs-dark
                         spacemacs-light)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("Monaco"
                               :size 13
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The key used for Emacs commands (M-x) (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"
   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; If non nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ nil
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, J and K move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text nil
   ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize t
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy 'always
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-transient-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 1
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t
   ;; If non nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers t
   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil
   ))

;;------------------------------------------------------------------------------
;;    USER INIT
;;------------------------------------------------------------------------------
(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."
  (add-to-list 'load-path (expand-file-name "~/.spacemacs.d/lisp"))
  (add-to-list 'load-path (expand-file-name "~/.spacemacs.d/lisp-lib"))
  (add-to-list 'load-path (expand-file-name "~/github/otherlibs/python-django.el"))
  (add-to-list 'load-path (expand-file-name "~/github/otherlibs/pony-mode/src"))
  (add-to-list 'load-path "/usr/local/opt/erlang/lib/erlang/lib/tools-3.0.1/emacs")
  (make-directory (expand-file-name "~/.emacs.d/autosaves/") t)
  (make-directory (expand-file-name "~/.emacs.d/backups/") t)
  )

;;------------------------------------------------------------------------------
;;     USER CONFIG
;;------------------------------------------------------------------------------
(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."
  (setq-default helm-autoresize-max-height 30
                helm-autoresize-min-height 30
                helm-display-buffer-height 30
                evil-escape-key-sequence "hg"
                version-control-global-margin 0
                ac-use-quick-help t
                scroll-margin 10
                ac-auto-start 1
                truncate-lines 't
                dired-omit-mode 't
                )
  (spacemacs/set-leader-keys
    "a p" nil
    "a P" nil
    "a l" nil)

  (spacemacs/declare-prefix "a p" "Processes")
  (spacemacs/declare-prefix "x j" "Justify")
  (global-auto-complete-mode 1)
  (define-key ac-mode-map (kbd "M-TAB") 'jg_layer/ac-trigger)
  (evil-define-key* 'normal global-map
                    (kbd "g l") 'jg_layer/open_link_in_buffer
                    (kbd "g L") 'jg_layer/open_link_externally
                    )
  (spacemacs/set-leader-keys
    ;; Processes
    "a p P" 'proced
    "a p l" 'launchctl
    "a p p" 'list-processes
    ;;"a a" 'jg_layer/ac-trigger
    ;; Registers:
    "r f" 'frameset-to-register
    "r i" 'insert-register
    "r j" 'jump-to-register
    "r l" 'list-registers
    "r v" 'view-register
    "r w" 'window-configuration-to-register
    "r x" 'copy-to-register
    ;; Text and eval
    "x C" 'insert-char
    "x e" 'eval-expression
    "x i c" 'indent-to-column
    "x m" 'mark-whole-buffer
    ;; Indenting
    ;; toggles
    "t o" 'dired-omit-mode
    ;; searching
    "s o" 'helm-occur
    ;; mode select
    "a m m"   'helm-switch-major-mode
    "a m e"   'helm-enable-minor-mode
    "a m d"   'helm-disable-minor-mode
    ;; Access to old school emacs help:
    "h h" 'help
    ;; Buffer
    "b D" 'kill-other-buffers
    "b `" 'jg_layer/goto-desktop
    "b a" 'jg_layer/goto-org-agenda-file
    "b c" 'jg_layer/clear-buffer
    "b g" 'jg_layer/goto-github
    "b i" 'clone-indirect-buffer-other-window
    "b m" 'jg_layer/goto-messages
    "b M" 'jg_layer/goto-mega
    "b ~" 'jg_layer/goto-home
    "b r" 'jg_layer/goto-resources
    )
  ;; Force the mouse to be disabled
  (defun evil-mouse-drag-region () (interactive))
  (defun mouse-set-point () (interactive))
  (defun evil-mouse-drag-track () (interactive))
  (defun mouse-drag-region () (interactive))

  )
;;------------------------------------------------------------------------------
;;------------------------------------------------------------------------------
;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(evil-escape-delay 0.3)
 '(evil-escape-mode t)
 '(evil-lisp-state-global t)
 '(evil-mode t)
 '(evil-move-cursor-back nil)
 '(evil-shift-width 2)
 '(evil-want-C-i-jump nil)
 '(evil-want-C-u-scroll t)
 '(evil-want-Y-yank-to-eol nil)
 '(git-gutter+-window-width 4)
 '(global-evil-search-highlight-persist t)
 '(global-evil-surround-mode t)
 '(helm-always-two-windows t t)
 '(helm-autoresize-mode t)
 '(helm-bookmark-show-location t t)
 '(helm-descbinds-mode t)
 '(helm-descbinds-window-style (quote split) t)
 '(helm-display-function (quote spacemacs//display-helm-window) t)
 '(helm-display-header-line nil t)
 '(helm-echo-input-in-header-line t t)
 '(helm-flx-for-helm-find-files nil)
 '(helm-flx-mode t)
 '(helm-fuzzy-matching-highlight-fn (quote helm-flx-fuzzy-highlight-match))
 '(helm-fuzzy-sort-fn (quote helm-flx-fuzzy-matching-sort))
 '(helm-locate-command "locate %s %s")
 '(helm-locate-fuzzy-match 0)
 '(helm-mode t)
 '(helm-split-window-inside-p t)
 '(hl-paren-delay 0.2 t)
 '(ibuffer-saved-filter-groups
   (quote
    (("default"
      ("org"
       (saved . "org"))
      ("dired"
       (saved . "dired"))
      ("git"
       (saved . "git")))
     ("dired"
      ("dired"
       (saved . "dired")))
     ("org"
      ("org"
       (saved . "org")))
     ("Home"
      ("helm-major-mode"
       (mode . helm-major-mode))
      ("log4e-mode"
       (mode . log4e-mode))
      ("prolog-mode"
       (mode . prolog-mode))
      ("emacs-lisp-mode"
       (mode . emacs-lisp-mode))
      ("spacemacs-buffer-mode"
       (mode . spacemacs-buffer-mode))
      ("org-mode"
       (mode . org-mode))
      ("text-mode"
       (mode . text-mode))
      ("dired-mode"
       (mode . dired-mode))
      ("debugger-mode"
       (mode . debugger-mode))))))
 '(ibuffer-saved-filters
   (quote
    (("git"
      (derived-mode . magit-mode)
      (saved . "anti-helm"))
     ("music"
      (or
       (name . "*\\(tidal\\|SCLang\\)")
       (used-mode . sclang-mode)
       (used-mode . tidal-mode)
       (file-extension . "scd\\|hs\\|tidal")))
     ("org"
      (used-mode . org-mode))
     ("anti-helm"
      (not used-mode . helm-major-mode))
     ("python"
      (used-mode . python-mode))
     ("dired"
      (used-mode . dired-mode))
     ("programming"
      (or
       (derived-mode . prog-mode)
       (mode . ess-mode)
       (mode . compilation-mode)))
     ("text document"
      (and
       (derived-mode . text-mode)
       (not
        (starred-name))))
     ("TeX"
      (or
       (derived-mode . tex-mode)
       (mode . latex-mode)
       (mode . context-mode)
       (mode . ams-tex-mode)
       (mode . bibtex-mode)))
     ("web"
      (or
       (derived-mode . sgml-mode)
       (derived-mode . css-mode)
       (mode . javascript-mode)
       (mode . js2-mode)
       (mode . scss-mode)
       (derived-mode . haml-mode)
       (mode . sass-mode)))
     ("gnus"
      (or
       (mode . message-mode)
       (mode . mail-mode)
       (mode . gnus-group-mode)
       (mode . gnus-summary-mode)
       (mode . gnus-article-mode))))))
 '(mode-line-in-non-selected-windows t)
 '(org-agenda-files
   (quote
    ("/Users/jgrey/.spacemacs.d/setup_files/base_agenda.org")))
 '(package-selected-packages
   (quote
    (font-lock+ outline-toc ob-prolog helm-org flycheck-plantuml plantuml-mode evil-quickscope vlf origami gscholar-bibtex dired-quick-sort elfeed filesets+ academic-phrases ht helm-filesets fsm free-keys evil-string-inflection string-inflection buffer-utils buffer-sets buffer-manage choice-program csv-mode graphviz-dot-mode stickyfunc-enhance srefactor reveal-in-osx-finder pbcopy osx-trash osx-dictionary launchctl disable-mouse parsec transient lv go-guru go-eldoc company-go go-mode helm-cscope xcscope twittering-mode bundler rvm ruby-tools ruby-test-mode rubocop rspec-mode robe rbenv rake minitest chruby inf-ruby helm-gtags ggtags nlinum rainbow-mode racket-mode org-ref pdf-tools key-chord livid-mode json-mode js2-refactor hy-mode helm-bibtex fsharp-mode company-web company-tern company-ghc company-dcd ivy company-anaconda cargo biblio yapfify yaml-mode web-mode web-beautify toml-mode tagedit slim-mode skewer-mode scss-mode sass-mode faceup racer pyvenv pytest pyenv-mode py-isort pug-mode pip-requirements tablist omnisharp lua-mode simple-httpd live-py-mode json-snatcher json-reformat multiple-cursors js2-mode js-doc intero ibuffer-projectile dash-functional hlint-refactor hindent helm-pydoc helm-hoogle helm-css-scss parsebib haskell-snippets haml-mode glsl-mode ghc geiser company-quickhelp flycheck-rust flycheck-haskell flycheck-dmd-dub emmet-mode disaster d-mode cython-mode csharp-mode web-completion-data tern company-ghci haskell-mode company-cabal company-c-headers company-auctex anaconda-mode coffee-mode cmm-mode cmake-mode clang-format rust-mode biblio-core auctex-latexmk auctex pythonic erlang xterm-color unfill smeargle shell-pop orgit org-projectile org-category-capture org-present org-pomodoro alert log4e gntp org-mime org-download mwim multi-term magit-gitflow htmlize helm-gitignore helm-company helm-c-yasnippet gnuplot gitignore-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe+ git-gutter-fringe fringe-helper git-gutter+ git-gutter fuzzy flyspell-correct-helm flyspell-correct flycheck-pos-tip pos-tip flycheck evil-magit magit magit-popup git-commit ghub treepy graphql with-editor eshell-z eshell-prompt-extras esh-help diff-hl company-statistics company auto-yasnippet yasnippet auto-dictionary ac-ispell auto-complete mmm-mode markdown-toc markdown-mode gh-md ws-butler winum which-key volatile-highlights vi-tilde-fringe uuidgen use-package toc-org spaceline powerline restart-emacs request rainbow-delimiters popwin persp-mode pcre2el paradox spinner org-plus-contrib org-bullets open-junk-file neotree move-text macrostep lorem-ipsum linum-relative link-hint indent-guide hydra hungry-delete hl-todo highlight-parentheses highlight-numbers parent-mode highlight-indentation helm-themes helm-swoop helm-projectile helm-mode-manager helm-make projectile pkg-info epl helm-flx helm-descbinds helm-ag google-translate golden-ratio flx-ido flx fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state smartparens evil-indent-plus evil-iedit-state iedit evil-exchange evil-escape evil-ediff evil-args evil-anzu anzu evil goto-chg undo-tree eval-sexp-fu highlight elisp-slime-nav dumb-jump f dash s diminish define-word column-enforce-mode clean-aindent-mode bind-map bind-key auto-highlight-symbol auto-compile packed aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line helm avy helm-core popup async)))
 '(paradox-github-token t)
 '(python-indent-guess-indent-offset nil t)
 '(python-indent-guess-indent-offset-verbose nil)
 '(spaceline-helm-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-completion-face ((t (:background "#444444" :foreground "color-84"))))
 '(ahs-face ((t (:background "color-63"))))
 '(bold ((t (:weight bold))))
 '(helm-source-header ((t (:inherit bold :background "#0000d7" :foreground "white"))))
 '(highlight ((t (:background "#005faf" :foreground "#b2b2b2"))))
 '(linum ((t (:background "#1c1c1c" :foreground "color-117"))))
 '(mode-line ((t (:background "#0000af" :foreground "#b2b2b2" :box (:line-width 1 :color "#111111")))))
 '(mode-line-inactive ((t (:background "#5f0000" :foreground "#b2b2b2" :box (:line-width 1 :color "#111111")))))
 '(popup-face ((t (:background "#444444" :foreground "color-84"))))
 '(powerline-active1 ((t (:background "#005f00" :foreground "#b2b2b2"))))
 '(powerline-inactive0 ((t (:inherit mode-line-inactive :background "#5f5faf"))))
 '(powerline-inactive1 ((t (:background "#5fafd7" :foreground "#b2b2b2"))))
 '(powerline-inactive2 ((t (:background "#875fff" :foreground "#b2b2b2"))))
 '(sp-show-pair-enclosing ((t (:inherit highlight :background "#0000a7"))))
 '(sp-show-pair-match-face ((t (:inherit bold :background "green" :foreground "#86dc2f" :underline t))))
 '(sp-show-pair-mismatch-face ((t (:inherit show-paren-mismatch))))
 '(vertical-border ((t (:background "white" :foreground "#111111")))))
