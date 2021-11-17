;;; -*- lexical-binding: t; -*-

(setq doom-localleader-key "\\"
      +evil-want-o/O-to-continue-comments nil
      ;; evil-want-fine-undo t
      company-idle-delay 0
      display-line-numbers-type nil
      confirm-kill-emacs nil)
;; (setq-default cursor-in-non-selected-windows t)

(map! :n "M-t" #'transpose-words
      :n "C-t" #'pop-tag-mark
      :nv "gy" #'evilnc-copy-and-comment-operator
      :g "M-;" #'comment-dwim)

(map! :after company
      :map company-active-map
      "TAB" nil
      [tab] nil)

(load! "+ui")
(load! "+checker")
(load! "+latex")
(load! "+coq")
(load! "+os")
