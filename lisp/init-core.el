;;; init-core.el --- Core settings -*- lexical-binding: t; -*-

;;; Commentary: Essential editor settings, backups, history, and auto-saves.

;;; Code:
;; WARNINGS & NOISE
(setq warning-minimum-level :error)
(setq native-comp-async-report-warnings-errors 'silent)

;; LSP OPTIMIZATION
(setq read-process-output-max (* 1024 1024))

;; BACKUPS & AUTO-SAVE
(setq make-backup-files t)
(let ((backup-dir (expand-file-name "backups/" user-emacs-directory))
      (auto-save-dir (expand-file-name "auto-save/" user-emacs-directory)))

  (unless (file-exists-p backup-dir) (make-directory backup-dir t))
  (unless (file-exists-p auto-save-dir) (make-directory auto-save-dir t))

  (setq backup-directory-alist `((".*" . ,backup-dir)))
  (setq auto-save-file-name-transforms `((".*" ,auto-save-dir t))))

(setq create-lockfiles nil)

;; HISTORY & PERSISTENCE
(savehist-mode 1)
(setq history-length 200)
(setq savehist-additional-variables '(search-ring regexp-search-ring))

(save-place-mode 1)

;; RECENT FILES
(use-package recentf
  :ensure nil
  :init (recentf-mode 1)
  :config
  (setq recentf-max-saved-items 200
	recentf-auto-cleanup 'at-exit))

;; AUTOMATION
(add-hook 'before-save-hook
	  (lambda ()
	    (when buffer-file-name
	      (let ((dir (file-name-directory buffer-file-name)))
		(unless (file-exists-p dir)
		  (make-directory dir t))))))

;; COMPLETION & INDENT
(setq tab-always-indent 'complete)

;; GUI BOXS - off
(setq use-dialog-box nil)

;; PATHS FOR SHELL
(use-package exec-path-from-shell
  :if (memq window-system '(mac ns x pgtk))
  :config
  (exec-path-from-shell-initialize))


(provide 'init-core)
;;; init-core.el ends here
