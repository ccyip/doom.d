;;; -*- lexical-binding: t; -*-

(defvar-local +evil-local-inner-text-objects-map nil)
(defvar-local +evil-local-outer-text-objects-map nil)

(after! evil-surround
  (defadvice! +evil-local--surround-inner-overlay-a (orig-fn &rest args)
    :around #'evil-surround-inner-overlay
    (let ((evil-inner-text-objects-map
           (if (keymapp +evil-local-inner-text-objects-map)
               +evil-local-inner-text-objects-map
             evil-inner-text-objects-map)))
      (apply orig-fn args)))
  (defadvice! +evil-local--surround-outer-overlay-a (orig-fn &rest args)
    :around #'evil-surround-outer-overlay
    (let ((evil-outer-text-objects-map
           (if (keymapp +evil-local-outer-text-objects-map)
               +evil-local-outer-text-objects-map
             evil-outer-text-objects-map)))
      (apply orig-fn args))))
