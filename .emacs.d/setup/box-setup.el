;; box-specific and system specific setup
(cond  ;; OS specific setup
 ((string-equal system-type "windows-nt")
    (setenv "ALTERNATE_EDITOR"
            box/alternate_editor)

    ;; set a default font
    (set-face-attribute 'default nil :font "Consolas"))
 
 ((string-equal system-type "darwin")
    (warn "config not setup on mac"))
 
 ((string-equal system-type "gnu/linux")
    ;; treemacs
  (use-package treemacs
    :ensure t
    :config
    (treemacs-follow-mode t)
    (treemacs-git-mode 'simple))
  (use-package treemacs-projectile
    :ensure t)
   (set-face-attribute 'default nil :font "inconsolata")))


