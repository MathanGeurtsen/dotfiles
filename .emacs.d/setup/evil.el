;;; evil


;; evil-mode loads using undo-tree, an approximation to vim's undo tree. 
;; Vim's undo tree is vastly unpreferable to emacs's native undo system, 
;; but there is no way to turn it off. 
;; Here it is simply removed from the load-path. 
(setq load-path-no-undo-tree 
      (let (copy-list)
        (dolist (elt load-path copy-list)
          (when (not (string-match-p (regexp-quote "undo-tree") elt))
            (setq copy-list (cons elt copy-list))))))
(setq load-path load-path-no-undo-tree)

(use-package evil
  :ensure nil
  ;; ensure is turned off because of the workaround above
  :init
  (setq evil-disable-insert-state-bindings t)
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1)
  (add-hook 'vterm-mode-hook 'turn-off-evil-mode))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package evil-snipe
  :after evil
  :ensure t 
  :config 
  (evil-snipe-override-mode +1)
  (setq evil-snipe-scope 'visible)
  (evil-snipe-mode 1))
