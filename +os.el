;;; -*- lexical-binding: t; -*-

(map! :leader
      :prefix "o"
       (:when (modulep! :os macos)
        :desc "Open in Terminal" "t" #'+macos/open-in-term))

(if IS-MAC
    (setq mac-right-option-modifier 'meta))
