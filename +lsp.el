;;; -*- lexical-binding: t; -*-

(after! lsp-ui
  (setq lsp-ui-doc-show-with-mouse t)
  ;; Side line is quite annoying
  (setq lsp-ui-sideline-enable nil))

(map! :after lsp-ui-doc
      :map lsp-mode-map
      :nv "gh" #'lsp-ui-doc-glance
      :nv "gH" #'+flycheck-popup-errors)
