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
