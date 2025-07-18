;;; init.el --- Basic Emacs configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; A minimal Emacs configuration for trying out the editor
;; Compatible with your existing Catppuccin theme and workflow

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
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(when (fboundp 'global-display-line-numbers-mode) (global-display-line-numbers-mode 1))
(when (fboundp 'column-number-mode) (column-number-mode 1))
(when (fboundp 'show-paren-mode) (show-paren-mode 1))

;; Catppuccin theme (consistent with your setup)
(use-package catppuccin-theme
  :config
  (load-theme 'catppuccin :no-confirm)
  (setq catppuccin-flavor 'macchiato))

;; Essential packages
(use-package which-key
  :config
  (which-key-mode))

;; Evil mode - comprehensive vim emulation
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-respect-visual-line-mode t)
  (setq evil-undo-system 'undo-tree)
  :config
  (evil-mode 1)
  
  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
  
  ;; Leader key setup (space as leader like many vim configs)
  (evil-set-leader 'normal (kbd "SPC"))
  (evil-set-leader 'visual (kbd "SPC"))
  
  ;; Set initial state for some modes
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

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

(use-package evil-matchit
  :after evil
  :config
  (global-evil-matchit-mode 1))

(use-package undo-tree
  :config
  (global-undo-tree-mode 1)
  (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))
  (setq undo-tree-auto-save-history t))

;; Additional vim-like plugins
(use-package avy
  :bind (("C-;" . avy-goto-char-2)
         ("C-:" . avy-goto-line))
  :config
  (evil-define-key 'normal 'global
    (kbd "gs") 'avy-goto-char-2
    (kbd "gl") 'avy-goto-line))

(use-package evil-escape
  :after evil
  :config
  (evil-escape-mode 1)
  (setq evil-escape-key-sequence "jk")
  (setq evil-escape-delay 0.2))

(use-package evil-numbers
  :after evil
  :config
  (evil-define-key 'normal 'global
    (kbd "C-a") 'evil-numbers/inc-at-pt
    (kbd "C-x") 'evil-numbers/dec-at-pt))

(use-package evil-args
  :after evil
  :config
  (evil-define-key 'normal 'global
    (kbd "cia") 'evil-inner-arg
    (kbd "caa") 'evil-outer-arg
    (kbd "dia") 'evil-inner-arg
    (kbd "daa") 'evil-outer-arg))

(use-package evil-exchange
  :after evil
  :config
  (evil-exchange-install))

;; Better search and navigation (integrates with your ripgrep/fd)
(use-package vertico
  :config
  (vertico-mode 1))

(use-package consult
  :bind (("C-s" . consult-line)
         ("C-x b" . consult-buffer)
         ("C-x C-f" . consult-find)
         ("M-g g" . consult-goto-line)
         ("M-s r" . consult-ripgrep)
         ("M-s f" . consult-fd))
  :config
  (setq consult-ripgrep-args "rg --null --line-buffered --color=never --max-columns=1000 --path-separator / --smart-case --no-heading --with-filename --line-number --search-zip"))

(use-package marginalia
  :config
  (marginalia-mode 1))

(use-package orderless
  :config
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

;; Project management (better than terminal navigation)
(use-package projectile
  :config
  (projectile-mode 1)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (setq projectile-project-search-path '("~/projects/" "~/code/"))
  (setq projectile-completion-system 'default))

;; Superior Git integration (better than lazygit)
(use-package magit
  :bind ("C-x g" . magit-status)
  :config
  (setq magit-refresh-status-buffer nil)
  (setq magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package forge
  :after magit
  :config
  (setq forge-github-token-file "~/.config/forge-token"))

;; Environment management (integrates with direnv)
(use-package direnv
  :config
  (direnv-mode))

;; Better terminal (can replace zellij for some tasks)
(use-package vterm
  :bind ("C-c t" . vterm)
  :config
  (setq vterm-max-scrollback 10000))

(use-package multi-vterm
  :bind (("C-c m t" . multi-vterm)
         ("C-c m n" . multi-vterm-next)
         ("C-c m p" . multi-vterm-prev)))

;; Task runner integration
(use-package compile
  :bind ("C-c c" . compile)
  :config
  (setq compilation-scroll-output t))

;; Company completion
(use-package company
  :config
  (global-company-mode 1)
  (setq company-idle-delay 0.2)
  (setq company-minimum-prefix-length 2))

;; Language support
(use-package go-mode
  :mode "\\.go\\'"
  :config
  (add-hook 'before-save-hook 'gofmt-before-save))

(use-package python-mode
  :mode "\\.py\\'")

(use-package typescript-mode
  :mode "\\.ts\\'")

(use-package js2-mode
  :mode "\\.js\\'")

;; LSP support
(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook ((go-mode . lsp-deferred)
         (python-mode . lsp-deferred)
         (typescript-mode . lsp-deferred)
         (js2-mode . lsp-deferred)
         (markdown-mode . lsp-deferred))
  :commands (lsp lsp-deferred))

(use-package lsp-ui
  :commands lsp-ui-mode)

(use-package lsp-ivy
  :commands lsp-ivy-workspace-symbol)

;; Markdown support (Obsidian-style)
(use-package markdown-mode
  :mode (("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode)
         ("README\\.md\\'" . gfm-mode))
  :init (setq markdown-command "multimarkdown")
  :config
  (setq markdown-enable-wiki-links t
        markdown-wiki-link-search-type 'sub-directories
        markdown-wiki-link-search-subdirectories t
        markdown-enable-math t
        markdown-hide-markup nil
        markdown-markup-face 'markdown-markup-face
        markdown-header-scaling t
        markdown-header-scaling-values '(1.8 1.4 1.2 1.0 1.0 1.0)
        markdown-asymmetric-header t
        markdown-live-preview-engine 'vmd
        markdown-split-window-direction 'right
        markdown-enable-highlighting-syntax t
        markdown-nested-imenu-heading-index t
        markdown-fontify-code-blocks-natively t
        markdown-gfm-uppercase-checkbox t
        markdown-make-gfm-checkboxes-buttons t
        markdown-max-image-size '(500 . 500))
  
  ;; Obsidian-style keybindings
  (define-key markdown-mode-map (kbd "C-c C-l") 'markdown-insert-link)
  (define-key markdown-mode-map (kbd "C-c C-w") 'markdown-insert-wiki-link)
  (define-key markdown-mode-map (kbd "C-c C-f") 'markdown-follow-link-at-point)
  (define-key markdown-mode-map (kbd "C-c C-o") 'markdown-follow-link-at-point)
  (define-key markdown-mode-map (kbd "C-c C-n") 'markdown-next-link)
  (define-key markdown-mode-map (kbd "C-c C-p") 'markdown-previous-link)
  (define-key markdown-mode-map (kbd "M-n") 'markdown-next-visible-heading)
  (define-key markdown-mode-map (kbd "M-p") 'markdown-previous-visible-heading)
  (define-key markdown-mode-map (kbd "C-c C-t") 'markdown-table-insert-table)
  (define-key markdown-mode-map (kbd "C-c C-v") 'markdown-preview)
  (define-key markdown-mode-map (kbd "C-c C-e") 'markdown-export)
  (define-key markdown-mode-map (kbd "C-c C-s") 'markdown-insert-gfm-checkbox)
  (define-key markdown-mode-map (kbd "C-c C-x") 'markdown-toggle-gfm-checkbox)
  
  ;; Auto-completion for links
  (add-hook 'markdown-mode-hook 
            (lambda ()
              (when (fboundp 'company-mode)
                (company-mode 1))
              (auto-fill-mode 1)
              (visual-line-mode 1)
              (flyspell-mode 1)))
  
  ;; Enhanced wiki link support
  (setq markdown-wiki-link-fontify-missing t
        markdown-wiki-link-alias-first nil))

;; Simple obsidian-style functions
(defun obsidian-follow-link-at-point ()
  "Follow obsidian-style link at point."
  (interactive)
  (let ((link (thing-at-point 'word)))
    (when link
      (if (string-match "\\[\\[\\(.*\\)\\]\\]" link)
          (find-file (concat (match-string 1 link) ".md"))
        (when (fboundp 'markdown-follow-link-at-point)
          (markdown-follow-link-at-point))))))

(defun obsidian-insert-wikilink ()
  "Insert a wiki-style link."
  (interactive)
  (let ((link (read-string "Link text: ")))
    (insert (format "[[%s]]" link))))

(defun obsidian-jump ()
  "Jump to a note using completion."
  (interactive)
  (let ((files (directory-files-recursively "~/Documents/obsidian" "\\.md$")))
    (find-file (completing-read "Jump to note: " files))))

(defun obsidian-search ()
  "Search in obsidian notes."
  (interactive)
  (let ((search-term (read-string "Search for: ")))
    (grep-compute-defaults)
    (rgrep search-term "\\.md" "~/Documents/obsidian")))

(defun obsidian-daily-note ()
  "Open today's daily note."
  (interactive)
  (let* ((today (format-time-string "%Y-%m-%d"))
         (dailies-dir "~/Documents/obsidian/dailies")
         (note-file (concat dailies-dir "/" today ".md")))
    (unless (file-exists-p dailies-dir)
      (make-directory dailies-dir t))
    (find-file note-file)
    (when (= (buffer-size) 0)
      (insert (format "# Daily Note - %s\n\n" today)))))

;; Enhanced markdown features
(use-package markdown-toc
  :ensure t
  :bind (:map markdown-mode-map
         ("C-c C-g" . markdown-toc-generate-toc)))

;; Simple markdown preview function
(defun markdown-preview-browser ()
  "Preview markdown file in browser."
  (interactive)
  (let ((output-file (concat (file-name-sans-extension buffer-file-name) ".html")))
    (shell-command (format "pandoc %s -o %s" buffer-file-name output-file))
    (browse-url output-file)))

;; Use built-in grep instead of external packages
(global-set-key (kbd "C-c s") 'rgrep)

;; Keybindings (vim-like where sensible)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x b") 'ivy-switch-buffer)

;; Terminal integration
(global-set-key (kbd "C-c t") 'ansi-term)

;; Custom functions for workflow integration
(defun open-with-zellij ()
  "Open current file in zellij with neovim."
  (interactive)
  (shell-command (format "zellij action new-tab -- nvim %s" (buffer-file-name))))

(defun run-go-task (task)
  "Run a go-task command."
  (interactive "sTask: ")
  (compile (format "task %s" task)))

(defun run-go-task-list ()
  "Show available go-task commands."
  (interactive)
  (compile "task --list"))

(defun project-run-tests ()
  "Run tests for the current project."
  (interactive)
  (cond
   ((projectile-project-p)
    (let ((project-type (projectile-project-type)))
      (cond
       ((eq project-type 'go) (compile "go test ./..."))
       ((eq project-type 'python) (compile "python -m pytest"))
       ((eq project-type 'npm) (compile "npm test"))
       (t (compile "make test")))))
   (t (message "Not in a project"))))

(defun project-build ()
  "Build the current project."
  (interactive)
  (cond
   ((projectile-project-p)
    (let ((project-type (projectile-project-type)))
      (cond
       ((eq project-type 'go) (compile "go build"))
       ((eq project-type 'python) (compile "python -m build"))
       ((eq project-type 'npm) (compile "npm run build"))
       (t (compile "make build")))))
   (t (message "Not in a project"))))

(defun open-project-in-zellij ()
  "Open current project in zellij with appropriate layout."
  (interactive)
  (when (projectile-project-p)
    (let* ((project-root (projectile-project-root))
           (project-name (projectile-project-name))
           (project-type (projectile-project-type))
           (layout (cond
                    ((eq project-type 'go) "go-dev")
                    ((eq project-type 'python) "python-dev")
                    ((eq project-type 'npm) "ts-dev")
                    (t "general-dev"))))
      (shell-command (format "zellij --session %s --layout %s --cwd %s" 
                             project-name layout project-root)))))

;; Vim-style leader key bindings
(evil-define-key 'normal 'global
  ;; File operations
  (kbd "<leader>ff") 'consult-find
  (kbd "<leader>fr") 'consult-recent-file
  (kbd "<leader>fb") 'consult-buffer
  (kbd "<leader>fs") 'save-buffer
  (kbd "<leader>fed") (lambda () (interactive) (find-file "~/.emacs.d/init.el"))
  
  ;; Project operations
  (kbd "<leader>pp") 'projectile-switch-project
  (kbd "<leader>pf") 'projectile-find-file
  (kbd "<leader>ps") 'consult-ripgrep
  (kbd "<leader>pt") 'project-run-tests
  (kbd "<leader>pb") 'project-build
  (kbd "<leader>pz") 'open-project-in-zellij
  
  ;; Git operations (vim-fugitive style)
  (kbd "<leader>gs") 'magit-status
  (kbd "<leader>gb") 'magit-branch
  (kbd "<leader>gd") 'magit-diff
  (kbd "<leader>gl") 'magit-log
  (kbd "<leader>gp") 'magit-push
  (kbd "<leader>gP") 'magit-pull
  (kbd "<leader>gc") 'magit-commit
  
  ;; Search operations
  (kbd "<leader>ss") 'consult-line
  (kbd "<leader>sp") 'consult-ripgrep
  (kbd "<leader>sf") 'consult-fd
  (kbd "<leader>sb") 'consult-buffer
  (kbd "<leader>si") 'consult-imenu
  
  ;; Buffer operations
  (kbd "<leader>bb") 'consult-buffer
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
  
  ;; Terminal operations
  (kbd "<leader>tt") 'vterm
  (kbd "<leader>tm") 'multi-vterm
  (kbd "<leader>tn") 'multi-vterm-next
  (kbd "<leader>tp") 'multi-vterm-prev
  
  ;; Task operations
  (kbd "<leader>tl") 'run-go-task-list
  (kbd "<leader>tr") 'run-go-task
  (kbd "<leader>tc") 'compile
  
  ;; LSP operations
  (kbd "<leader>ld") 'lsp-find-definition
  (kbd "<leader>lr") 'lsp-find-references
  (kbd "<leader>ln") 'lsp-rename
  (kbd "<leader>la") 'lsp-execute-code-action
  (kbd "<leader>lf") 'lsp-format-buffer
  (kbd "<leader>le") 'consult-flymake
  
  ;; Obsidian/Markdown operations
  (kbd "<leader>mo") 'obsidian-follow-link-at-point
  (kbd "<leader>mf") 'obsidian-jump
  (kbd "<leader>ml") 'obsidian-insert-wikilink
  (kbd "<leader>md") 'obsidian-daily-note
  (kbd "<leader>ms") 'obsidian-search
  (kbd "<leader>mp") 'markdown-preview-browser
  (kbd "<leader>me") 'markdown-export
  (kbd "<leader>mg") 'markdown-toc-generate-toc
  (kbd "<leader>mc") 'markdown-insert-gfm-checkbox
  (kbd "<leader>mx") 'markdown-toggle-gfm-checkbox
  
  ;; Toggle operations
  (kbd "<leader>tn") 'display-line-numbers-mode
  (kbd "<leader>tw") 'whitespace-mode
  (kbd "<leader>th") 'hl-line-mode
  
  ;; Quick actions
  (kbd "<leader>qq") 'save-buffers-kill-terminal
  (kbd "<leader>qr") 'restart-emacs
  (kbd "<leader>z") 'open-with-zellij)

;; Additional vim-like bindings
(evil-define-key 'normal 'global
  ;; Quick navigation (vim-style)
  (kbd "C-o") 'evil-jump-backward
  (kbd "C-i") 'evil-jump-forward
  (kbd "C-d") 'evil-scroll-down
  (kbd "C-u") 'evil-scroll-up
  
  ;; Buffer navigation
  (kbd "C-6") 'evil-switch-to-windows-last-buffer
  (kbd "gb") 'consult-buffer
  (kbd "gf") 'find-file-at-point)

;; Insert mode bindings
(evil-define-key 'insert 'global
  (kbd "C-w") 'evil-delete-backward-word
  (kbd "C-u") 'evil-delete-whole-line)

;; Visual mode bindings
(evil-define-key 'visual 'global
  (kbd "<leader>s") 'consult-line)

;; Emacs-style bindings for some operations
(global-set-key (kbd "C-c z") 'open-with-zellij)
(global-set-key (kbd "C-x g") 'magit-status)

;; Global markdown keybindings
(global-set-key (kbd "C-c o") 'obsidian-jump)
(global-set-key (kbd "C-c n") 'obsidian-daily-note)

;; Function to create new markdown note
(defun create-markdown-note ()
  "Create a new markdown note with timestamp."
  (interactive)
  (let* ((timestamp (format-time-string "%Y%m%d%H%M%S"))
         (title (read-string "Note title: "))
         (filename (format "%s-%s.md" timestamp (replace-regexp-in-string "[^a-zA-Z0-9]" "-" (downcase title)))))
    (find-file filename)
    (insert (format "# %s\n\nCreated: %s\n\n" title (format-time-string "%Y-%m-%d %H:%M:%S")))
    (goto-char (point-max))))

;; Function to insert wiki link
(defun insert-wiki-link ()
  "Insert a wiki-style link."
  (interactive)
  (let ((link (read-string "Link text: ")))
    (insert (format "[[%s]]" link))))

;; Enhanced markdown mode hooks
(add-hook 'markdown-mode-hook
          (lambda ()
            ;; Enable word wrap
            (visual-line-mode 1)
            ;; Enable auto-fill for better writing
            (auto-fill-mode 1)
            ;; Set up local keybindings
            (local-set-key (kbd "C-c C-o") 'obsidian-follow-link-at-point)
            (local-set-key (kbd "C-c C-f") 'obsidian-follow-link-at-point)
            (local-set-key (kbd "C-c C-w") 'obsidian-insert-wikilink)
            (local-set-key (kbd "C-c C-j") 'obsidian-jump)
            (local-set-key (kbd "C-c C-d") 'obsidian-daily-note)
            (local-set-key (kbd "C-c C-s") 'obsidian-search)
            (local-set-key (kbd "C-c C-p") 'markdown-preview-browser)))

;; Additional keybindings for markdown workflow
(global-set-key (kbd "C-c C-n") 'create-markdown-note)
(global-set-key (kbd "C-c [[") 'obsidian-insert-wikilink)

(provide 'init)
;;; init.el ends here