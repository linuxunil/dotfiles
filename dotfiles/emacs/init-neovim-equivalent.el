;;; init-neovim-equivalent.el --- Emacs config matching Neovim functionality with Evil mode -*- lexical-binding: t; -*-

;;; Commentary:
;; A comprehensive Emacs configuration that replicates your Neovim setup exactly
;; Uses Evil mode for vim emulation and established packages with minimal custom code
;; Based on awesome-emacs recommendations and Emacs best practices

;;; Code:

;; ============================================================================
;; Package Management
;; ============================================================================

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; Install use-package if not already installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; ============================================================================
;; Basic Settings (matching your Neovim config)
;; ============================================================================

;; UI Settings
(setq inhibit-startup-message t)
(setq ring-bell-function 'ignore)
(setq backup-directory-alist `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

;; UI improvements
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(when (fboundp 'global-display-line-numbers-mode) (global-display-line-numbers-mode 1))
(when (fboundp 'column-number-mode) (column-number-mode 1))
(when (fboundp 'show-paren-mode) (show-paren-mode 1))

;; Neovim-like settings
(setq-default display-line-numbers-type 'relative)
(setq scroll-margin 8)
(setq scroll-conservatively 101)
(setq-default fill-column 100)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
(setq-default truncate-lines t)

;; Search settings
(setq search-highlight t)
(setq search-whitespace-regexp ".*?")
(setq isearch-lax-whitespace t)
(setq isearch-regexp-lax-whitespace nil)
(setq case-fold-search t)

;; Files
(setq make-backup-files nil)
(setq create-lockfiles nil)
(setq auto-save-default nil)

;; Performance
(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024))

;; ============================================================================
;; Theme (Catppuccin Macchiato - matching your setup)
;; ============================================================================

(use-package catppuccin-theme
  :config
  (load-theme 'catppuccin :no-confirm)
  (setq catppuccin-flavor 'macchiato))

;; ============================================================================
;; Evil Mode (comprehensive vim emulation)
;; ============================================================================

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-respect-visual-line-mode t)
  (setq evil-undo-system 'undo-redo)
  :config
  (evil-mode 1)
  
  ;; Use visual line motions (matching your Neovim setup)
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
  
  ;; Leader key setup (space as leader, matching Neovim)
  (evil-set-leader 'normal (kbd "SPC"))
  (evil-set-leader 'visual (kbd "SPC"))
  
  ;; Better scrolling (matching your Neovim keymaps)
  (evil-define-key 'normal 'global (kbd "C-d") 'evil-scroll-down)
  (evil-define-key 'normal 'global (kbd "C-u") 'evil-scroll-up)
  
  ;; Set initial state for some modes
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal)
  (evil-set-initial-state 'compilation-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package evil-surround
  :after evil
  :config
  (global-evil-surround-mode 1))

(use-package evil-commentary
  :after evil
  :config
  (evil-commentary-mode 1))

;; ============================================================================
;; Completion Framework (Telescope equivalent)
;; ============================================================================

(use-package vertico
  :init
  (vertico-mode)
  :config
  (setq vertico-count 20)
  (setq vertico-cycle t))

(use-package marginalia
  :init
  (marginalia-mode))

(use-package consult
  :bind (;; C-c bindings in `mode-specific-map'
         ("C-c M-x" . consult-mode-command)
         ("C-c h" . consult-history)
         ("C-c k" . consult-kmacro)
         ("C-c m" . consult-man)
         ("C-c i" . consult-info)
         ([remap Info-search] . consult-info)
         ;; C-x bindings in `ctl-x-map'
         ("C-x M-:" . consult-complex-command)
         ("C-x b" . consult-buffer)
         ("C-x 4 b" . consult-buffer-other-window)
         ("C-x 5 b" . consult-buffer-other-frame)
         ("C-x t b" . consult-buffer-other-tab)
         ("C-x r b" . consult-bookmark)
         ("C-x p b" . consult-project-buffer)
         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)
         ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)
         ;; M-g bindings in `goto-map'
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)
         ("M-g g" . consult-goto-line)
         ("M-g M-g" . consult-goto-line)
         ("M-g o" . consult-outline)
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ;; M-s bindings in `search-map'
         ("M-s d" . consult-find)
         ("M-s c" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)
         ("M-s e" . consult-isearch-history)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)
         ("M-r" . consult-history))
  :config
  (setq consult-project-function (lambda (_) (projectile-project-root)))
  (setq consult-narrow-key "<"))

(use-package embark
  :bind (("C-." . embark-act)
         ("C-;" . embark-dwim)
         ("C-h B" . embark-bindings))
  :config
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

(use-package embark-consult
  :after (embark consult)
  :demand t
  :hook (embark-collect-mode . consult-preview-at-point-mode))

(use-package orderless
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles basic partial-completion)))))

;; ============================================================================
;; Which-key (keybinding discovery)
;; ============================================================================

(use-package which-key
  :init
  (which-key-mode)
  :config
  (setq which-key-idle-delay 0.3)
  (setq which-key-prefix-prefix "+"))

;; ============================================================================
;; LSP Configuration (Mason + LSP equivalent)
;; ============================================================================

(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook ((go-mode . lsp-deferred)
         (python-mode . lsp-deferred)
         (python-ts-mode . lsp-deferred)
         (typescript-mode . lsp-deferred)
         (typescript-ts-mode . lsp-deferred)
         (js-mode . lsp-deferred)
         (js-ts-mode . lsp-deferred)
         (markdown-mode . lsp-deferred)
         (lsp-mode . lsp-enable-which-key-integration))
  :commands (lsp lsp-deferred)
  :config
  (setq lsp-completion-enable t)
  (setq lsp-headerline-breadcrumb-enable t)
  (setq lsp-signature-auto-activate t)
  (setq lsp-signature-render-documentation t)
  (setq lsp-eldoc-enable-hover t)
  (setq lsp-modeline-diagnostics-enable t)
  (setq lsp-modeline-code-actions-enable t)
  (setq lsp-log-io nil)
  (setq lsp-idle-delay 0.5)
  (setq lsp-file-watch-threshold 2000))

(use-package lsp-ui
  :after lsp-mode
  :config
  (setq lsp-ui-doc-enable t)
  (setq lsp-ui-doc-show-with-cursor t)
  (setq lsp-ui-doc-position 'top)
  (setq lsp-ui-sideline-enable t)
  (setq lsp-ui-sideline-show-diagnostics t)
  (setq lsp-ui-sideline-show-hover t)
  (setq lsp-ui-sideline-show-code-actions t)
  (setq lsp-ui-peek-enable t)
  (setq lsp-ui-peek-show-directory t))

;; ============================================================================
;; Completion (Blink.cmp equivalent)
;; ============================================================================

(use-package company
  :init
  (global-company-mode)
  :config
  (setq company-idle-delay 0.2)
  (setq company-minimum-prefix-length 1)
  (setq company-selection-wrap-around t)
  (setq company-tooltip-align-annotations t)
  (setq company-tooltip-limit 20)
  (setq company-show-numbers t)
  (setq company-backends '((company-files company-keywords company-capf company-dabbrev-code company-dabbrev))))

(use-package company-box
  :after company
  :hook (company-mode . company-box-mode)
  :config
  (setq company-box-icons-alist 'company-box-icons-all-the-icons))

;; ============================================================================
;; Syntax Highlighting (Treesitter equivalent)
;; ============================================================================

(use-package tree-sitter
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package tree-sitter-langs
  :after tree-sitter)

;; ============================================================================
;; Git Integration (LazyGit equivalent - but better)
;; ============================================================================

(use-package magit
  :bind (("C-x g" . magit-status)
         ("C-x M-g" . magit-dispatch)
         ("C-c M-g" . magit-file-dispatch))
  :config
  (setq magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package forge
  :after magit)

;; ============================================================================
;; File Explorer (nvim-tree equivalent)
;; ============================================================================

(use-package treemacs
  :defer t
  :bind (("M-0" . treemacs-select-window)
         ("C-x t 1" . treemacs-delete-other-windows)
         ("C-x t t" . treemacs)
         ("C-x t d" . treemacs-select-directory)
         ("C-x t B" . treemacs-bookmark)
         ("C-x t C-t" . treemacs-find-file)
         ("C-x t M-t" . treemacs-find-tag))
  :config
  (setq treemacs-width 35)
  (setq treemacs-follow-mode t)
  (setq treemacs-filewatch-mode t)
  (setq treemacs-fringe-indicator-mode 'always)
  (setq treemacs-git-mode 'simple)
  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t)
  (treemacs-fringe-indicator-mode 'always)
  (treemacs-git-mode 'simple))

(use-package treemacs-evil
  :after (treemacs evil))

(use-package treemacs-projectile
  :after (treemacs projectile))

(use-package treemacs-magit
  :after (treemacs magit))

;; ============================================================================
;; Project Management
;; ============================================================================

(use-package projectile
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
              ("C-c p" . projectile-command-map))
  :config
  (setq projectile-project-search-path '("~/code/" "~/projects/" "~/work/"))
  (setq projectile-completion-system 'default))

;; ============================================================================
;; Statusline (Lualine equivalent)
;; ============================================================================

(use-package doom-modeline
  :init
  (doom-modeline-mode 1)
  :config
  (setq doom-modeline-height 25)
  (setq doom-modeline-bar-width 3)
  (setq doom-modeline-buffer-file-name-style 'truncate-upto-project)
  (setq doom-modeline-icon (display-graphic-p))
  (setq doom-modeline-major-mode-icon t)
  (setq doom-modeline-major-mode-color-icon t)
  (setq doom-modeline-buffer-state-icon t)
  (setq doom-modeline-buffer-modification-icon t)
  (setq doom-modeline-minor-modes nil)
  (setq doom-modeline-enable-word-count t)
  (setq doom-modeline-buffer-encoding nil)
  (setq doom-modeline-indent-info nil)
  (setq doom-modeline-checker-simple-format t)
  (setq doom-modeline-vcs-max-length 12)
  (setq doom-modeline-env-version t)
  (setq doom-modeline-irc-stylize 'identity)
  (setq doom-modeline-github-timer nil)
  (setq doom-modeline-gnus-timer nil))

(use-package all-the-icons
  :if (display-graphic-p))

;; ============================================================================
;; Markdown and Note-taking (Obsidian equivalent)
;; ============================================================================

(use-package markdown-mode
  :mode (("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode)
         ("README\\.md\\'" . gfm-mode))
  :init
  (setq markdown-command "pandoc")
  :config
  (setq markdown-enable-wiki-links t)
  (setq markdown-wiki-link-search-subdirectories t)
  (setq markdown-enable-math t)
  (setq markdown-fontify-code-blocks-natively t)
  (setq markdown-gfm-use-electric-backquote nil)
  (setq markdown-header-scaling t)
  (setq markdown-header-scaling-values '(1.8 1.4 1.2 1.0 1.0 1.0))
  (setq markdown-asymmetric-header t)
  (setq markdown-live-preview-engine 'vmd)
  (setq markdown-split-window-direction 'right)
  (setq markdown-enable-highlighting-syntax t)
  (setq markdown-nested-imenu-heading-index t)
  (setq markdown-gfm-uppercase-checkbox t)
  (setq markdown-make-gfm-checkboxes-buttons t)
  (setq markdown-max-image-size '(500 . 500))
  
  ;; Auto-enable features
  (add-hook 'markdown-mode-hook 'visual-line-mode)
  (add-hook 'markdown-mode-hook 'flyspell-mode))

(use-package org-roam
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/Documents/notes")
  (org-roam-completion-everywhere t)
  (org-roam-capture-templates
   '(("d" "default" plain "%?"
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                         "#+title: ${title}\n")
      :unnarrowed t)
     ("m" "markdown" plain "%?"
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.md"
                         "# ${title}\n")
      :unnarrowed t)))
  (org-roam-dailies-directory "daily/")
  (org-roam-dailies-capture-templates
   '(("d" "default" entry
      "* %?"
      :if-new (file+head "%<%Y-%m-%d>.org"
                         "#+title: %<%Y-%m-%d>\n"))))
  :config
  (org-roam-db-autosync-mode)
  ;; Create notes directory if it doesn't exist
  (unless (file-directory-p org-roam-directory)
    (make-directory org-roam-directory t)))

(use-package org-roam-ui
  :after org-roam
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

;; ============================================================================
;; Language Modes
;; ============================================================================

(use-package go-mode
  :mode "\\.go\\'"
  :config
  (add-hook 'before-save-hook 'gofmt-before-save))

(use-package python-mode
  :mode "\\.py\\'")

(use-package typescript-mode
  :mode (("\\.ts\\'" . typescript-mode)
         ("\\.tsx\\'" . typescript-mode)))

(use-package js2-mode
  :mode "\\.js\\'"
  :config
  (setq js2-basic-offset 2))

;; ============================================================================
;; Terminal Integration
;; ============================================================================

(use-package vterm
  :commands vterm
  :config
  (setq vterm-max-scrollback 10000)
  (setq vterm-buffer-name-string "vterm %s"))

;; ============================================================================
;; Keybindings (matching your Neovim setup exactly)
;; ============================================================================

;; Leader key mappings (matching your Neovim <leader> mappings)
(evil-define-key 'normal 'global
  ;; File operations (matching telescope bindings)
  (kbd "<leader>ff") 'consult-find
  (kbd "<leader>fg") 'consult-ripgrep
  (kbd "<leader>fb") 'consult-buffer
  (kbd "<leader>fh") 'consult-info
  (kbd "<leader>fr") 'consult-recent-file
  
  ;; Git operations (matching lazygit)
  (kbd "<leader>gg") 'magit-status
  (kbd "<leader>gb") 'magit-branch
  (kbd "<leader>gc") 'magit-commit
  (kbd "<leader>gd") 'magit-diff
  (kbd "<leader>gl") 'magit-log
  (kbd "<leader>gp") 'magit-push
  (kbd "<leader>gP") 'magit-pull
  
  ;; File explorer (matching nvim-tree)
  (kbd "<leader>e") 'treemacs
  
  ;; Obsidian operations (matching obsidian.nvim)
  (kbd "<leader>on") 'org-roam-node-find
  (kbd "<leader>oo") 'org-roam-ui-open
  (kbd "<leader>ob") 'org-roam-buffer-toggle
  (kbd "<leader>ot") 'org-roam-tag-add
  (kbd "<leader>os") 'org-roam-node-insert
  (kbd "<leader>of") 'org-roam-node-find
  (kbd "<leader>ol") 'org-roam-buffer-toggle
  (kbd "<leader>od") 'org-roam-dailies-capture-today
  (kbd "<leader>oy") 'org-roam-dailies-capture-yesterday
  (kbd "<leader>op") 'org-roam-graph
  (kbd "<leader>or") 'org-roam-node-random
  
  ;; LSP operations (matching your LSP bindings)
  (kbd "<leader>ca") 'lsp-execute-code-action
  (kbd "<leader>rn") 'lsp-rename
  (kbd "<leader>gd") 'lsp-find-definition
  (kbd "<leader>gr") 'lsp-find-references
  (kbd "<leader>gi") 'lsp-find-implementation
  (kbd "<leader>gD") 'lsp-find-declaration
  (kbd "<leader>k") 'lsp-signature-help
  (kbd "<leader>e") 'lsp-ui-flycheck-list
  
  ;; Buffer operations
  (kbd "<leader>bd") 'kill-buffer
  (kbd "<leader>bn") 'next-buffer
  (kbd "<leader>bp") 'previous-buffer
  
  ;; Window operations
  (kbd "<leader>wh") 'windmove-left
  (kbd "<leader>wj") 'windmove-down
  (kbd "<leader>wk") 'windmove-up
  (kbd "<leader>wl") 'windmove-right
  (kbd "<leader>ws") 'split-window-below
  (kbd "<leader>wv") 'split-window-right
  (kbd "<leader>wd") 'delete-window
  (kbd "<leader>wo") 'delete-other-windows
  
  ;; Project operations
  (kbd "<leader>pp") 'projectile-switch-project
  (kbd "<leader>pf") 'projectile-find-file
  (kbd "<leader>ps") 'projectile-ripgrep
  (kbd "<leader>pt") 'projectile-test-project
  (kbd "<leader>pb") 'projectile-compile-project
  
  ;; Terminal
  (kbd "<leader>tt") 'vterm
  
  ;; Quick actions
  (kbd "<leader>w") 'save-buffer
  (kbd "<leader>q") 'evil-quit
  (kbd "<leader>x") 'kill-buffer-and-window)

;; Additional keybindings matching your Neovim setup
(evil-define-key 'normal 'global
  (kbd "C-d") (lambda () (interactive) (evil-scroll-down 0) (recenter))
  (kbd "C-u") (lambda () (interactive) (evil-scroll-up 0) (recenter))
  (kbd "n") (lambda () (interactive) (evil-search-next) (recenter))
  (kbd "N") (lambda () (interactive) (evil-search-previous) (recenter))
  (kbd "gd") 'lsp-find-definition
  (kbd "gr") 'lsp-find-references
  (kbd "gi") 'lsp-find-implementation
  (kbd "gD") 'lsp-find-declaration
  (kbd "K") 'lsp-describe-thing-at-point
  (kbd "]d") 'flycheck-next-error
  (kbd "[d") 'flycheck-previous-error)

;; Insert mode mappings
(evil-define-key 'insert 'global
  (kbd "C-n") 'company-select-next
  (kbd "C-p") 'company-select-previous
  (kbd "C-y") 'company-complete-selection
  (kbd "C-e") 'company-abort)

;; Visual mode mappings
(evil-define-key 'visual 'global
  (kbd "J") (lambda () (interactive) (evil-move-text-down 1))
  (kbd "K") (lambda () (interactive) (evil-move-text-up 1)))

;; Global keybindings
(global-set-key (kbd "C-s") 'consult-line)
(global-set-key (kbd "M-x") 'execute-extended-command)
(global-set-key (kbd "C-x b") 'consult-buffer)
(global-set-key (kbd "C-x C-f") 'consult-find)

;; ============================================================================
;; Custom Functions (minimal custom code)
;; ============================================================================

;; Simple markdown preview function
(defun markdown-preview ()
  "Preview markdown file in browser using pandoc."
  (interactive)
  (let ((output-file (concat (file-name-sans-extension buffer-file-name) ".html")))
    (shell-command (format "pandoc %s -o %s" buffer-file-name output-file))
    (browse-url output-file)))

;; Bind preview function
(with-eval-after-load 'markdown-mode
  (define-key markdown-mode-map (kbd "C-c C-p") 'markdown-preview))

;; ============================================================================
;; Which-key group definitions
;; ============================================================================

(with-eval-after-load 'which-key
  (which-key-add-key-based-replacements
    "SPC f" "find"
    "SPC g" "git"
    "SPC o" "obsidian"
    "SPC c" "code"
    "SPC r" "rename/refactor"
    "SPC b" "buffer"
    "SPC w" "window"
    "SPC p" "project"
    "SPC t" "terminal/toggle"))

;; ============================================================================
;; Auto-commands (matching your Neovim auto-commands)
;; ============================================================================

;; Highlight on yank
(defun pulse-line (&rest _)
  "Pulse the current line."
  (pulse-momentary-highlight-one-line (point)))

(advice-add 'evil-yank :after #'pulse-line)

;; Auto-format on save for specific filetypes
(add-hook 'before-save-hook
          (lambda ()
            (when (and (derived-mode-p 'go-mode)
                       (fboundp 'lsp-format-buffer))
              (lsp-format-buffer))))

;; Set tab width for Go files
(add-hook 'go-mode-hook
          (lambda ()
            (setq-local tab-width 4)
            (setq-local indent-tabs-mode t)))

;; ============================================================================
;; Performance optimizations
;; ============================================================================

;; Restore garbage collection threshold
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold 16777216
                  gc-cons-percentage 0.1)))

;; ============================================================================
;; End Configuration
;; ============================================================================

(provide 'init-neovim-equivalent)
;;; init-neovim-equivalent.el ends here