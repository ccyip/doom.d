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

;; Latex
(defvar +latex-math-environments '("IEEEeqnarray" "IEEEeqnarray*" "mathpar" "mathpar*"))

(setq texmathp-tex-commands
      (mapcar (lambda (e) `(,e env-on)) +latex-math-environments))
(setq reftex-label-alist
      (mapcar (lambda (e) `(,e ?e nil nil t)) +latex-math-environments))
(after! latex
  (setq-default TeX-master 'guess)

  (unsetq-hook! LaTeX-mode TeX-command-default)
  (remove-hook! TeX-mode #'flyspell-mode)

  (add-hook! 'LaTeX-mode-hook
    (defun +latex--add-math-environments-h ()
      (apply #'LaTeX-add-environments
             (mapcar (lambda (e) `(,e LaTeX-env-label)) +latex-math-environments))
      (prependq! font-latex-math-environments +latex-math-environments)))

  (add-hook! 'LaTeX-mode-hook
             #'turn-off-auto-fill
             #'LaTeX-math-mode
             #'+latex-add-textobjects-h)
  (add-hook! 'latex-mode-local-vars-hook
             #'+latex-maybe-guess-TeX-master-h))
(map! :after latex
      :map LaTeX-mode-map
      :localleader
      "\\" #'TeX-command-run-all
      "e" #'LaTeX-environment
      "RET" #'TeX-insert-macro
      "n" #'TeX-normal-mode
      "/" #'reftex-index-selection-or-word
      "f" #'TeX-font
      "k" #'TeX-kill-job
      "l" #'TeX-recenter-output-buffer
      "c" #'TeX-command-master
      "b" #'TeX-command-buffer
      "r" #'TeX-command-region
      "s" #'LaTeX-section
      "]" #'LaTeX-close-environment)

;; Coq
(setq proof-splash-seen t)
(map! :after pg-user
      :map proof-mode-map
      "<f2>" #'proof-undo-last-successful-command
      "<f3>" #'proof-assert-next-command-interactive
      "<f4>" #'proof-goto-point
      :localleader
      "\\" #'+pg/hydra/proof-goto-point
      "." #'+pg/hydra/proof-goto-point
      "N" #'+pg/hydra/proof-undo-last-successful-command
      "[" #'+pg/hydra/proof-undo-last-successful-command
      "n" #'+pg/hydra/proof-assert-next-command-interactive
      "]" #'+pg/hydra/proof-assert-next-command-interactive
      (:prefix ("s" . "store")
        "b" #'proof-store-buffer-win
        "g" #'proof-store-goals-win
        "r" #'proof-store-response-win))
(map! :after coq-mode
      :map coq-mode-map
      :localleader
      (:prefix "a"
        "n" #'coq-LocateNotation))
