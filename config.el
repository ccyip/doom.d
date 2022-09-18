;;; -*- lexical-binding: t; -*-

(setq doom-localleader-key "\\"
      doom-localleader-alt-key "M-SPC \\"
      +evil-want-o/O-to-continue-comments nil
      ;; evil-want-fine-undo t
      company-idle-delay 0
      company-box-doc-enable nil
      fill-column 70
      display-line-numbers-type nil
      confirm-kill-emacs nil)
(setq-default truncate-lines nil)

(use-package! evil-nerd-commenter
  :commands evilnc-copy-and-comment-operator)

(map! :n "M-t" #'transpose-words
      :n "C-t" #'transpose-chars
      :nv "gy" #'evilnc-copy-and-comment-operator
      :g "M-;" #'comment-dwim)

(load! "+ui")
(load! "+completion")
(load! "+checker")
(load! "+lsp")
(load! "+latex")
(load! "+coq")
(load! "+haskell")
(load! "+os")
