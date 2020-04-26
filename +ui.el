;;; -*- lexical-binding: t; -*-

(setq doom-font (font-spec :family "Source Code Pro"
                           :size 15)
      doom-unicode-font nil)

(add-hook! 'doom-load-theme-hook :append
  (defun +ui-init-unicode-font-h ()
    (set-fontset-font t 'unicode doom-font)
    (set-fontset-font t 'unicode
                      (font-spec :family "STIX Two Math") nil 'append)))

(add-hook 'window-setup-hook #'toggle-frame-maximized)
