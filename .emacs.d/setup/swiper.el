(use-package ivy
  :ensure t
  :init
  (setq ivy-use-virtual-buffers t)
  :config
  (ivy-mode 1))

(use-package counsel
  :ensure t
  :config
  (ivy-mode 1)
  (counsel-mode 1))

(use-package projectile
  :ensure t
  :init
  (setq projectile-completion-system 'ivy)
  :custom
  (projectile-mode +1))
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(setq compilation-scroll-output t)
;; toggling on windows seems to make it index the projects 
(projectile-mode)
(projectile-mode)
