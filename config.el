;;; -*- lexical-binding: t; -*-

(setq doom-font (font-spec :family "Source Code Pro" :size 15)
      doom-unicode-font nil
      ;; doom-inhibit-indent-detection t
      +evil-want-o/O-to-continue-comments nil
      ;; evil-want-fine-undo t
      display-line-numbers-type nil
      flycheck-global-modes nil
      custom-file (concat doom-private-dir "custom.el"))

(when (file-exists-p custom-file)
  (load! custom-file))

(add-hook! 'doom-load-theme-hook :append
  (defun +init-unicode-font ()
    (set-fontset-font t 'unicode (font-spec :family "Symbola"))
    (set-fontset-font t 'unicode (font-spec :family "Noto Sans Mono") nil 'prepend)
    (set-fontset-font t 'unicode (font-spec :family "Source Code Pro") nil 'prepend)))

(after! evil-snipe
  (evil-snipe-mode -1))

;; FIXME: find a better way to disable flyspell-mode
(remove-hook 'text-mode-hook #'flyspell-mode)

(map! :n "M-t" #'transpose-words
      :nm "C-t" #'pop-tag-mark
      :nv "gy" #'evilnc-copy-and-comment-operator
      :m "C-S-o" #'better-jumper-jump-forward
      :nv [tab] #'indent-for-tab-command
      :g "M-;" #'comment-dwim)

(defvar +latex/math-environments '("IEEEeqnarray" "IEEEeqnarray*" "mathpar" "mathpar*"))

(setq texmathp-tex-commands
      (seq-map (lambda (e) `(,e env-on)) +latex/math-environments))
(setq reftex-label-alist
      (seq-map (lambda (e) `(,e ?e nil nil t)) +latex/math-environments))
(after! latex
  ;; FIXME: reftex completion
  ;; FIXME: next error
  ;; FIXME: synctex

  ;; FIXME: find a better way to disable flyspell-mode
  (remove-hook 'latex-mode-local-vars-hook #'flyspell-mode!)

  (add-hook! 'LaTeX-mode-hook
    (defun +latex/add-math-environments ()
      (apply #'LaTeX-add-environments
             (seq-map (lambda (e) `(,e LaTeX-env-label)) +latex/math-environments))
      (prependq! font-latex-math-environments +latex/math-environments)))

  (add-hook! 'LaTeX-mode-hook
             #'turn-off-auto-fill
             #'LaTeX-math-mode
             #'+latex/add-textobjects))
;; TODO: add more keybindings
(map! :after latex
      :map LaTeX-mode-map
      :localleader
      "m" #'TeX-command-run-all
      "e" #'LaTeX-environment)

(setq proof-splash-seen t
      proof-electric-terminator-enable nil
      company-coq-disabled-features '(hello))
(map! :after pg-user
      :map proof-mode-map
      "<f2>" #'proof-undo-last-successful-command
      "<f3>" #'proof-assert-next-command-interactive
      "<f4>" #'proof-goto-point
      :localleader
      "m" #'+pg/hydra/proof-goto-point
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
