;;;; package --- Summary
;; Compile configuration, by Anton Augustsson

;;; Commentary:
;; Automaticly write the compile command depending on what language mode your in
;; It also automaticly writes the name on the file your curently in

(provide 'compileConfiguration)

;;; Code:
;; To automaticly sugest a compile comand

;; Compile guess language and automaticly sugest command
(require 'compile)
(defvar compile-guess-command-table
  '((c-mode       . "gcc -Wall -g %s -o %s -lm")
    (c++-mode     . "g++ -Wall -g %s -o %s -std=c++14")
    (fortran-mode . "gfortran -C %s -o %s")
    (haskell-mode . "ghc -dynamic %s")
    (latex-mode   . "pdflatex %s")
    ))

;; The actual command
(defun compile-guess-command ()
  (let ((command-for-mode (cdr (assq major-mode
				     compile-guess-command-table))))
    (if (and command-for-mode
	     (stringp buffer-file-name))
	(let* ((file-name (file-name-nondirectory buffer-file-name))
	       (file-name-sans-suffix (if (and (string-match "\\.[^.]*\\'"
							     file-name)
					       (> (match-beginning 0) 0))
					  (substring file-name
						     0 (match-beginning 0))
					nil)))
	  (if file-name-sans-suffix
	      (progn
		(make-local-variable 'compile-command)
		(setq compile-command
		      (if (stringp command-for-mode)
			  ;; Optimize the common case.
			  (format command-for-mode
				  file-name file-name-sans-suffix)
			(funcall command-for-mode
				 file-name file-name-sans-suffix)))
		compile-command)
	    nil))
      nil)))


;; Add the appropriate mode hooks.
(add-hook 'c-mode-hook       (function compile-guess-command))
(add-hook 'c++-mode-hook     (function compile-guess-command))
(add-hook 'fortran-mode-hook (function compile-guess-command))
(add-hook 'haskell-mode-hook (function compile-guess-command))
(add-hook 'latex-mode-hook   (function compile-guess-command))

;;; compileConfiguration.el ends here
