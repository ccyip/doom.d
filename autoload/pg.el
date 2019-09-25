;;; -*- lexical-binding: t; -*-

;;;###autoload (autoload '+pg/hydra/body "autoload/pg" nil nil)
;;;###autoload (autoload '+pg/hydra/proof-undo-last-successful-command "autoload/pg" nil nil)
;;;###autoload (autoload '+pg/hydra/proof-assert-next-command-interactive "autoload/pg" nil nil)
;;;###autoload (autoload '+pg/hydra/proof-goto-point "autoload/pg" nil nil)
(defhydra +pg/hydra (:hint nil)
  "
[_m_/_._]: goto point [_n_/_]_]: process next command [_N_/_[_]: undo last command [_q_]: quit
"
  ("m" proof-goto-point)
  ("." proof-goto-point)
  ("N" proof-undo-last-successful-command)
  ("[" proof-undo-last-successful-command)
  ("n" proof-assert-next-command-interactive)
  ("]" proof-assert-next-command-interactive)
  ("q" nil :exit t))
