;;; -*- lexical-binding: t; -*-

(defvar +latex-math-environments '("IEEEeqnarray" "IEEEeqnarray*" "mathpar" "mathpar*"))

(setq texmathp-tex-commands
      (mapcar (lambda (e) `(,e env-on)) +latex-math-environments))
(setq reftex-label-alist
      (mapcar (lambda (e) `(,e ?e nil nil t)) +latex-math-environments))
(after! latex

  ;; Disable prettify in latex-mode
  (appendq! +ligatures-in-modes '(latex-mode))

  (setq +latex-indent-item-continuation-offset 'auto)

  (setq-default TeX-master 'guess)

  (when-let
      (app-path
       (and IS-MAC
            (file-exists-p! (or "/Applications/Skim.app"
                                "~/Applications/Skim.app"))))
    (add-to-list 'TeX-view-program-selection '(output-pdf "Skim"))
    (add-to-list 'TeX-view-program-list
                 (list "Skim" (format "%s/Contents/SharedSupport/displayline -g %%n %%o %%b"
                                      app-path))))

  (add-hook! 'LaTeX-mode-hook
    (defun +latex--add-math-environments-h ()
      (apply #'LaTeX-add-environments
             (mapcar (lambda (e) `(,e LaTeX-env-label)) +latex-math-environments))
      (prependq! font-latex-math-environments +latex-math-environments)))

  (add-hook! 'LaTeX-mode-hook
             #'LaTeX-math-mode
             #'+latex-setup-surround-h
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
