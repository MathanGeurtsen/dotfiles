;; server
(require 'server)
(server-force-delete)
(unless (server-running-p)
  (server-start))
(setq inhibit-compacting-font-caches t)


;; latex
(defun my/latex-mode-hook ()
  (add-to-list 'company-backends '(company-reftex-labels))
  (add-to-list 'company-backends '(company-reftex-citations)))
(add-hook 'latex-mode-hook 'my/latex-mode-hook)
(set-default 'truncate-lines nil)
;; prevent old precompiled elisp file
(setq load-prefer-newer t)

;; disalbe tooltip help popups
(setq tooltip-mode nil)

;; mouse rightclick menu
(global-set-key [mouse-3] 'mouse-popup-menubar)

;; disable lock files
(setq create-lockfiles nil)

(setq electric-indent-chars (remq ?\n electric-indent-chars))

;; Make sure Unix tools are in front of `exec-path'
(when (eq system-type 'windows-nt)

  (let ((bash (executable-find "bash")))
    (when bash
      (push (file-name-directory bash) exec-path)))
  (let ((path (mapcar 
               'file-truename
               (append exec-path
                       (split-string 
                        (getenv "PATH") path-separator t)))))
    (setenv "PATH" (mapconcat
                    'identity (delete-dups path) path-separator))))

(setenv "PATH" (concat (getenv "PATH") "C:/Python39/"))
(setq exec-path (append exec-path '("/sw/bin")))

;; scrolling
(setq mouse-wheel-scroll-amount '(5 ((shift) . 5) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)
(setq next-screen-context-lines 10)

(setq backup-directory-alist
      `(("." . ,(concat user-emacs-directory "backups/"))))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; indentation
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq indent-line-function 'insert-tab)
(setq c-default-style "linux"
      c-basic-offset 2)

;; recursive minibuffer
(setq enable-recursive-minibuffers t)

;; add exernal clipboard to kill ring in emacs
(setq save-interprogram-paste-before-kill t)

;; tramp, recentf
(setq tramp-default-method "plink")
(setq recentf-auto-cleanup 'never)

;; ;; stop async from opening a buffer 
(defadvice async-shell-command (around hide-async-windows activate)
  (save-window-excursion
    ad-do-it))

;; all binary prompts should be y or n
(defalias 'yes-or-no-p 'y-or-n-p)

;; reload files when changed on disk
(global-auto-revert-mode 1)

;; set buffer name completion to case insensitive
(setq read-buffer-completion-ignore-case 1)

(setq completion-ignore-case  t)

;; saving minibuffer input for future sessions
(savehist-mode 1)

;; enable some disabled-by-default functions
(put 'downcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;; record changes in window configuration
(winner-mode t)
(setq windmove-wrap-around t)

;; show opposing parens
(show-paren-mode)
(setq show-paren-delay 0)

