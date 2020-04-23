;;; -*- lexical-binding: t; -*-

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
