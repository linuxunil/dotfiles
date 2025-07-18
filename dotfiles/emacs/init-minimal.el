;;; init-minimal.el --- Minimal Emacs config with Obsidian-style markdown -*- lexical-binding: t; -*-

;;; Commentary:
;; A minimal Emacs configuration focused on markdown editing with Obsidian-style features
;; Uses well-established packages with minimal custom code

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

;; Catppuccin theme
(use-package catppuccin-theme
  :config
  (load-theme 'catppuccin :no-confirm)
  (setq catppuccin-flavor 'macchiato))

;; Essential completion framework
(use-package vertico
  :init
  (vertico-mode))

(use-package marginalia
  :init
  (marginalia-mode))

(use-package consult
  :bind (("C-s" . consult-line)
         ("C-x b" . consult-buffer)
         ("M-g g" . consult-goto-line)
         ("M-s f" . consult-find)
         ("M-s r" . consult-ripgrep)))

(use-package embark
  :bind (("C-;" . embark-act)
         ("C-h B" . embark-bindings)))

(use-package embark-consult
  :after (embark consult)
  :hook (embark-collect-mode . consult-preview-at-point-mode))

;; Enhanced markdown editing
(use-package markdown-mode
  :mode (("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode)
         ("README\\.md\\'" . gfm-mode))
  :custom
  (markdown-command "pandoc")
  (markdown-enable-wiki-links t)
  (markdown-wiki-link-search-subdirectories t)
  (markdown-enable-math t)
  (markdown-fontify-code-blocks-natively t)
  (markdown-gfm-use-electric-backquote nil)
  :config
  ;; Auto-enable visual-line-mode for markdown
  (add-hook 'markdown-mode-hook 'visual-line-mode)
  (add-hook 'markdown-mode-hook 'flyspell-mode))

;; Option 1: Org-roam for Obsidian-style linking (RECOMMENDED)
(use-package org-roam
  :custom
  (org-roam-directory "~/Documents/notes")
  (org-roam-completion-everywhere t)
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ("C-c n d" . org-roam-dailies-capture-today))
  :config
  (org-roam-db-autosync-mode)
  ;; Daily notes setup
  (setq org-roam-dailies-directory "daily/")
  (setq org-roam-dailies-capture-templates
        '(("d" "default" entry
           "* %?"
           :target (file+head "%<%Y-%m-%d>.org"
                              "#+title: %<%Y-%m-%d>\n")))))

;; Enable markdown support in org-roam
(use-package md-roam
  :after org-roam
  :config
  (md-roam-mode 1))

;; Alternative Option 2: Denote for simpler file-based notes
;; Uncomment if you prefer this over org-roam
;; (use-package denote
;;   :custom
;;   (denote-directory "~/Documents/notes")
;;   (denote-file-type 'markdown-yaml)
;;   (denote-prompts '(title keywords))
;;   :bind (("C-c n n" . denote)
;;          ("C-c n f" . denote-open-or-create)
;;          ("C-c n l" . denote-link)
;;          ("C-c n b" . denote-backlinks)))

;; Git integration
(use-package magit
  :bind ("C-x g" . magit-status))

;; Which-key for keybinding help
(use-package which-key
  :config
  (which-key-mode))

;; Company completion
(use-package company
  :config
  (global-company-mode)
  (setq company-idle-delay 0.2)
  (setq company-minimum-prefix-length 2))

;; Projectile for project management
(use-package projectile
  :config
  (projectile-mode 1)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

;; Evil mode for vim bindings
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (evil-set-leader 'normal (kbd "SPC"))
  (evil-set-leader 'visual (kbd "SPC")))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

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

;; Global keybindings
(global-set-key (kbd "C-c n") 'org-roam-node-find)
(global-set-key (kbd "C-c f") 'consult-find)
(global-set-key (kbd "C-c g") 'consult-ripgrep)

(provide 'init-minimal)
;;; init-minimal.el ends here