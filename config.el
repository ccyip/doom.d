;;; -*- lexical-binding: t; -*-

(setq doom-font (font-spec :family "Source Code Pro" :size 15)
      doom-unicode-font nil
      doom-localleader-key "\\"
      ;; doom-inhibit-indent-detection t
      +evil-want-o/O-to-continue-comments nil
      ;; evil-want-fine-undo t
      company-idle-delay 0
      display-line-numbers-type nil
      flycheck-global-modes nil
      custom-file (concat doom-private-dir "custom.el"))
;; (setq-default cursor-in-non-selected-windows t)

(when (file-exists-p custom-file)
  (load! custom-file))

(add-hook! 'doom-load-theme-hook :append
  (defun +init-unicode-font ()
    (set-fontset-font t 'unicode (font-spec :family "Symbola"))
    (set-fontset-font t 'unicode (font-spec :family "Noto Sans Mono") nil 'prepend)
    (set-fontset-font t 'unicode (font-spec :family "Source Code Pro") nil 'prepend)))

(after! evil-snipe
  (evil-snipe-mode -1))

(map! :n "M-t" #'transpose-words
      :n "C-t" #'pop-tag-mark
      :nv "gy" #'evilnc-copy-and-comment-operator
      :nv [tab] #'indent-for-tab-command
      :g "M-;" #'comment-dwim)

(load! "+textobjects")
(load! "+latex")
(load! "+coq")
