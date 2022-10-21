;;; init.el -- Emacs Config

;;; Commentary:

;; Emacs config

;;; Code:

;; Don't show the splash screen
(setq inhibit-startup-message t)

;; Turn off some unneeded UI elements
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; resize window
(set-frame-size (selected-frame) 140 35)

;; center emacs
(unless (eq 'maximised (frame-parameter nil 'fullscreen))
  (modify-frame-parameters
   (selected-frame) '((user-position . t) (top . 0.5) (left . 0.5))))

;; Highlight matching parentheses
(show-paren-mode 1)

;; Add some padding on the side
(set-fringe-mode 10)

;; Set up the visible bell
(setq visible-bell t)

;; Font settings
(add-to-list 'default-frame-alist '(font . "Iosevka 14"))

;; Enable line numbers for every buffer
(column-number-mode)
(global-display-line-numbers-mode t)

;; Disable line numbers for some modes
(dolist (mode '(eshell-mode-hook
		shell-mode-hook
		term-mode-hook
		vterm-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Setup color theme
(use-package autothemer
  :config
  (add-to-list 'custom-theme-load-path "~/.config/emacs/themes/")
  (load-theme 'catppuccin-frappe t))

;; install ivy for autocompletion
(use-package ivy
  :config
  (ivy-mode 1))

;; install swiper for in-file search
(use-package swiper
  :bind (("C-s" . swiper)))

;; use iBuffer for buffer switching
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; install doom modeline
(use-package doom-modeline
  :init
  (doom-modeline-mode 1))

;; install rainbow delimiters
(use-package rainbow-delimiters
  :hook
  (prog-mode . rainbow-delimiters-mode))

;; install which key
(use-package which-key
  :init
  (which-key-mode)
  :config
  (setq which-key-idle-delay 1))

;; install company
(use-package company
  :init
  (global-company-mode)
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

;; install lsp-mode
(use-package lsp-mode
  :hook
  ((c-mode c++-mode) . lsp-mode))

;; install flycheck
(use-package flycheck
  :init
  (global-flycheck-mode))

;; install clojure mode
(use-package clojure-mode)

;; install cider
(use-package cider)

;; install markdown mode
(use-package markdown-mode
  :mode
  ("README\\.md\\'" . gfm-mode))

;; install vterm
(use-package vterm)

;;; user defined init.el ends here

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ispell-dictionary nil)
 '(package-selected-packages
   '(vterm cider clojure-mode flycheck lsp-mode company which-key rainbow-delimiters doom-modeline ivy use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; init.el ends here
