;;; package --- Summary
;; EMACS Config, by Anton Augustsson


;;; Commentary:
;; My EMACS config, including tools for giving as much help as possible
;; when writing code, even spelling and grammar tools.
;; If you don not want to use a command use ';' for comments use ';;',
;; comments in code use ';'

;;; Code:

;;----------------------------------------------------------------------------
;; general setup
;;----------------------------------------------------------------------------

;; Disable the scroll bar
(scroll-bar-mode -1)

;; Disable the menu bar
(menu-bar-mode -1)

;; Disable the toolbar
(tool-bar-mode -1)

;; Number lines
(global-linum-mode 1)

;; cua-mode keys C-c C-v...
(cua-mode t)

;; Backup conf, remove <file name>~
(setq backup-directory-alist `(("." . "~/.local/share/emacs/saves")))

;; Disable startup screen
;;(setq inhibit-startup-screen t)

;; Start with fullscreen
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(package-selected-packages
   (quote
    (afternoon-theme peep-dired dirtree csv-mode solarized-theme pyvenv projectile multiple-cursors markdown-mode magit haskell-mode flycheck dashboard auto-complete all-the-icons pdf-tools peep-dired))))
 
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;----------------------------------------------------------------------------
;; Automaticly install packages
;;----------------------------------------------------------------------------

(require 'package)  ;; in order to be able to install packages

;; Can install from Melpa stable
(add-to-list 'package-archives
             '("MELPA Stable" . "http://stable.melpa.org/packages/") t)
;; Can install from Melpa  !Un tested!
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
;; Can install from GNU  !Un tested!
(add-to-list 'package-archives
             '("gnu" . "https://elpa.gnu.org/packages/") t)


(package-initialize)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

;; list the packages you want
(setq package-list
      '(auto-complete multiple-cursors flycheck pyvenv      ; Editing tools
	markdown-mode haskell-mode tex-mode csv-mode        ; Languages
	solarized-theme afternoon-theme                     ; Themes
	page-break-lines projectile all-the-icons dashboard ; Dashboard
	magit pdf-tools peep-dired))                        ; Tools

;; activate all the packages
(package-initialize)

;; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

;; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))


;;----------------------------------------------------------------------------
;; Package setup
;;----------------------------------------------------------------------------

;; Themes
;(load-theme 'solarized-dark t)
;(load-theme 'adwaita t)
(load-theme 'afternoon t)

;; Auto complete
(require 'auto-complete)
(ac-config-default)

;; Flycheck
(require 'flycheck)
(global-flycheck-mode)
(global-set-key (kbd "C-a") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
;;(global-set-key (kbd "C-a C-<") 'mc/mark-all-like-this)

;; org mode
(require 'flycheck)
(setq org-support-shift-select t)  ; resolving conflict with shift-select

;; Dashboard
(require 'dashboard)
;(turn-on-page-break-lines-mode)
(dashboard-setup-startup-hook)
;; What should be present on the dashboard
(setq dashboard-items '((recents  . 5)
                        (bookmarks . 5)
                        (projects . 5)))

;; PDF Tools
(pdf-tools-install)
(pdf-loader-install)
(add-hook 'pdf-view-mode-hook (lambda() (linum-mode -1)))

;;preview files in dired
(define-key dired-mode-map "P" nil)
(setq peep-dired-cleanup-on-disable t)

;;(use-package peep-dired
;;  :ensure t
;;  :defer t ; don't access `dired-mode-map' until `peep-dired' is loaded
;;  :bind (:map dired-mode-map
;;              ("P" . peep-dired)))

;;----------------------------------------------------------------------------
;; Keybindings
;;----------------------------------------------------------------------------

;; indent buffer
(defun indent-buffer ()
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max) nil)))
(global-set-key [C-M-i] 'indent-buffer)

;; Enable and disable menu bar
(global-set-key (kbd "C-c C-o") 'menu-bar-mode)

;; Enable and disable tool bar
(global-set-key (kbd "C-c C-p") 'tool-bar-mode)

;; Compile
(global-set-key (kbd "C-c c") 'compile)

;; Eval
(global-set-key (kbd "C-c e") 'eval-buffer)

;; Magit
(global-set-key (kbd "C-c m") 'magit)

;; Enable and disable flyspell mode
(global-set-key (kbd "C-c C-d") 'flyspell-mode)

;; Wind Move
;(global-set-key (kbd "C-c <left>")  'nil)
(global-set-key (kbd "C-c <left>")  'windmove-left)
;(global-set-key (kbd "C-c <right>")  'nil)
(global-set-key (kbd "C-c <right>") 'windmove-right)
;global-set-key (kbd "C-c <up>")  'nil)
(global-set-key (kbd "C-c <up>")    'windmove-up)
;(global-set-key (kbd "C-c <down>")  'nil)
(global-set-key (kbd "C-c <down>")  'windmove-down)

;; Peep Dired
(global-set-key (kbd "C-c p")  'peep-dired)

;;----------------------------------------------------------------------------
;; Compile configuration
;;----------------------------------------------------------------------------
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



;;; init.el ends here

