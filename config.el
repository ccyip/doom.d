;;; -*- lexical-binding: t; -*-

(setq doom-font (font-spec :family "Source Code Pro" :size 15)
      doom-unicode-font nil
      ;; doom-inhibit-indent-detection t
      ivy-extra-directories nil
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

(map! :n "M-t" #'transpose-words
      :nm "C-t" #'pop-tag-mark
      :nv "gy" #'evilnc-copy-and-comment-operator
      :m "C-S-o" #'better-jumper-jump-forward
      :nv [tab] #'indent-for-tab-command
      :g "M-;" #'comment-dwim)

(after! latex
  ;; FIXME: find a better way
  (remove-hook 'latex-mode-local-vars-hook #'flyspell-mode!)

  (defadvice! +latex--re-indent-itemize-and-enumerate-a (orig-fn &rest args)
    :around #'LaTeX-fill-region-as-para-do
    (let ((LaTeX-indent-environment-list LaTeX-indent-environment-list))
      (add-to-list 'LaTeX-indent-environment-list '("itemize" +latex/LaTeX-indent-item))
      (add-to-list 'LaTeX-indent-environment-list '("enumerate" +latex/LaTeX-indent-item))
      (apply orig-fn args)))

  (add-hook 'LaTeX-mode-hook #'+latex/add-textobjects)

  (add-hook! 'LaTeX-mode-hook
    (defun +latex/math-environments ()
      (LaTeX-add-environments
       '("IEEEeqnarray" LaTeX-env-label)
       '("IEEEeqnarray*" LaTeX-env-label)
       '("mathpar" LaTeX-env-label)
       '("mathpar*" LaTeX-env-label))
      (add-to-list 'font-latex-math-environments "IEEEeqnarray")
      (add-to-list 'font-latex-math-environments "IEEEeqnarray*")
      (add-to-list 'font-latex-math-environments "mathpar")
      (add-to-list 'font-latex-math-environments "mathpar*")))

  (customize-set-variable 'reftex-label-alist
                          '(("IEEEeqnarray" ?e nil nil t)
                            ("IEEEeqnarray*" ?e nil nil t)))
  (customize-set-variable 'texmathp-tex-commands
                          '(("IEEEeqnarray" env-on)
                            ("IEEEeqnarray*" env-on))))
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
