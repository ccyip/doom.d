;;; -*- lexical-binding: t; -*-

;;;###autoload
(defun +latex--surround-macro ()
  (let ((macro (evil-surround-read-from-minibuffer "\\")))
    (cons (format "\\%s{" macro) "}")))

;;;###autoload
(defun +latex--surround-quote ()
  (if (or (texmathp)
          (TeX-in-comment))
      (cons "\"" "\"")
    (cons "``" "''")))

;;;###autoload
(defun +latex-setup-surround-h ()
  (after! evil-surround
    (push '(?\" . +latex--surround-quote) evil-surround-pairs-alist)
    (push '(?\\ . ("\\[" . "\\]")) evil-surround-pairs-alist)
    (push '(?m . +latex--surround-macro) evil-surround-pairs-alist)))

;;;; Guess TeX-master
;; Limitations:
;; - assume all files are in the same directory
;; - only support tex and sty files
;; - do not support subfiles package
;; - do not support import package
;; - do not support custom macros
;; - do not handle comments
;; - do not handle other wacky corner cases

(defvar +latex-guess-master-exclude-pattern
  "^_")

(defun +latex--guess-master-excluded (filename)
  (string-match-p +latex-guess-master-exclude-pattern filename))

(defun +latex--buf-search (re)
  (goto-char (point-min))
  (re-search-forward re nil t))

(defun +latex--buf-is-master ()
  (+latex--buf-search "\\\\begin[^{]*{document}"))

(defun +latex--buf-is-parent-of (filename)
  (let ((name (file-name-base filename))
        (ext (file-name-extension filename)))
    (+latex--buf-search
     (pcase ext
       ("tex"
        (concat "\\\\\\(include[^{]*{" name "}"
                "\\|input[^{]*{\\(" name "\\|" filename "\\)}\\)"))
       ("sty"
        (concat "\\\\\\(input[^{]*{" filename "}"
                "\\|usepackage[^{]*{" name "}\\)"))
       (_
        (concat "\\\\\\(input[^{]*{" filename "}"))))))

(defun +latex--get-parent-of (filename dir)
  (let ((files (directory-files dir nil "\\.\\(tex\\|sty\\)" t)))
    (catch 'done
      (dolist (file files nil)
        (when (not (+latex--guess-master-excluded file))
          (with-temp-buffer
            (insert-file-contents file)
            (when (+latex--buf-is-parent-of filename)
              (throw 'done (cons file (+latex--buf-is-master))))))))))

(defun +latex--guess-TeX-master-file ()
  (let ((master nil)
        (filename (file-name-nondirectory buffer-file-name))
        (dir (file-name-directory buffer-file-name))
        (checked nil)
        (done nil)
        (is-master (+latex--buf-is-master)))
    (while (not done)
      (cond
       (is-master
        (setq master filename
              done t))
       ((member filename checked)
        (progn
          (message "Circular LaTeX inclusion detected")
          (setq done t)))
       (t
        (pcase (+latex--get-parent-of filename dir)
          (`(,parent . ,parent-is-master)
           (setq checked (cons filename checked)
                 filename parent
                 is-master parent-is-master))
          (_
           (progn
             (message "No parent found for %s" filename)
             (setq done t)))))))
    master))

;;;###autoload
(defun +latex-guess-TeX-master-file ()
  (save-mark-and-excursion
    (+latex--guess-TeX-master-file)))

;;;###autoload
(defun +latex-guess-TeX-master ()
  (let ((filename (file-name-nondirectory buffer-file-name))
        (master (+latex-guess-TeX-master-file)))
    (cond
     ((and (stringp master) (string= master filename))
      t)
     ((stringp master)
      (file-name-sans-extension master))
     (t
      t))))

;;;###autoload
(defun +latex-maybe-guess-TeX-master-h ()
  (when (eq TeX-master 'guess)
    (message "Guessing TeX-master")
    (setq TeX-master (+latex-guess-TeX-master))))
