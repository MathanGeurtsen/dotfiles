(use-package company
  :ensure t)
(use-package company-quickhelp
  :ensure t)
(global-company-mode)
(define-key company-active-map (kbd "TAB") 'company-complete-selection)

(use-package company-quickhelp
  :ensure t)
(company-quickhelp-mode)
