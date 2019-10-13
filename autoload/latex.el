;;; -*- lexical-binding: t; -*-

(require 'evil-latex-textobjects)

;;;###autoload
(defun +latex/surround-macro ()
  (let ((macro (evil-surround-read-from-minibuffer "\\")))
    (cons (format "\\%s{" macro) "}")))

;;;###autoload
(defun +latex/add-textobjects ()
  (define-key evil-inner-text-objects-map "$" 'evil-latex-textobjects-inner-dollar)
  (define-key evil-outer-text-objects-map "$" 'evil-latex-textobjects-a-dollar)
  (define-key evil-inner-text-objects-map "\\" 'evil-latex-textobjects-inner-math)
  (define-key evil-outer-text-objects-map "\\" 'evil-latex-textobjects-a-math)
  (define-key evil-outer-text-objects-map "m" 'evil-latex-textobjects-a-macro)
  (define-key evil-inner-text-objects-map "m" 'evil-latex-textobjects-inner-macro)
  (define-key evil-outer-text-objects-map "e" 'evil-latex-textobjects-an-env)
  (define-key evil-inner-text-objects-map "e" 'evil-latex-textobjects-inner-env)

  (after! evil-surround
    (push '(?\\ . ("\\[" . "\\]")) evil-surround-pairs-alist)
    (push '(?m . +latex/surround-macro) evil-surround-pairs-alist)))
