;; Add package repositories
(require 'package)
(add-to-list 'package-archives '("melpa"     . "https://stable.melpa.org/packages/"))
;;(add-to-list 'package-archives '("melpa"     . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu"       . "http://elpa.gnu.org/packages/"))

(package-initialize)

;; install use-package if required
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; use-package stuff
;; This is only needed once, near the top of the file
(eval-when-compile
  (require 'use-package))
;; set :ensure t with all packages
(require 'use-package-ensure)
(setq use-package-always-ensure t)
;;(setq use-package-always-defer t)


;; My Packages
(use-package counsel) ;; don't know
(use-package ivy)
;; Alternative could be: Modeline
(use-package powerline
  :config
  (powerline-center-theme))
(use-package undo-tree
  :config
  (global-undo-tree-mode))
(use-package linum)
(use-package org
  :defer t
  :config
;;  (setq org-directory "~/org/")
  (setq org-tag-alist (quote (("@home" . ?h) ("@notebook" . ?n) ("@office" . ?o) ("@phone" . ?p))))
  (setq org-agenda-files (quote ("~/org/GTD.org" "~/org/Tickler.org" "~/org/Someday.org"))))
(use-package org-bullets
;;  :defer t
  :hook (org-mode . org-bullets-mode))
(use-package markdown-mode)
  ;;:defer t)
(use-package auctex
  :defer t
  :init
  ;; https://askubuntu.com/questions/1041919/integration-of-emacs-lualatex-with-evince-zathura-not-working-in-ubuntu-18-04-h
  (setq TeX-view-program-selection '((output-pdf "Zathura")))
  (setq TeX-source-correlate-method 'synctex)
  (setq TeX-source-correlate-start-server t)
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode))
(use-package treemacs
  :defer t)
(use-package magit
  :defer t)


;; Look & Feel
(load-theme 'wombat) ; load standard dark theme
(menu-bar-mode -1) ; switch off menu bar
(tool-bar-mode -1) ; switch off tool bar
(scroll-bar-mode -1) ; switch off scroll bar
(column-number-mode t) ; show column number next to line number
(show-paren-mode t) ; show matching parenthesis
;;(electric-pair-mode) ; close opened paranthesis
;; (global-hl-line-mode t) ; highlight current line
;; (ido-mode t) ; auto completion / change whith ivy / helm?
;; (winner-mode t) ; 
;;(windmove-default-keybindings) ;

;; Global key bindings
;; I hardly ever set the fill-column
(global-set-key (kbd "C-x f") 'find-file-at-point)
;; org-agenda stuff
(global-set-key "\C-ca" 'org-agenda)

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (counsel ivy use-package undo-tree treemacs smart-mode-line powerline markdown-mode magit helm auctex))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


