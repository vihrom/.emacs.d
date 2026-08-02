;;; init-tools.el --- External Tools -*- lexical-binding: t; -*-

;; Projectile
(use-package projectile
  :init (projectile-mode +1)
  :config
  (setq projectile-project-search-path '("~/dev" "~/projects")))

;; Magit
(use-package magit
  :commands magit-status)

;; Treemacs
(use-package treemacs
  :defer t
  :config
  (setq treemacs-width 30
        treemacs-is-never-other-window t)
  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t)
  (treemacs-project-follow-mode t))

(use-package treemacs-projectile
  :after (treemacs projectile))

(use-package treemacs-evil
  :after (treemacs evil))

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

;; Терминальный clipboard (xclip)
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

(provide 'init-tools)
;;; init-tools.el ends here
