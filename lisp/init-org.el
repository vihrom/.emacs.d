;;; init-org.el --- Org Mode -*- lexical-binding: t; -*-

;;; Commentary: Org-mode settings for notes, todo lists, and agenda.

;;; Code:
;; ORG
(use-package org
  :ensure nil
  :config
  (setq org-directory "~/org")
  (setq org-agenda-files '("~/org/tasks.org"))
  (setq org-log-done 'time)
  (setq org-todo-keywords
	'((sequence "TODO(t)" "IN-PROGRESS(i)" "|" "DONE(d)" "CANCELLED(c)")))
  (setq org-default-notes-file "~/org/tasks.org")
  :bind
  (("C-c c" . org-capture)))

;; EVIL-ORG
(use-package evil-org
  :after org
  :hook (org-mode . evil-org-mode)
  :config
  (add-hook 'evil-org-mode-hook
	    (lambda ()
	      (evil-org-set-key-theme '(navigation insert textobjects additional calendar))))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

;; ORG-SUPERSTAR
(use-package org-superstar
  :after org
  :hook (org-mode . org-superstar-mode)
  :config
  (setq org-superstar-leading-bullet " ")
  (setq org-startup-indented t))

;; ORG-ROAM
(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory "~/org/roam")
  :bind (("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert))
  :config
  (org-roam-db-autosync-mode))

;; AUTO GIT
(use-package git-auto-commit-mode
  :init
  (setq gac-automatically-push-p t)
  :hook (org-mode . git-auto-commit-mode))

(provide 'init-org)
;;; init-org.el ends here
