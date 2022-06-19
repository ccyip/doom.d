;;; -*- lexical-binding: t; -*-

(defvar +company-box-doc-disabled-modes nil)

(after! company-box
  (defun +company-show-doc-maybe-box ()
    (interactive)
    (if (apply #'derived-mode-p +company-box-doc-disabled-modes)
        (company-show-doc-buffer)
      (company-box-doc-manually)))
  (map! :map company-active-map
        [remap company-show-doc-buffer] #'+company-show-doc-maybe-box))

(after! yasnippet
  (defun +company-complete-or-yas (&optional arg)
    (interactive "p")
    (if (and yas-minor-mode
             (yas-expand))
        (company-abort)
      (company-complete-common-or-cycle arg)))

  (map! :after company
        :map company-active-map
        "TAB" #'+company-complete-or-yas
        [tab] #'+company-complete-or-yas))
