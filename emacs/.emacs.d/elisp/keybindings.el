;;;; package --- Summary
;; Keybinding, by Anton Augustsson

;;; Commentary:
;; All custom kebindings


(provide 'keybindings)

;;; Code:

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
;; Enable and disable pdf automatic update
(global-set-key (kbd "C-c r") 'auto-revert-mode)
;; Peep Dired
(global-set-key (kbd "C-c p")  'peep-dired)

;; Hide dired mode
(global-set-key (kbd "C-c o")  'dired-omit-mode)

;; Wind Move
;(global-set-key (kbd "C-c <left>")  'nil)
(global-set-key (kbd "C-c <left>")  'windmove-left)
;(global-set-key (kbd "C-c <right>")  'nil)
(global-set-key (kbd "C-c <right>") 'windmove-right)
;global-set-key (kbd "C-c <up>")  'nil)
(global-set-key (kbd "C-c <up>")    'windmove-up)
;(global-set-key (kbd "C-c <down>")  'nil)
(global-set-key (kbd "C-c <down>")  'windmove-down)


;;; keybindings.el ends here
