;; general setupp                                                             

;; disable the scroll bar
(scroll-bar-mode -1)
;; disable the menu bar
(menu-bar-mode -1)
;; disable the toolbar
(tool-bar-mode -1) 


;; Number lines                                                               
(global-linum-mode 1)                                                         
;; cua-mode keys C-c C-v...                                                   
(cua-mode t)                                                                  
;; disable startup screen                                                     
;;(setq inhibit-startup-screen t)                                               
;; start with fullscreen                                                      
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(package-selected-packages
   (quote
    (dashboard dracula-theme pyvenv flycheck auto-complete))))
        
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'package)                                                            
(add-to-list 'package-archives
             '("MELPA Stable" . "http://stable.melpa.org/packages/") t)
(package-initialize)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")                     
;; list the packages you want                                                 
(setq package-list                                                            
      '(auto-complete multiple-cursors markdown-mode flycheck pyvenv haskell-mode
		      tex-mode solarized-theme page-break-lines dashboard projectile all-the-icons magit))

;; activate all the packages                                                   
(package-initialize)                                                          
;; fetch the list of packages available                                       
(unless package-archive-contents                                              
  (package-refresh-contents))                                                 
;; install the missing packages                                               
(dolist (package package-list)                                                
  (unless (package-installed-p package)                                       
    (package-install package)))
;;(package-install 'flycheck)

;; package setup                                                              
                                                                              
;; Theme M-x package-install RET tango-dark                                   
;;(deftheme tango-dark)                                                         
;;(load-theme 'tango-dark t)                                                    
;;(deftheme dracula-theme)
;;(load-theme 'dracula t)
(load-theme 'solarized-dark t)

;; Auto complete M-x package-install [RET] auto-complete [RET]                
(ac-config-default)                                                           
;; Flycheck M-x package-install RET flycheck                                  
(global-flycheck-mode)                                                        
;;(add-hook 'after-init-hook #'global-flycheck-mode)
;; markdown
;;(use-package markdown-mode
  ;;:ensure t
  ;;:commands (markdown-mode gfm-mode)
  ;;:mode (("README\\.md\\'" . gfm-mode)
         ;;("\\.md\\'" . markdown-mode)
         ;;("\\.markdown\\'" . markdown-mode))
  ;;:init (setq markdown-command "multimarkdown"))
;; Multiple cursors  M-x package-install multiple-cursors
;;(global-set-key [C-c C-a] 'mc/edit-lines)
(global-set-key (kbd "C-a") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
;;(global-set-key (kbd "C-a C-<") 'mc/mark-all-like-this)


;; short cuts
;; shell mode
;;(global-set-key [C-c C-c] 'comint-interrupt-subjob)
;; indent buffer
(defun indent-buffer ()
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max) nil)))
(global-set-key [C-M-i] 'indent-buffer)
;; Moving window
(global-set-key [M-<tab>] 'other-window)
;;'isearch-forward-regexp)
(global-set-key (kbd "C-c C-o") 'menu-bar-mode)
(global-set-key (kbd "C-c C-p") 'tool-bar-mode)



;; Make M-x compile smarter in order to guess language
(require 'compile)
(defvar compile-guess-command-table
  '((c-mode       . "gcc -Wall -g %s -o %s -lm")
    (c++-mode     . "g++ -Wall %s -o %s -std=c++14")
    (fortran-mode . "gfortran -C %s -o %s")
    (haskell-mode . "ghc -dynamic %s")
    (tex-mode   . "pdflatex %s")
    ))

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
(add-hook 'tex-mode-hook     (function compile-guess-command))


; dashboard
;(turn-on-page-break-lines-mode)
(require 'dashboard)
(dashboard-setup-startup-hook)
;;; Or if you use use-package
;(use-package dashboard
;  :ensure t
;  :config
;  (dashboard-setup-startup-hook))
;(setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
(setq dashboard-items '((recents  . 5)
                        (bookmarks . 5)
                        (projects . 5)))
