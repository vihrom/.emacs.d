;;; init-org.el --- Org Mode -*- lexical-binding: t; -*-

(use-package org
  :ensure nil
  :config
  (setq org-directory "~/org")
  (setq org-agenda-files '("~/org/tasks.org"))
  (setq org-log-done 'time)
  (setq org-todo-keywords
        '((sequence "TODO(t)" "IN-PROGRESS(i)" "|" "DONE(d)" "CANCELLED(c)"))))

(use-package evil-org
  :after org
  :hook (org-mode . evil-org-mode)
  :config
  (add-hook 'evil-org-mode-hook
            (lambda ()
              (evil-org-set-key-theme '(navigation insert textobjects additional calendar))))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(use-package org-superstar
  :after org
  :hook (org-mode . org-superstar-mode))

(provide 'init-org)
;;; init-org.el ends here
