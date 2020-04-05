;;; -*- lexical-binding: t; -*-

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
             #'evil-latex-textobjects-setup
             #'+latex-setup-surround-h)
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
