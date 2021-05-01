(use-package org-bullets
  :ensure t
  :after org
  :config  
  (setq org-bullets-bullet-list '(">" "•" "•" "•" "•"))
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode))))





