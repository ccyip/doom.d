;;; -*- lexical-binding: t; -*-

;; Disable flycheck by default
(setq flycheck-global-modes nil)

;; Disable spell checker by default
(remove-hook 'text-mode-hook #'spell-fu-mode)

(map! :after flycheck
      :map flycheck-mode-map
      :nv "gH" #'+flycheck-popup-errors)

;; Disable flycheck's auto-popup
(after! flycheck
  (setq flycheck-display-errors-function nil)
  (remove-hook 'flycheck-mode-hook #'+syntax-init-popups-h))

(after! flycheck-posframe
  (setq flycheck-posframe-warning-prefix ""
        flycheck-posframe-info-prefix ""
        flycheck-posframe-error-prefix ""
        flycheck-posframe-border-width 1)
  (set-face-foreground 'flycheck-posframe-border-face "white"))
