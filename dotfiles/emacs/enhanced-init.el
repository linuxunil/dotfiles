;;; enhanced-init.el --- Enhanced Emacs configuration with full toolset integration -*- lexical-binding: t; -*-

;;; Commentary:
;; Enhanced Emacs configuration that integrates with your existing toolset:
;; - ripgrep, fd, fzf for search
;; - direnv for environment management
;; - go-task for task running
;; - gh for GitHub integration
;; - Catppuccin Macchiato theme consistency
;; - Terminal integration with vterm

;;; Code:

;; Package management
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Install use-package if not already installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Basic settings
(setq inhibit-startup-message t)
(setq ring-bell-function 'ignore)
(setq backup-directory-alist `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

;; UI improvements
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode 1)
(column-number-mode 1)
(show-paren-mode 1)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)

;; Catppuccin theme (consistent with your setup)
(use-package catppuccin-theme
  :config
  (load-theme 'catppuccin :no-confirm)
  (setq catppuccin-flavor 'macchiato))

;; Essential packages
(use-package which-key
  :config
  (which-key-mode))

;; Modern completion framework (replaces ivy/counsel)
(use-package vertico
  :config
  (vertico-mode 1)
  (setq vertico-cycle t))

(use-package marginalia
  :config
  (marginalia-mode 1))

(use-package orderless
  :config
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

;; Search and navigation with your existing tools
(use-package consult
  :bind (("C-s" . consult-line)
         ("C-x b" . consult-buffer)
         ("C-x 4 b" . consult-buffer-other-window)
         ("C-x 5 b" . consult-buffer-other-frame)
         ("C-x p b" . consult-project-buffer)
         ("M-g g" . consult-goto-line)
         ("M-g M-g" . consult-goto-line)
         ("M-g o" . consult-outline)
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ("M-g r" . consult-ripgrep)  ; Direct ripgrep integration
         ("M-g f" . consult-find)     ; Direct fd integration
         ("M-g F" . consult-locate)
         ("M-y" . consult-yank-pop)
         ("M-s d" . consult-find)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines))
  :config
  ;; Use ripgrep by default
  (setq consult-ripgrep-args "rg --null --line-buffered --color=never --max-columns=1000 --path-separator / --smart-case --no-heading --with-filename --line-number --search-zip")
  ;; Use fd by default
  (setq consult-find-args "fd --color=never --full-path"))

;; FZF integration
(use-package fzf
  :config
  (setq fzf/args "-x --color bw --print-query --margin=1,0 --no-hscroll")
  (setq fzf/executable "fzf")
  (setq fzf/git-grep-args "git grep --line-number --color=never")
  (setq fzf/grep-command "rg --no-heading --vimgrep")
  (setq fzf/position-bottom t)
  (setq fzf/window-height 15))

;; Project management
(use-package projectile
  :config
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  ;; Use ripgrep for project search
  (setq projectile-use-git-grep t)
  (setq projectile-generic-command "fd . -0 --type f --color=never"))

;; Git integration (superior to lazygit)
(use-package magit
  :bind ("C-x g" . magit-status)
  :config
  (setq magit-diff-refine-hunk t)
  (setq magit-repository-directories '(("~/projects" . 2))))

;; GitHub integration (replaces gh cli for many tasks)
(use-package forge
  :after magit
  :config
  (setq forge-topic-list-limit '(60 . 0)))

;; Alternative GitHub integration
(use-package gh
  :defer t)

;; Directory environment management
(use-package direnv
  :config
  (direnv-mode)
  ;; Integration with your direnv setup
  (setq direnv-always-show-summary nil))

;; Terminal integration (better than ansi-term)
(use-package vterm
  :bind ("C-c t" . vterm)
  :config
  (setq vterm-buffer-name-string "vterm %s")
  (setq vterm-max-scrollback 10000))

;; Multi-vterm for better terminal management
(use-package multi-vterm
  :bind (("C-c t" . multi-vterm-next)
         ("C-c T" . multi-vterm)))

;; Company completion
(use-package company
  :config
  (global-company-mode 1)
  (setq company-idle-delay 0.1)
  (setq company-minimum-prefix-length 2))

;; Language support
(use-package go-mode
  :mode "\\.go\\'"
  :config
  (add-hook 'before-save-hook 'gofmt-before-save)
  ;; Go-specific compile commands
  (add-hook 'go-mode-hook
            (lambda ()
              (set (make-local-variable 'compile-command)
                   "go build -v && go test -v && go vet"))))

(use-package python-mode
  :mode "\\.py\\'"
  :config
  ;; Python-specific compile commands using UV
  (add-hook 'python-mode-hook
            (lambda ()
              (set (make-local-variable 'compile-command)
                   "uv run python -m pytest"))))

(use-package typescript-mode
  :mode "\\.ts\\'"
  :config
  ;; TypeScript-specific compile commands
  (add-hook 'typescript-mode-hook
            (lambda ()
              (set (make-local-variable 'compile-command)
                   "pnpm run build"))))

(use-package js2-mode
  :mode "\\.js\\'")

;; LSP support
(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook ((go-mode . lsp-deferred)
         (python-mode . lsp-deferred)
         (typescript-mode . lsp-deferred)
         (js2-mode . lsp-deferred))
  :commands (lsp lsp-deferred)
  :config
  (setq lsp-completion-provider :company)
  (setq lsp-idle-delay 0.1))

(use-package lsp-ui
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-doc-enable t)
  (setq lsp-ui-doc-position 'bottom)
  (setq lsp-ui-sideline-enable t))

;; Go-task integration
(defun run-go-task (task)
  "Run a go-task command."
  (interactive
   (list (completing-read "Task: " 
                          (split-string 
                           (shell-command-to-string "task --list-all | grep -E '^[[:space:]]*[*]' | awk '{print $2}' | sort")
                           "\n" t))))
  (compile (format "task %s" task)))

(defun run-go-task-list ()
  "Show available go-task commands."
  (interactive)
  (compile "task --list"))

;; Bind task runner commands
(global-set-key (kbd "C-c r t") 'run-go-task)
(global-set-key (kbd "C-c r l") 'run-go-task-list)

;; Quick task shortcuts matching your aliases
(defun task-base () (interactive) (compile "task base"))
(defun task-dev () (interactive) (compile "task dev"))
(defun task-clean () (interactive) (compile "task clean"))
(defun task-status () (interactive) (compile "task status"))

(global-set-key (kbd "C-c r b") 'task-base)
(global-set-key (kbd "C-c r d") 'task-dev)
(global-set-key (kbd "C-c r c") 'task-clean)
(global-set-key (kbd "C-c r s") 'task-status)

;; Zellij integration functions
(defun open-in-zellij ()
  "Open current file in zellij with neovim."
  (interactive)
  (shell-command (format "zellij action new-tab -- nvim %s" (buffer-file-name))))

(defun zellij-run-command (command)
  "Run a command in a new zellij pane."
  (interactive "sCommand: ")
  (shell-command (format "zellij action new-pane -- %s" command)))

(global-set-key (kbd "C-c z o") 'open-in-zellij)
(global-set-key (kbd "C-c z r") 'zellij-run-command)

;; File management with your tools
(defun find-file-with-fd ()
  "Find file using fd."
  (interactive)
  (consult-find))

(defun grep-project-with-ripgrep ()
  "Grep project using ripgrep."
  (interactive)
  (consult-ripgrep))

(global-set-key (kbd "C-c f f") 'find-file-with-fd)
(global-set-key (kbd "C-c f g") 'grep-project-with-ripgrep)

;; Better defaults
(global-set-key (kbd "C-x C-f") 'find-file)
(global-set-key (kbd "M-x") 'execute-extended-command)
(global-set-key (kbd "C-x b") 'consult-buffer)

;; Window management
(global-set-key (kbd "C-c w") 'ace-window)

;; Ace window for better window navigation
(use-package ace-window
  :bind ("C-x o" . ace-window)
  :config
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))

;; Syntax checking
(use-package flycheck
  :config
  (global-flycheck-mode))

;; Tree-sitter for better syntax highlighting
(use-package tree-sitter
  :config
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package tree-sitter-langs
  :after tree-sitter)

;; Helpful for better help system
(use-package helpful
  :bind (("C-h f" . helpful-callable)
         ("C-h v" . helpful-variable)
         ("C-h k" . helpful-key)
         ("C-h x" . helpful-command)))

;; Dashboard for better startup
(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-items '((recents  . 5)
                          (projects . 5)
                          (agenda . 5))))

;; Modern file browser
(use-package dired
  :ensure nil
  :bind (("C-x C-j" . dired-jump))
  :config
  (setq dired-listing-switches "-agho --group-directories-first")
  (setq dired-dwim-target t))

;; Enhanced dired
(use-package dired-single
  :after dired)

(use-package dired-ranger
  :after dired)

;; Custom functions for your workflow
(defun open-config-file ()
  "Open this configuration file."
  (interactive)
  (find-file "~/.dotfiles/dotfiles/emacs/init.el"))

(global-set-key (kbd "C-c e c") 'open-config-file)

;; Load custom settings if they exist
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

(provide 'enhanced-init)
;;; enhanced-init.el ends here