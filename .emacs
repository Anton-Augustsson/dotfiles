(require 'package)                                                            
(add-to-list 'package-archives
             '("MELPA Stable" . "http://stable.melpa.org/packages/") t)
(package-initialize)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")                     
;; list the packages you want                                                 
(setq package-list                                                            
    '(auto-complete markdown-mode flycheck))                                                
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
(deftheme tango-dark)                                                         
(load-theme 'tango-dark t)                                                    
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


;; general setupp                                                             
                                                                              
;; Number lines                                                               
(global-linum-mode 1)                                                         
;; cua-mode keys C-c C-v...                                                   
(cua-mode t)                                                                  
;; disable startup screen                                                     
(setq inhibit-startup-screen t)                                               
;; start with fullscreen                                                      
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(package-selected-packages (quote (pyvenv flycheck auto-complete))))
        
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; short cuts

;; indent buffer
(defun indent-buffer ()
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max) nil)))
(global-set-key [C-M-i] 'indent-buffer)
;; Moving window
(global-set-key [M-<tab>] 'other-window)
;;'isearch-forward-regexp)
