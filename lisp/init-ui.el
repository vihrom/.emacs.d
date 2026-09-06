;;; init-ui.el --- UI Configurations -*- lexical-binding: t; -*-

;;; Commentary: Interface customization, themes, fonts, and modeline.

;;; Code:
(global-display-line-numbers-mode t)
(setq-default display-line-numbers-width 3)

(electric-pair-mode 1)
(setq font-lock-support-mode 'jit-lock-mode)

(setq redisplay-skip-fontification-on-input t)

;; MOUSE
(xterm-mouse-mode 1)
(mouse-wheel-mode 1)
(setq mouse-wheel-scroll-amount '(2 ((shift) . 1)))
(setq mouse-wheel-progressive-speed nil)
(setq mouse-drag-and-drop-region t)

;; FONT
(set-face-attribute 'default nil
		    :font "JetBrainsMono Nerd Font Mono"
		    :height 120
		    :weight 'medium)

;; THEME
(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t
	doom-themes-enable-italic t)
  (load-theme 'doom-gruvbox t)
  (doom-themes-org-config))

(use-package doom-modeline
  :hook (after-init . doom-modeline-mode)
  :custom
  (doom-modeline-height 28)
  (doom-modeline-bar-width 4)
  (doom-modeline-icon t)
  (doom-modeline-major-mode-icon t)
  (doom-modeline-indent-info nil))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(provide 'init-ui)
;;; init-ui.el ends here
