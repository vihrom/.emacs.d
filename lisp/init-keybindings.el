;;; init-keybindings.el --- Global Keybindings & Leader Map -*- lexical-binding: t; -*-

;;; Commentary: Global keymaps, custom shortcuts, and leader keys.

;;; Code:
;; WHICH-KEY
(use-package which-key
  :init
  (which-key-mode 1)
  :custom
  (which-key-popup-type 'side-window)
  (which-key-side-window-location 'bottom)
  (which-key-side-window-max-height 0.25)
  (which-key-separator " ➜ ")
  (which-key-prefix-prefix "+")
  (which-key-max-description-length 32)
  (which-key-add-column-padding 2)
  (which-key-max-display-columns nil)
  (which-key-sort-order 'which-key-key-order-alpha)
  (which-key-idle-delay 0.2)
  :config
  (which-key-setup-side-window-bottom))

;; GENERAL
(use-package general
  :after evil
  :config
  (general-evil-setup t)

  (general-def :states 'normal
    "K" #'eldoc-print-current-symbol-info)

  (general-create-definer my-leader-def
    :states '(normal visual emacs)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "C-SPC")

;; LEADER
  (my-leader-def
    ;; FILES
    "f"  '(:ignore t :which-key "Files")
    "ff" '(find-file :which-key "Find File")
    "fr" '(consult-recent-file :which-key "Recent Files")
    "fs" '(save-buffer :which-key "Save File")

    ;; BUFFERS
    "b"  '(:ignore t :which-key "Buffers")
    "bb" '(consult-buffer :which-key "Switch Buffer")
    "bk" '(kill-current-buffer :which-key "Kill Buffer")
    "bs" '(consult-line :which-key "Search in Buffer")

    ;; PROJECTS
    "p"  '(:ignore t :which-key "Projects")
    "pp" '(project-switch-project :which-key "Switch Project")
    "pf" '(project-find-file :which-key "Find File in Project")
    "pb" '(project-switch-to-buffer :which-key "Project Buffer")
    "ps" '(consult-ripgrep :which-key "Search Text (Ripgrep)")
    "pk" '(project-kill-buffers :which-key "Kill Project Buffers")

    ;; GIT
    "g"  '(:ignore t :which-key "Git")
    "gg" '(magit-status :which-key "Magit Status")
    "gb" '(magit-blame :which-key "Magit Blame")
    "gn" '(diff-hl-next-hunk :which-key "Next Change")
    "gp" '(diff-hl-previous-hunk :which-key "Prev Change")
    "gr" '(diff-hl-revert-hunk :which-key "Revert Change")

    ;; ERRORS
    "c"  '(:ignore t :which-key "Code")
    "cx" '(consult-flymake :which-key "List Errors")
    "cl" '(flymake-show-buffer-diagnostics :which-key "Show Diagnostics Buffer")

    ;; MODE
    "m"  '(:ignore t :which-key "Mode")
    "mr" '(my/run-current-file :which-key "Run File")

    ;; EXPLORER
    "e"  '(:ignore t :which-key "Explorer")
    "ee" '(treemacs :which-key "Toggle Treemacs")
    "ef" '(treemacs-find-file :which-key "Find Current File in Tree")

    ;; ORG
    "o"  '(:ignore t :which-key "Org-mode")
    "oa" '(org-agenda :which-key "Agenda")
    "oc" '(org-capture :which-key "Capture")
    "of" '((lambda () (interactive) (find-file (read-file-name "Find Org file: " "~/org/"))) :which-key "Find Org File")
    "os" '((lambda () (interactive) (consult-ripgrep "~/org/")) :which-key "Search in Org")

    ;; ORG-ROAM
    "or" '(:ignore t :which-key "Org-Roam")
    "orf" '(org-roam-node-find :which-key "Find Node / Note")
    "ori" '(org-roam-node-insert :which-key "Insert Link to Note")
    "orc" '(org-roam-capture :which-key "Roam Capture")
    "org" '(org-roam-ui-mode :which-key "Toggle Graph View View")

    ;; DIRED
    "d"  '(:ignore t :which-key "Dired")
    "dd" '(dired :which-key "Open Dired")
    "dj" '(dired-jump :which-key "Jump to Current Directory")))

(provide 'init-keybindings)
;;; init-keybindings.el ends here
