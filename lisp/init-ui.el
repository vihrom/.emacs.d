;;; init-ui.el --- UI Configurations -*- lexical-binding: t; -*-

(global-display-line-numbers-mode t)
(electric-pair-mode 1)

;; MOUSE
(xterm-mouse-mode 1)
(mouse-wheel-mode 1)
(setq mouse-wheel-scroll-amount '(2 ((shift) . 1)))
(setq mouse-wheel-progressive-speed nil)
(setq mouse-drag-and-drop-region t)
(setq scroll-margin 5
      scroll-conservatively 101
      scroll-step 3)

;; FONT
(set-face-attribute 'default nil
		    :font "Liberation Mono"
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
  (doom-modeline-indent-info t))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(provide 'init-ui)
;;; init-ui.el ends here
