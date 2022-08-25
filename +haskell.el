;;; -*- lexical-binding: t; -*-

(after! haskell-mode
  (add-hook 'haskell-mode-hook #'rainbow-delimiters-mode)
  (setq lsp-haskell-plugin-ghcide-completions-config-auto-extend-on nil
        lsp-haskell-plugin-ghcide-completions-config-snippets-on nil))
