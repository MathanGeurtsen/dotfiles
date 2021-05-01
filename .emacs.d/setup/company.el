(use-package company
  :ensure t)
(use-package company-quickhelp
  :ensure t)
(global-company-mode)
(define-key company-active-map (kbd "TAB") 'company-complete-selection)

(use-package company-quickhelp
  :ensure t)
(company-quickhelp-mode)

;; (eval-after-load 'company-etags '(progn (add-to-list 'company-etags-modes 'web-mode)))
;; (setq company-etags-everywhere '(php-mode html-mode web-mode nxml-mode))
