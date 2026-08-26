;;; early-init.el --- Early Initialization -*- lexical-binding: t; -*-

;;; Commentary: Early startup optimizations.

;;; Code:
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

(setq default-frame-alist
      '((background-color . "#282c34")
        (foreground-color . "#bbc2cf")
        (menu-bar-lines . 0)
        (tool-bar-lines . 0)
        (vertical-scroll-bars . nil)))

(setq frame-inhibit-implied-resize t)
(setq inhibit-startup-screen t)

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 64 1024 1024)
                  gc-cons-percentage 0.1)))

;;; early-init.el ends here
