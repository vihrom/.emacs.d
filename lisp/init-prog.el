;;; init-prog.el --- Programming languages, Treesitter & LSP -*- lexical-binding: t; -*-

;; TREESITTER CONFIGURATION
(use-package treesit
  :ensure nil
  :config
  (setq treesit-language-source-alist
	'((bash       "https://github.com/tree-sitter/tree-sitter-bash")
	  (c          "https://github.com/tree-sitter/tree-sitter-c")
	  (cpp        "https://github.com/tree-sitter/tree-sitter-cpp")
	  (go         "https://github.com/tree-sitter/tree-sitter-go")
	  (gomod      "https://github.com/camdencheek/tree-sitter-go-mod")
	  (json       "https://github.com/tree-sitter/tree-sitter-json")
	  (make       "https://github.com/alemuller/tree-sitter-make")
	  (markdown   "https://github.com/ikatyang/tree-sitter-markdown")
	  (python     "https://github.com/tree-sitter/tree-sitter-python")
	  (yaml       "https://github.com/ikatyang/tree-sitter-yaml")))

  (setq treesit-font-lock-level 4))

(use-package treesit-auto
  :demand t
  :config
  (global-treesit-auto-mode))

;; LSP (EGLOT)
(use-package flymake
  :ensure nil
  :hook (prog-mode . flymake-mode)
  :bind (:map flymake-mode-map
	      ("M-n" . flymake-goto-next-error)
	      ("M-p" . flymake-goto-prev-error)))

(add-to-list 'major-mode-remap-alist '(c-mode . c-ts-mode))
(add-to-list 'major-mode-remap-alist '(c++-mode . c++-ts-mode))

(use-package eglot
  :ensure nil
  :hook
  ((go-ts-mode     . eglot-ensure)
   (python-ts-mode . eglot-ensure)
   (c-ts-mode      . eglot-ensure)
   (c++-ts-mode    . eglot-ensure))
  :config
  (add-hook 'eglot-managed-mode-hook
	    (lambda ()
	      (add-hook 'before-save-hook #'eglot-format-buffer nil t))))

;; LANGUAGE SPECIFICS
;; Go
(use-package go-ts-mode
  :ensure nil
  :mode ("\\.go\\'" . go-ts-mode))

;; Python
(use-package python
  :ensure nil
  :custom
  (python-shell-interpreter "python3"))

;; C / C++
(setq-default c-basic-offset 4)

(provide 'init-prog)
;;; init-prog.el ends here
