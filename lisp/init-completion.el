;;; init-completion.el --- Completion Ecosystem -*- lexical-binding: t; -*-

;; YASNIPPET
(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1))

;; VERTICO
(use-package vertico
  :init (vertico-mode 1)
  :custom (vertico-cycle t))

;; ORDERLESS
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

;; CONSULT
(use-package consult
  :bind (("C-s" . consult-line)
	 ("C-x b" . consult-buffer)
	 ("M-y" . consult-yank-pop)
	 ("M-g g" . consult-goto-line)))

;; MARGINALIA
(use-package marginalia
  :init (marginalia-mode 1))

;; CORFU
(use-package corfu
  :init
  (global-corfu-mode)
  (corfu-popupinfo-mode)
  :custom
  (corfu-auto t)
  (corfu-auto-prefix 2)
  (corfu-auto-delay 0.1)
  (corfu-cycle t)
  (corfu-preview-current nil)
  (corfu-preselect 'prompt)
  :bind
  (:map corfu-map
	("C-n" . corfu-next)
	("C-p" . corfu-previous)
	("C-y" . corfu-insert)
	("RET" . corfu-insert)
        ("TAB" . corfu-next)
        ([tab] . corfu-next)
        ("S-TAB" . corfu-previous)
        ([backtab] . corfu-previous))
  :config
  (with-eval-after-load 'evil
    (evil-make-overriding-map corfu-map 'insert)))

;; CAPE
(use-package cape
  :init
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block))

;; ICONS FOR CORFU
(use-package kind-icon
  :after corfu
  :custom
  (kind-icon-default-face 'corfu-default)
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

;; EMBARK
(use-package embark
  :bind
  (("C-." . embark-act)
   ("C-;" . embark-dwim)
   ("C-h B" . embark-bindings)))

(use-package embark-consult
  :after (embark consult))

(provide 'init-completion)
;;; init-completion.el ends here
