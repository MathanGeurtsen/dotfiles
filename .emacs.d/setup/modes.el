;;; mode hooks

(use-package pdf-tools
  :ensure t
  :config
  (pdf-tools-install)
  (add-to-list 'auto-mode-alist '("\\.pdf\\'" . pdf-view-mode))
  (add-to-list 'auto-mode-alist '("\\.pdf\\'" . pdf-isearch-minor-mode)))

(add-hook 'pdf-view-mode-hook (blink-cursor-mode -1))

(use-package sass-mode
  :ensure t)
(use-package yaml-mode
  :ensure t)
(use-package dockerfile-mode
  :ensure t)

(use-package fish-mode
  :ensure t)
(use-package cmake-mode
  :ensure t)
(use-package json-mode
  :ensure t)
(add-hook 'prog-mode-hook '(lambda () (interactive) 
                               (setq display-line-numbers 'relative)))
(unless (string-equal system-type "windows-nt")
  (add-hook 'prog-mode-hook            'flycheck-mode))

(add-hook 'fundamental-mode-hook     'company-mode)

(add-hook 'csharp-mode-hook 'omnisharp-mode)
(add-hook 'latex-mode-hook  'reftex-mode)

(add-hook 'java-mode-hook (lambda ()
                            (setq c-basic-offset 2
                                  tab-width 2
                                  indent-tabs-mode t)))

(add-hook 'sh-mode-hook (lambda ()
                            (company-mode -1)))


(setq auto-mode-alist
      (append '(
                ("\\.hbs\\'" . html-mode)
                ("\\.latex\\'" . latex-mode)
                ("\\.ltx\\'" . latex-mode)
                ("\\.glsl\\'" . csharp-mode)
                ("\\.cl\\'" . csharp-mode)
                ("\\.cake\\'" . csharp-mode)
                ("\\.hs\\'" . flycheck-mode)
                ("\\.hs\\'" . haskell-mode)
                ("\\.hs\\'" . flycheck-mode)
                ("\\.journal\\'" . hledger-mode)
                ("\\.ahk\\'" . xahk-mode)
                ("\\.ino\\'" . c-mode)
                ("\\.pdf\\'" . pdf-view-mode)
                ("\\.js\\'" . js-mode)
                ("\\.css\\'" . css-mode)
                ("\\.php\\'" . php-mode))
              auto-mode-alist))

