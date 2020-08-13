;;;; package --- Summary
;; Package Setup, by Anton Augustsson

;;; Commentary:
;; Setup and configure modes and others packages

(provide 'packageSetup)

;;; Code:
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
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

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
(setq auto-revert-interval 1)

;;preview files in dired
(define-key dired-mode-map "P" nil)
(setq peep-dired-cleanup-on-disable t)

;; dired-omit-mode
(add-hook 'dired-load-hook '(lambda () (require 'dired-x))) ; Load Dired X when Dired is loaded.
(setq dired-omit-mode t) ; Turn on Omit mode.
(require 'dired-x)
(setq-default dired-omit-files-p t) ; Buffer-local variable
(setq dired-omit-files (concat dired-omit-files "\\|^\\..+$"))
(add-hook 'dired-mode-hook 'dired-hide-details-mode) ; hide details details


;;; packageSetup.el ends here
