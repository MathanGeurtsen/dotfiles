 ;; according to https://emacs-lsp.github.io/lsp-mode/tutorials/CPP-guide/



(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")

  ;; :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
  ;;        ;; (XXX-mode . lsp)
  ;;        ;; if you want which-key integration
  ;;        ;; (lsp-mode . lsp-enable-which-key-integration)
  ;;        )
  :config
  (add-hook 'lsp-mode-hook '(lambda () (interactive) (eldoc-mode -1)))
  (setq lsp-signature-auto-activate nil
        lsp-signature-doc-lines 1
        lsp-signature-render-documentation t
        lsp-eldoc-render-all nil
        lsp-eldoc-hook nil
        lsp-pyls-plugins-pyflakes-enabled nil)
  :commands lsp)

;; optionally
(use-package lsp-ui 
  :ensure t
  :commands lsp-ui-mode)
;; ;; if you are helm user
;; (use-package helm-lsp :commands helm-lsp-workspace-symbol)
;; if you are ivy user
;; (use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
;; (use-package lsp-treemacs :commands lsp-treemacs-errors-list)

;; optionally if you want to use debugger

(use-package dap-mode
  :ensure t
  :after lsp-mode
  :config
  (dap-mode nil)
  (dap-ui-mode nil))
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

;; optional if you want which-key integration
(use-package which-key
    :config
    (which-key-mode))

;; Enabling only some features
(setq dap-auto-configure-features '(sessions locals controls tooltip))

;; from https://emacs-lsp.github.io/lsp-mode/tutorials/how-to-turn-off/
;; turns off annoying action recommendations
(setq lsp-ui-sideline-show-code-actions nil)

(add-hook 'c++-mode-hook #'lsp)
(add-hook 'c-mode-hook #'lsp)
(add-hook 'python-mode-hook #'lsp)

(setq lsp-ui-doc-enable nil
      lsp-ui-sideline-enable nil)
