;;; init.el --- Emacs Main Configuration -*- lexical-binding: t; -*-

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(require 'package)
(setq package-archives '(("melpa"   . "https://melpa.org/packages/")
			 ("gnu"     . "https://elpa.gnu.org/packages/")
			 ("nongnu"  . "https://elpa.nongnu.org/nongnu/")))
(package-initialize)

(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

(setq use-short-answers t)

(require 'init-core)
(require 'init-ui)
(require 'init-completion)
(require 'init-evil)
(require 'init-tools)
(require 'init-prog)
(require 'init-org)
(require 'init-keybindings)
(require 'mail-config)

(provide 'init)
;;; init.el ends here
