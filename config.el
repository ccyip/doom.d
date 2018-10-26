;;; config.el -*- lexical-binding: t; -*-

(setq-default
 evil-want-abbrev-expand-on-insert-exit nil
 +evil-want-o/O-to-continue-comments nil
 doom-theme 'doom-one
 doom-font (font-spec :family "Fira Code" :size 15)
 ;; doom-font (font-spec :family "Source Code Pro" :size 15)
 ;; doom-font (font-spec :family "Dejavu Sans Mono" :size 15)
 doom-big-font (font-spec :family "Fira Code" :size 20))

(after! evil-snipe
  (evil-snipe-mode -1)
  (evil-snipe-override-mode -1))

(after! company-coq
  (map! :map coq-mode-map
        "<f2>" #'proof-undo-last-successful-command
        "<f3>" #'proof-assert-next-command-interactive
        "<f4>" #'company-coq-proof-goto-point))

(after! tex
  (add-hook 'LaTeX-mode-hook
            (lambda ()
              (LaTeX-add-environments
               '("IEEEeqnarray" LaTeX-env-label)
               '("IEEEeqnarray*" LaTeX-env-label))
              (add-to-list 'font-latex-math-environments "IEEEeqnarray")
              (add-to-list 'font-latex-math-environments "IEEEeqnarray*")))
  (customize-set-variable 'reftex-label-alist
                          '(("IEEEeqnarray" ?e nil nil t)
                            ("IEEEeqnarray*" ?e nil nil t)))
  (customize-set-variable 'texmathp-tex-commands
                          '(("IEEEeqnarray" env-on)
                            ("IEEEeqnarray*" env-on)
                            ("\\inference" arg-on)))
  (customize-set-variable 'font-latex-match-math-command-keywords
                          '(("inference" "[{{"))))


(map! [remap describe-bindings] #'counsel-descbinds
      :nv [tab] #'indent-for-tab-command
      :n "M-t" #'transpose-words
      :gnvime "M-;" #'comment-dwim

      (:after yasnippet
        (:map yas-minor-mode-map
          :v [tab] #'indent-for-tab-command))

      (:after evil-surround
        :v "s" #'evil-surround-region))

(map! :leader
      :desc "Describe bindings" :n "?" #'counsel-descbinds)

(when (featurep! :feature evil +everywhere)
  (evil-define-key* 'insert 'global
    "\C-b" #'backward-char
    "\C-f" #'forward-char
    [M-backspace] #'backward-kill-word)

  (define-key! evil-ex-completion-map
    "\C-b" #'backward-char
    "\C-f" #'forward-char))

(defun +my|fix-minibuffer-in-map (map)
  (define-key! map
    "\C-b" #'backward-char
    "\C-f" #'forward-char))

(mapc #'+my|fix-minibuffer-in-map
      (list minibuffer-local-map
            minibuffer-local-ns-map
            minibuffer-local-completion-map
            minibuffer-local-must-match-map
            minibuffer-local-isearch-map
            read-expression-map))

(after! ivy (+my|fix-minibuffer-in-map ivy-minibuffer-map))
