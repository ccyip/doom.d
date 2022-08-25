;;; -*- lexical-binding: t; -*-

(doom! :completion
       company
       (vertico +icons)

       :ui
       doom
       doom-dashboard
       ;;doom-quit
       hl-todo
       hydra
       modeline
       ;;nav-flash
       ophints
       (popup +all +defaults)
       ligatures
       vi-tilde-fringe
       window-select
       workspaces
       zen

       :editor
       (evil +everywhere)
       fold
       format
       ;;lispy
       multiple-cursors
       ;;objed
       ;;parinfer
       rotate-text
       snippets

       :emacs
       dired
       electric
       undo
       vc

       :checkers
       (syntax +childframe)
       spell
       ;;grammar

       :tools
       ;;debugger
       ;;editorconfig
       (eval +overlay)
       (lookup +dictionary +docsets)
       lsp
       magit
       ;;pdf

       :os
       (:if IS-MAC macos)

       :lang
       (agda +local)
       ;;cc
       coq
       data
       emacs-lisp
       ;;fstar
       (haskell +lsp)
       ;;idris
       ;;javascript
       (latex +latexmk)
       ;;lean
       markdown
       ocaml
       ;;org
       python
       ;;rust
       ;;scala
       (sh +fish)
       yaml

       :config
       (default +bindings +smartparens))
