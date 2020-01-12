;;; -*- lexical-binding: t; -*-

(doom! :completion
       company
       ivy

       :ui
       doom
       doom-dashboard
       doom-quit
       hl-todo
       modeline
       ;;nav-flash
       ophints
       (popup +all +defaults)
       ;;pretty-code
       vi-tilde-fringe
       window-select
       workspaces

       :editor
       (evil +everywhere)
       fold
       ;;lispy
       multiple-cursors
       ;;objed
       ;;parinfer
       rotate-text
       snippets

       :emacs
       dired
       electric
       vc

       :checkers
       syntax
       spell
       ;;grammar

       :tools
       ;;debugger
       editorconfig
       (eval +overlay)
       (lookup +docsets)
       ;;lsp
       magit
       ;;pdf

       :lang
       ;;agda
       ;;cc
       coq
       data
       emacs-lisp
       haskell
       ;;idris
       ;;javascript
       (latex +latexmk)
       ;;lean
       markdown
       ;;ocaml
       org
       ;;python
       ;;rust
       ;;scala
       (sh +fish)

       :config
       (default +bindings +smartparens))
