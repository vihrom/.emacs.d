;;; mail-config.el --- mu4e, msmtp  -*- lexical-binding: t; -*-

(add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e")
(require 'mu4e)

(setq mu4e-maildir "~/Mail"
      mu4e-get-mail-command "mbsync -a"
      mu4e-update-interval (* 5 60)
      mu4e-change-filenames-when-moving t)

(setq mu4e-drafts-folder "/gmail/[Gmail]/Drafts"
      mu4e-sent-folder   "/gmail/[Gmail]/Sent Mail"
      mu4e-trash-folder  "/gmail/[Gmail]/Trash"
      mu4e-refile-folder "/gmail/[Gmail]/All Mail")

(setq mu4e-bookmarks
      '((:name "Unread messages" :query "flag:unread AND NOT flag:trashed" :key ?u)
        (:name "Today's messages" :query "date:today..now"                   :key ?t)
        (:name "Inbox"            :query "maildir:/gmail/INBOX"             :key ?i)
        (:name "Sent Mail"        :query "maildir:\"/gmail/[Gmail]/Sent Mail\"" :key ?s)
        (:name "Drafts"           :query "maildir:\"/gmail/[Gmail]/Drafts\""    :key ?d)
        (:name "All Mail"         :query "maildir:\"/gmail/[Gmail]/All Mail\""  :key ?a)))

(setq send-mail-function 'sendmail-send-it
      message-send-mail-function 'sendmail-send-it
      sendmail-program "/usr/bin/msmtp"
      message-sendmail-f-is-evil t
      message-sendmail-extra-arguments '("--read-envelope-from"))

(auth-source-pass-enable)

(provide 'mail-config)
;;; mail-config.el ends here
