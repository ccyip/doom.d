;;; -*- lexical-binding: t; -*-

;;;###autoload
(defmacro +evil-surround-advice (inner-map outer-map)
  (let ((inner-name (intern (format "%s--surround-inner-overlay-a" inner-map)))
        (outer-name (intern (format "%s--surround-outer-overlay-a" outer-map))))
    `(after! evil-surround
       (defadvice! ,inner-name (orig-fn &rest args)
         :around #'evil-surround-inner-overlay
         (let ((evil-inner-text-objects-map ,inner-map))
           (apply orig-fn args)))
       (defadvice! ,outer-name (orig-fn &rest args)
         :around #'evil-surround-outer-overlay
         (let ((evil-outer-text-objects-map ,outer-map))
           (apply orig-fn args))))))
