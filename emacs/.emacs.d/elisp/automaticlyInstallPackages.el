;;;; package --- Summary
;; Automaticly install packages in EMACS, by Anton Augustsson

;;; Commentary:
;; Packages can be downloaded from "MELPA Stable", "melpa" and "gnu"
;; To install packages simply add it in package-list


(require 'package)  ;; in order to be able to install packages
(provide 'automaticlyInstallPackages)
	 
;;; Code:
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
	solarized-theme afternoon-theme org-bullets         ; Themes
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

;;; automaticlyInstallPackages.el ends here
