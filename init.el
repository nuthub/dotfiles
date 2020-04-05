
;;; init.el --- Initialization file for Emacs
;;; Commentary: Emacs Startup File --- initialization for Emacs
;;; Code:
(unless noninteractive
  (message "Loading %s..." load-file-name))

;; Load org-mode init file
(require 'org)
(org-babel-load-file
 (expand-file-name "conf/init.org" user-emacs-directory))
;;    ("0598c6a29e13e7112cfbc2f523e31927ab7dce56ebb2016b567e1eff6dc1fd4f" default)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (platformio-mode auctex markdown-mode web-mode htmlize org-bullets all-the-icons flycheck company nlinum beacon magit which-key smartparens powerline projectile treemacs undo-tree diminish solarized-theme use-package auto-package-update))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(provide 'init)
;;; init.el ends here


