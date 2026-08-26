;;; init-evil.el --- Evil mode configuration -*- lexical-binding: t; -*-

;;; Commentary: Vim modal editing emulation and key states.

;;; Code:
;; UNDO-FU
(use-package undo-fu)

(use-package reverse-im
  :demand t
  :custom
  (reverse-im-input-methods '("russian-computer"))
  :config
  (reverse-im-mode t))

;; EVIL
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  (setq evil-want-C-i-jump nil)
  (setq evil-undo-system 'undo-fu)
  :config
  (evil-mode 1)
  (define-key evil-normal-state-map [down-mouse-1] 'mouse-drag-region)
  (define-key evil-visual-state-map [down-mouse-1] 'mouse-drag-region))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(provide 'init-evil)
;;; init-evil.el ends here
