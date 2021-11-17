;;; -*- lexical-binding: t; -*-

(add-hook 'window-setup-hook #'toggle-frame-maximized)

(setq +font-source-code-pro (font-spec :family "Source Code Pro" :size 18))
(setq +font-jetbrains-mono (font-spec :family "JetBrains Mono" :size 18))
(setq +font-cascadia-code (font-spec :family "Cascadia Code" :size 18))
(setq +font-victor-mono (font-spec :family "Victor Mono" :size 18))
(setq +font-fira-code (font-spec :family "Fira Code" :size 18))
(setq +font-stix (font-spec :family "STIX Two Math"))

(setq doom-font +font-jetbrains-mono
      doom-unicode-font +font-stix)

(add-hook! 'doom-load-theme-hook :append
  (defun +ui-init-unicode-font-h ()
    (set-fontset-font t 'unicode doom-font)
    (set-fontset-font t 'unicode doom-unicode-font nil 'append)))

;; (defun +font-test (font)
;;   (setq doom-font font)
;;   (set-frame-font doom-font)
;;   (+ui-init-unicode-font-h))
