;;; init-tools.el --- External Tools -*- lexical-binding: t; -*-

;; Project.el
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
  :config
  (add-hook 'dired-mode-hook 'auto-revert-mode))

(use-package dired-open
  :config
  (setq dired-open-extensions '(("png" . "xdg-open")
				("jpg" . "xdg-open")
				("pdf" . "xdg-open"))))

;; Clipboard (xclip)
(unless (display-graphic-p)
  (when (executable-find "xclip")
    (defun my/xclip-copy (text)
      (let ((coding-system-for-write 'utf-8))
	(with-temp-buffer
	  (insert text)
	  (call-process-region (point-min) (point-max)
			       "xclip" nil nil nil
			       "-selection" "clipboard" "-silent"))))

    (defun my/xclip-paste ()
      (let ((coding-system-for-read 'utf-8)
	    (text (shell-command-to-string "xclip -selection clipboard -o")))
	(unless (string-empty-p text)
	  text)))

    (setq interprogram-cut-function 'my/xclip-copy)
    (setq interprogram-paste-function 'my/xclip-paste)))

;; DIFF-HL
(use-package diff-hl
  :ensure t
  :init
  (global-diff-hl-mode 1)
  (diff-hl-flydiff-mode 1)
  :config
  (unless (display-graphic-p)
    (diff-hl-margin-mode 1))
  (add-hook 'magit-pre-refresh-hook #'diff-hl-magit-pre-refresh)
  (add-hook 'magit-post-refresh-hook #'diff-hl-magit-post-refresh))

(use-package undo-fu-session
  :ensure t
  :config
  (global-undo-fu-session-mode)
  (setq undo-fu-session-linear-limit 1000))

(provide 'init-tools)
;;; init-tools.el ends here
