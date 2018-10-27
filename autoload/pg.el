;;; autoload/pg.el -*- lexical-binding: t; -*-

(setq-default +nav-flash-exclude-commands
              (append '(proof-undo-last-successful-command
                        proof-assert-next-command-interactive
                        proof-goto-point)
                      +nav-flash-exclude-commands))

;;;###autoload (autoload '+proof-motion-hydra/body "autoload/pg" nil nil)
;;;###autoload (autoload '+proof-motion-hydra/proof-undo-last-successful-command "autoload/pg" nil nil)
;;;###autoload (autoload '+proof-motion-hydra/proof-assert-next-command-interactive "autoload/pg" nil nil)
;;;###autoload (autoload '+proof-motion-hydra/proof-goto-point "autoload/pg" nil nil)
(defhydra +proof-motion-hydra (:hint nil)
  "action"
  ("u" proof-undo-last-successful-command "Undo last command")
  ("N" proof-undo-last-successful-command "Undo last command")
  ("n" proof-assert-next-command-interactive "Process next command")
  ("m" proof-goto-point "Goto point")
  ("q" nil "quit"))
