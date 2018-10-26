;;; init.el -*- lexical-binding: t; -*-

(doom! :feature
       debugger
       eval
       (evil
        +everywhere)
       file-templates
       (lookup
        +docsets)
       snippets
       spellcheck
       workspaces

       :completion
       (company
        +auto)
       ivy

       :ui
       doom
       doom-dashboard
       doom-modeline
       doom-quit
       evil-goggles
       hl-todo
       nav-flash
       treemacs
       (popup
        +all
        +defaults)
       vc-gutter
       vi-tilde-fringe
       window-select

       :editor
       multiple-cursors
       rotate-text

       :emacs
       dired
       ediff
       electric
       hideshow
       imenu
       vc

       :tools
       editorconfig
       magit
       pdf

       :lang
       cc
       coq
       data
       emacs-lisp
       (haskell
        +intero)
       (latex
        +latexmk)
       markdown
       ocaml
       (org
        +attach
        +babel
        +capture
        +export
        +present)
       python
       rust
       (sh
        +fish)

       :config
       (default
         +bindings
         +snippets
         +evil-commands))
