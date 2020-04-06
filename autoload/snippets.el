;;; -*- lexical-binding: t; -*-

;;;###autoload
(defvaralias '% 'yas-selected-text)

;;;###autoload
(defun +snippets-link-string (s)
  (if (string-empty-p yas-text) "" s))

;;;###autoload
(defun +snippets-expand (name)
  (yas-expand-snippet (yas-lookup-snippet name)))
