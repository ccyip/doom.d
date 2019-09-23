;;; -*- lexical-binding: t; -*-

;;;###autoload (autoload '+pg/hydra/body "autoload/pg" nil nil)
;;;###autoload (autoload '+pg/hydra/proof-undo-last-successful-command "autoload/pg" nil nil)
;;;###autoload (autoload '+pg/hydra/proof-assert-next-command-interactive "autoload/pg" nil nil)
;;;###autoload (autoload '+pg/hydra/proof-goto-point "autoload/pg" nil nil)
(defhydra +pg/hydra (:hint nil)
  "
[_m_/_._]: goto point [_j_/_]_]: process next command [_k_/_[_]: undo last command [_q_]: quit
"
  ("m" proof-goto-point)
  ("." proof-goto-point)
  ("k" proof-undo-last-successful-command)
  ("[" proof-undo-last-successful-command)
  ("j" proof-assert-next-command-interactive)
  ("]" proof-assert-next-command-interactive)
  ("q" nil :exit t))
