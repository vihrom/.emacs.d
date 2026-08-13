;;; init-prog.el --- Programming languages, Treesitter & LSP -*- lexical-binding: t; -*-

;; TREESITTER CONFIGURATION
(use-package treesit
  :ensure nil
  :config
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

;; ELDOC
(use-package eldoc
  :ensure nil)

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

;; RUN FUNCTION
(defun my/run-current-file ()
  "Execute current file using its extension."
  (interactive)
  (let* ((file-name (buffer-file-name))
         (ext (file-name-extension file-name))
         (cmd (pcase ext
                ("py" (concat "python3 " file-name))
                ("go" (concat "go run " file-name))
                ("c"  (concat "gcc " file-name " -o out && ./out"))
                ("cpp" (concat "g++ " file-name " -o out && ./out"))
                (_ (read-string "Compile command: ")))))
    (compile cmd)))

(provide 'init-prog)
;;; init-prog.el ends here
