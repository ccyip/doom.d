;;; -*- lexical-binding: t; -*-

(require 'flycheck-posframe)

;;;###autoload
(defun +flycheck-popup-errors ()
  "Show diagnostics popup."
  (interactive)
  (flycheck-posframe-show-posframe
   (+flycheck-errors-cur-line)))

(defun +flycheck-errors-cur-line ()
  "Return the list of errors on the current line."
  (flycheck-overlay-errors-in (point-at-bol) (+ 1 (point-at-eol))))

(defun +flycheck-errors-at-point ()
  "Return the list of errors at point."
  (flycheck-overlay-errors-at (point)))
