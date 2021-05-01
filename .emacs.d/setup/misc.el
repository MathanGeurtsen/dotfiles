;; server
(require 'server)
(server-force-delete)
(unless (server-running-p)
  (server-start))
(setq inhibit-compacting-font-caches t)
(set-default 'truncate-lines t)

(setq python-shell-interpreter "python3")
;; latex
(defun my/latex-mode-hook ()
  (add-to-list 'company-backends '(company-reftex-labels))
  (add-to-list 'company-backends '(company-reftex-citations))
  )
(add-hook 'latex-mode-hook 'my/latex-mode-hook)

;;;; prevent old precompiled elisp file
(setq load-prefer-newer t)

;;;; tooltip
(setq tooltip-mode nil)

;; mouse rightclick menu
(global-set-key [mouse-3] 'mouse-popup-menubar)

;;;; disable lock files
(setq create-lockfiles nil)

(setq electric-indent-chars (remq ?\n electric-indent-chars))

;; Windows path
(when (eq system-type 'windows-nt)

  ;; Make sure Unix tools are in front of `exec-path'
  (let ((bash (executable-find "bash")))
    (when bash
      (push (file-name-directory bash) exec-path)))

  ;; Update PATH from exec-path
  (let ((path (mapcar 
               'file-truename
               (append exec-path
                       (split-string 
                        (getenv "PATH") path-separator t)))))
    (setenv "PATH" (mapconcat
                    'identity (delete-dups path) path-separator))))

;;;; scrolling
(setq mouse-wheel-scroll-amount '(5 ((shift) . 5) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)
(setq next-screen-context-lines 10)

(setq backup-directory-alist
      `(("." . ,(concat user-emacs-directory "backups/"))))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;;;; indentation
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq indent-line-function 'insert-tab)

;;;; recursive minibuffer
(setq enable-recursive-minibuffers t)

;;;; add exernal clipboard to kill ring in emacs
(setq save-interprogram-paste-before-kill t)

;;;; tramp, recentf
(setq tramp-default-method "plink")
(setq recentf-auto-cleanup 'never)

;;;; stop async from opening a buffer 
(defadvice async-shell-command (around hide-async-windows activate)
  (save-window-excursion
    ad-do-it))

;;;; make all yes or no be y or n
(defalias 'yes-or-no-p 'y-or-n-p)

;;;; reload files when changed on disk
(global-auto-revert-mode 1)

;;;; set buffer name completion to case insensitive
(setq read-buffer-completion-ignore-case 1)

(setq completion-ignore-case  t)

(defvar windmove-wrap-around t)

;;;; saving minibuffer input for future sessions
(savehist-mode 1)

(put 'downcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)

(winner-mode 1)

(setq c-default-style "linux"
      c-basic-offset 2)

(advice-add 'describe-function-1 :after #'elisp-demos-advice-describe-function-1)

(use-package highlight-parentheses
  :ensure t
  :config
  (define-globalized-minor-mode global-highlight-parentheses-mode
    highlight-parentheses-mode
    (lambda ()
      (highlight-parentheses-mode t)))

  (global-highlight-parentheses-mode t)
  (highlight-parentheses-mode 1))
;; global minor modes


(show-paren-mode 1)
(setq show-paren-delay 0)

