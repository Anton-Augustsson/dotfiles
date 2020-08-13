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

(load "~/.emacs.d/elisp/generalSetup.el")

;(add-to-list 'load-path "~/.emacs.d/lisp/")
;(require 'lisp/load-directory)
;(load-directory "~/.emacs.d/elisp/load-directory.el")
;; https://www.emacswiki.org/emacs/LoadingLispFiles
;; https://www.emacswiki.org/emacs/OptimizingEmacsStartup
;;(load "~/.emacs.d/elisp/load-directory.el")

;;----------------------------------------------------------------------------
;; Automaticly install packages
;;----------------------------------------------------------------------------

(load "~/.emacs.d/elisp/automaticlyInstallPackages.el")


;;----------------------------------------------------------------------------
;; Package setup
;;----------------------------------------------------------------------------

(load "~/.emacs.d/elisp/packageSetup.el")


;;----------------------------------------------------------------------------
;; Keybindings
;;----------------------------------------------------------------------------

(load "~/.emacs.d/elisp/keybindings.el")


;;----------------------------------------------------------------------------
;; Compile configuration
;;----------------------------------------------------------------------------

(load "~/.emacs.d/elisp/compileConfiguration.el")


(server-start)

;;; init.el ends here
