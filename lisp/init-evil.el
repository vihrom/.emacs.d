;;; init-evil.el --- Evil mode & Keybindings -*- lexical-binding: t; -*-

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  (setq evil-undo-system 'undo-redo)
  :config
  (evil-mode 1)
  (mouse-wheel-mode 1)
  (setq mouse-wheel-scroll-amount '(2 ((shift) . 1)))
  (setq mouse-wheel-progressive-speed nil)
  (setq mouse-drag-and-drop-region t)
  (define-key evil-normal-state-map [down-mouse-1] 'mouse-drag-region)
  (define-key evil-visual-state-map [down-mouse-1] 'mouse-drag-region))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package which-key
  :config
  (which-key-mode))

;; Функция быстрого запуска текущего файла
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

;; General.el для удобного объявления Leader-клавиш
(use-package general
  :config
  (general-evil-setup t)
  
  (general-create-definer my-leader-def
    :states '(normal visual emacs)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "C-SPC")

  (my-leader-def
    "f"  '(:ignore t :which-key "Files")
    "ff" '(find-file :which-key "Find File")
    "fr" '(consult-recent-file :which-key "Recent Files")
    "fs" '(save-buffer :which-key "Save File")
    
    "b"  '(:ignore t :which-key "Buffers")
    "bb" '(consult-buffer :which-key "Switch Buffer")
    "bk" '(kill-current-buffer :which-key "Kill Buffer")
    
    "p"  '(:ignore t :which-key "Projects")
    "pp" '(projectile-switch-project :which-key "Switch Project")
    "pf" '(projectile-find-file :which-key "Find File in Project")
    "ps" '(consult-ripgrep :which-key "Search Text in Project")

    "g"  '(:ignore t :which-key "Git")
    "gg" '(magit-status :which-key "Magit Status")
    "gb" '(magit-blame :which-key "Magit Blame")

    "c"  '(:ignore t :which-key "Code")
    "cx" '(flycheck-list-errors :which-key "List errors")
    "cn" '(flycheck-next-error :which-key "Next error")
    "cp" '(flycheck-previous-error :which-key "Previous error")

    "m"  '(:ignore t :which-key "Mode")
    "mr" '(my/run-current-file :which-key "Run File")

    "e"  '(:ignore t :which-key "Explorer")
    "ee" '(treemacs :which-key "Toggle Treemacs")
    "ef" '(treemacs-find-file :which-key "Find Current File in Tree")
    
    "o"  '(:ignore t :which-key "Org-mode")
    "oa" '(org-agenda :which-key "Agenda")
    "oc" '(org-capture :which-key "Capture")
    
    "d"  '(:ignore t :which-key "Dired")
    "dd" '(dired :which-key "Open Dired")
    "dj" '(dired-jump :which-key "Jump to Current Directory")

    "s"  '(:ignore t :which-key "Search")
    "ss" '(consult-line :which-key "Search in Buffer")))

(provide 'init-evil)
;;; init-evil.el ends here
