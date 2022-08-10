;;; -*- lexical-binding: t; -*-

(pushnew! doom-detect-indentation-excluded-modes 'coq-mode)
(pushnew! +company-box-doc-disabled-modes 'coq-mode)

;; Fix icons
(after! all-the-icons
  (push '("coq" . "\xe95f") all-the-icons-data/file-icon-alist)
  (push '(coq-mode all-the-icons-fileicon "coq" :face all-the-icons-dyellow) all-the-icons-mode-icon-alist)
  (push '("v" all-the-icons-fileicon "coq" :face all-the-icons-dyellow) all-the-icons-extension-icon-alist))

(setq proof-splash-seen t)
(map! :after coq-mode
      :map coq-mode-map
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
      (:prefix "a"
       "n" #'coq-LocateNotation
       "s" #'coq-Search
       "h" #'coq-PrintHint
       "p" #'coq-show-proof)
      (:prefix ("s" . "store")
       "b" #'proof-store-buffer-win
       "g" #'proof-store-goals-win
       "r" #'proof-store-response-win)
      (:prefix ("o" . "option")
       "A" #'coq-set-printing-all
       "a" #'coq-unset-printing-all
       "I" #'coq-set-printing-implicit
       "i" #'coq-unset-printing-implicit
       "C" #'coq-set-printing-coercions
       "c" #'coq-unset-printing-coercions
       "U" #'coq-set-printing-universes
       "u" #'coq-unset-printing-universes
       ))

(setq coq-may-use-prettify nil)
(setq company-coq-prettify-symbols-alist
      '(("/\\" . ?∧) ("\\/" . ?∨) ("<>" . ?≠)
        ("True" . ?⊤) ("False" . ?⊥)
        ("fun" . ?λ) ("forall" . ?∀) ("exists" . ?∃)
        ("nat" . ?ℕ) ("Prop" . ?ℙ) ("Real" . ?ℝ) ("bool" . ?𝔹)))

(after! coq-mode
  (sp-with-modes 'coq-mode
    (sp-local-pair "(*" "*"
                   :actions '(insert)
                   :post-handlers '(("| " "SPC") (" | " "*"))
                   :unless '(sp-point-before-word-p sp-point-before-same-p))
    (sp-local-pair "<{" "}>"
                   :post-handlers '(("||\n[i]" "RET") ("| " "SPC"))
                   :unless '(sp-point-before-word-p sp-point-before-same-p))))

(add-to-list 'auto-mode-alist '("\\.mlg$" . tuareg-mode))

;; TODO: remove later. `+company-init-backends-h' in
;; `after-change-major-mode-hook' overrides `company-backends' set by
;; `company-coq' package. Until this issue gets fixed upstream, this dirty hack is
;; needed.
(defvar-local +coq--company-backends nil)
(after! company-coq
  (defun +coq--record-company-backends-h ()
    (setq +coq--company-backends company-backends))
  (defun +coq--replay-company-backends-h ()
    (setq company-backends +coq--company-backends))
  (add-hook! 'company-coq-mode-hook
    (defun +coq--fix-company-coq-hack-h ()
      (add-hook! 'after-change-major-mode-hook :local #'+coq--record-company-backends-h)
      (add-hook! 'after-change-major-mode-hook :append :local #'+coq--replay-company-backends-h))))
