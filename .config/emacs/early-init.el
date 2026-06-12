;;; early-init --- Summary: is run before init.el  -*- lexical-binding: t; -*-
;;; Commentary:
;; this is run before package management and GUI is loaded
;;; Code:

;; from https://github.com/progfolio/elpaca?tab=readme-ov-file#installer & straight.el documentation: avoid loading package.el
(setq package-enable-at-startup nil)


(provide 'early-init)
;;; early-init.el ends here
