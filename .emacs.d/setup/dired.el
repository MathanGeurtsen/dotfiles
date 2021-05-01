(use-package direx
  :ensure t)

(use-package dired-k
  :ensure t)

(use-package dired
  :config
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
  (add-hook 'dired-before-readin-hook 'dired-hide-details-mode)
  (put 'dired-find-alternate-file 'disabled nil))

