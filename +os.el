;;; -*- lexical-binding: t; -*-

(map! :leader
      :prefix "o"
       (:when (featurep! :os macos)
        :desc "Open in Terminal" "t" #'+macos/open-in-term))
