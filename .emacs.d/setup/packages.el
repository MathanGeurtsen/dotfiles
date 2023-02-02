
;; packages
(use-package hide-lines
  :ensure t)
(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

(use-package magit
  :ensure t
  :init
  (setq magit-display-buffer-function 'magit-display-buffer-same-window-except-diff-v1)
  (add-hook 'magit-status-mode-hook 'menu-bar--wrap-long-lines-window-edge))


(use-package git-gutter
  :ensure t
  :init
  (setq git-gutter-fr:side 'right-fringe)
  (global-git-gutter-mode t))

(use-package browse-url-dwim
  :ensure t
  :config
  (browse-url-dwim-mode 1)
  (setq browse-url-dwim-always-confirm-extraction nil))

(use-package yasnippet
  :ensure t)
(yas-global-mode 1)

(use-package recentf
  :ensure t
  :config 
  (recentf-mode 1)
  (setq recentf-max-menu-items 500)
  (setq recentf-max-saved-items 500)
  (run-at-time nil (* 5 60) 'recentf-save-list))

(use-package vterm
  :ensure t
  :pin melpa
  :bind (:map vterm-mode-map ("C-y" . vterm-yank))
  :config (setq vterm-max-scrollback 100000))

(use-package dimmer
  :ensure t
  :config
  (dimmer-configure-which-key)
  (dimmer-mode t))
(use-package atomic-chrome
  :ensure t
  :config
  (atomic-chrome-start-server))
(use-package elisp-demos
  :ensure t
  :config
  (advice-add 'describe-function-1 :after 
              #'elisp-demos-advice-describe-function-1))
(use-package highlight-parentheses
  :ensure t
  :config
  (define-globalized-minor-mode global-highlight-parentheses-mode
    highlight-parentheses-mode
    (lambda ()
      (highlight-parentheses-mode t)))
  (global-highlight-parentheses-mode t)
  (highlight-parentheses-mode 1))
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package multiple-cursors
  :ensure t
  :config
  (setq mc/cmds-to-run-for-all '(backward-sentence
                                 beginning-of-buffer
                                 end-of-buffer
                                 evil-backward-char
                                 evil-beginning-of-line
                                 evil-force-normal-state
                                 evil-forward-char
                                 evil-insert
                                 evil-next-line
                                 evil-normal-state
                                 evil-previous-line
                                 forward-sentence
                                 indent-for-tab-command
                                 org-beginning-of-line
                                 org-delete-char
                                 org-kill-line
                                 org-self-insert-command)))


(use-package stan-mode
  :ensure t)
(use-package ess
  :ensure t)
(use-package powershell
  :ensure t)
(use-package hydra
  :ensure t)
(use-package helpful
  :ensure t)
(use-package ob-async
  :ensure t)
(use-package flyspell
  :ensure t)
(use-package beacon
  :ensure t)
(use-package ranger
  :ensure t)
(use-package speed-type
  :ensure t)
(use-package all-the-icons
  :ensure t)
(use-package all-the-icons-dired
  :ensure t)
(use-package treemacs-all-the-icons 
  :ensure t)
(use-package ag
  :ensure t)
(use-package emojify
  :ensure t)
(use-package company
  :ensure t)
(use-package flycheck
  :ensure t)
(use-package vimrc-mode
  :ensure t)
