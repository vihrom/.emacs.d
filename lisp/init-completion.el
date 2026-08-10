;;; init-completion.el --- Completion Ecosystem -*- lexical-binding: t; -*-

;; Vertico (Минибуфер)
(use-package vertico
  :init (vertico-mode 1)
  :custom (vertico-cycle t))

;; Orderless (Стиль поиска: разрозненные слова)
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

;; Consult (Улучшенные C-s, переключение буферов и поиск)
(use-package consult
  :bind (("C-s" . consult-line)
	 ("C-x b" . consult-buffer)
	 ("M-y" . consult-yank-pop)
	 ("M-g g" . consult-goto-line)))

;; Marginalia (Аннотации в минибуфере)
(use-package marginalia
  :init (marginalia-mode 1))

;; Corfu (Всплывающие автодополнения в коде)
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

;; Cape (Источники дополнений для Corfu)
(use-package cape
  :init
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block))

;; Иконки для Corfu
(use-package kind-icon
  :after corfu
  :custom
  (kind-icon-default-face 'corfu-default)
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

;; Embark (Контекстные действия над элементами)
(use-package embark
  :bind
  (("C-." . embark-act)
   ("C-;" . embark-dwim)
   ("C-h B" . embark-bindings)))

(use-package embark-consult
  :after (embark consult))

(provide 'init-completion)
;;; init-completion.el ends here
