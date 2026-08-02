;;; init-tools.el --- External Tools -*- lexical-binding: t; -*-

;; Projectile
(use-package projectile
  :init (projectile-mode +1)
  :config
  (setq projectile-project-search-path '("~/dev" "~/projects")))

;; Magit
(use-package magit
  :commands magit-status)

;; Project.el
(use-package project
  :ensure nil ;; Встроен в Emacs
  :custom
  (project-vc-extra-root-markers '(".git" "go.mod" "Cargo.toml" "package.json")))
  (project-switch-commands '((project-find-file "Find file" ?f))))

(use-package consult-project-extra
  :bind
  (("C-x p f" . consult-project-extra-find)))

;; Dired
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

;; GIT GUTTER / DIFF-HL (Подсветка изменений)
(use-package diff-hl
  :init
  (global-diff-hl-mode)
  (diff-hl-flydiff-mode)
  :config
  (add-hook 'magit-pre-refresh-hook #'diff-hl-magit-pre-refresh)
  (add-hook 'magit-post-refresh-hook #'diff-hl-magit-post-refresh)

  (unless (display-graphic-p)
    (diff-hl-margin-mode)))

(provide 'init-tools)
;;; init-tools.el ends here
