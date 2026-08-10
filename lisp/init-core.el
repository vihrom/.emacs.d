;;; init-core.el --- Core settings -*- lexical-binding: t; -*-

(setq warning-minimum-level :error)
(setq native-comp-async-report-warnings-errors 'silent)

(setq make-backup-files t)
(let ((backup-dir (expand-file-name "backups/" user-emacs-directory))
      (auto-save-dir (expand-file-name "auto-save/" user-emacs-directory)))

  (unless (file-exists-p backup-dir) (make-directory backup-dir t))
  (unless (file-exists-p auto-save-dir) (make-directory auto-save-dir t))

  (setq backup-directory-alist `((".*" . ,backup-dir)))
  (setq auto-save-file-name-transforms `((".*" ,auto-save-dir t))))

(setq create-lockfiles nil)

(savehist-mode 1)
(setq history-length 1000)
(setq savehist-additional-variables '(kill-ring search-ring regexp-search-ring))

(save-place-mode 1)

(use-package recentf
  :ensure nil
  :init (recentf-mode 1)
  :config
  (setq recentf-max-saved-items 500
	recentf-auto-cleanup 'never))

(add-hook 'before-save-hook
	  (lambda ()
	    (when buffer-file-name
	      (let ((dir (file-name-directory buffer-file-name)))
		(unless (file-exists-p dir)
		  (make-directory dir t))))))

(setq tab-always-indent 'complete)

(provide 'init-core)
;;; init-core.el ends here
