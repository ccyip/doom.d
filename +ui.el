;;; -*- lexical-binding: t; -*-

(add-hook 'window-setup-hook #'toggle-frame-maximized)

(setq +font-size 18)

(setq +font-source-code-pro "Source Code Pro")
(setq +font-jetbrains-mono "JetBrains Mono")
(setq +font-cascadia-code "Cascadia Code")
(setq +font-victor-mono "Victor Mono")
(setq +font-fira-code "Fira Code")
(setq +font-comic-code "Comic Code Ligatures")
(setq +font-stix "STIX Two Math")

(setq doom-font (font-spec :family +font-comic-code :size +font-size)
      doom-unicode-font (font-spec :family +font-stix))

(add-hook! 'after-setting-font-hook :append
  (defun +ui-tweak-unicode-font-h ()
    (set-fontset-font t 'unicode doom-font nil 'prepend)))

;; (defun +font-test (font sz)
;;   (setq doom-font (font-spec :family font :size sz))
;;   (set-frame-font doom-font)
;;   (+ui-tweak-unicode-font-h))
