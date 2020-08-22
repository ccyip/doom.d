;;; -*- lexical-binding: t; -*-

(setq doom-localleader-key "\\"
      ;; doom-inhibit-indent-detection t
      +evil-want-o/O-to-continue-comments nil
      ;; evil-want-fine-undo t
      company-idle-delay 0
      display-line-numbers-type nil
      flycheck-global-modes nil)
;; (setq-default cursor-in-non-selected-windows t)

(map! :n "M-t" #'transpose-words
      :n "C-t" #'pop-tag-mark
      :nv "gy" #'evilnc-copy-and-comment-operator
      :n [tab] #'indent-for-tab-command
      :v [tab] #'yas-insert-snippet
      :g "M-;" #'comment-dwim)

(map! :after company
      :map company-active-map
      "TAB" nil
      [tab] nil
      "C-SPC" #'company-complete-common-or-cycle)

(load! "+ui")
(load! "+latex")
(load! "+coq")
