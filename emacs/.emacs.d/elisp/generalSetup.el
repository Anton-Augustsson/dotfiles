;;;; package --- Summary
;; General setup in EMACS, by Anton Augustsson

;;; Commentary:
;; Basic config for Emacs


;;; Code:

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
    (org-bullets dired-omit-mode afternoon-theme peep-dired dirtree csv-mode solarized-theme pyvenv projectile multiple-cursors markdown-mode magit haskell-mode flycheck dashboard auto-complete all-the-icons pdf-tools peep-dired))))
 
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; generalSetup.el ends here
