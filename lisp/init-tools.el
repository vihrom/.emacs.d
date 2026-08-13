;;; init-tools.el --- External Tools -*- lexical-binding: t; -*-

;; PROJECT.EL
(use-package project
  :ensure nil
  :custom
  (project-vc-extra-root-markers '(".git" "go.mod" "Cargo.toml" "package.json"))
  (project-switch-commands '((project-find-file "Find file" ?f))))

;; MAGIT
(use-package magit
  :commands magit-status)

;; TREEMACS
(use-package treemacs
  :defer t
  :config
  (setq treemacs-width 30
	treemacs-is-never-other-window nil)
  (treemacs-project-follow-mode t)
  (treemacs-filewatch-mode t))

(use-package treemacs-evil
  :after (treemacs evil))

;; DIRED
(use-package dired
  :ensure nil
  :custom
  (dired-listing-switches "-agho --group-directories-first")
  (dired-recursive-deletes 'top)
  (dired-recursive-copies 'always)
  (dired-kill-when-opening-new-buffers t)
  (wdired-allow-to-change-permissions t)
  :config
  (evil-define-key 'normal dired-mode-map
    (kbd "l") 'dired-find-file
    (kbd "R") 'wdired-change-to-wdired-mode
    (kbd "h") 'dired-up-directory))

(use-package autorevert
  :ensure nil
  :init
  (global-auto-revert-mode 1)
  :custom
  (global-auto-revert-non-file-buffers t)
  (auto-revert-verbose nil))

(use-package nerd-icons-dired
  :ensure t
  :hook
  (dired-mode . nerd-icons-dired-mode))

(use-package dired-open
  :config
  (setq dired-open-extensions '(("png" . "xdg-open")
				("jpg" . "xdg-open")
				("pdf" . "xdg-open")))
  (add-to-list 'dired-open-functions #'dired-open-by-extension))

;; CLIPBOARD (xclip)
(use-package xclip
  :config
  (xclip-mode 1))

;; DIFF-HL
(use-package diff-hl
  :init
  (global-diff-hl-mode 1)
  (diff-hl-flydiff-mode 1)
  :config
  (unless (display-graphic-p)
    (diff-hl-margin-mode 1))
  (add-hook 'magit-pre-refresh-hook #'diff-hl-magit-pre-refresh)
  (add-hook 'magit-post-refresh-hook #'diff-hl-magit-post-refresh))

;; UNDO-FU-SESSION
(use-package undo-fu-session
  :config
  (global-undo-fu-session-mode)
  (setq undo-fu-session-linear-limit 1000))

(provide 'init-tools)
;;; init-tools.el ends here
