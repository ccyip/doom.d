;;; -*- lexical-binding: t; -*-

;; Disable flycheck by default
(setq flycheck-global-modes nil)

;; Disable spell checker by default
(remove-hook 'text-mode-hook #'spell-fu-mode)
