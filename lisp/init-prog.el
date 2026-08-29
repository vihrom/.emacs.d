;;; init-prog.el --- Programming languages, Treesitter & LSP -*- lexical-binding: t; -*-

;;; Commentary: Programming language support, hooks, and syntax linting.

;;; Code:
;; TREESITTER CONFIGURATION
(use-package treesit
  :ensure nil
  :config
  (setq treesit-font-lock-level 3))

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

(use-package eglot
  :ensure nil
  :hook
  ((go-ts-mode     . eglot-ensure)
   (python-ts-mode . eglot-ensure)
   (c-ts-mode      . eglot-ensure)
   (c++-ts-mode    . eglot-ensure)
   (rust-ts-mode   . eglot-ensure)
   (lua-ts-mode	   . eglot-ensure))
  :config
  (setq eglot-events-buffer-size 0)
  (add-hook 'eglot-managed-mode-hook
	    (lambda ()
	      (add-hook 'before-save-hook #'eglot-format-buffer nil t))))

;; ELDOC
(use-package eldoc
  :ensure nil
  :custom
  (eldoc-idle-delay 0.5))

;; LANGUAGE SPECIFICS
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
		("rs"  "cargo run")
                (_ (read-string "Compile command: ")))))
    (compile cmd)))

(provide 'init-prog)
;;; init-prog.el ends here
