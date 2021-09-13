;;; display

(setq inhibit-startup-screen t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(use-package doom-themes
  :ensure t)

;; Global settings (defaults)
(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled
(my/night-theme)
(my/standard-font-size)

(tab-bar-mode 1)
(defalias 'tabe 'tab-bar-new-tab-to)
(defalias 'tabc 'tab-bar-close-tab)


(require 'frame)
(defun set-cursor-hook (frame)
  (modify-frame-parameters
   frame (list (cons 'cursor-color "DeepSkyBlue"))))
(add-hook 'after-make-frame-functions 'set-cursor-hook) ; oh, that is indeed emberrassing, zarkone

(use-package doom-modeline
  :ensure t
  :config
  (doom-modeline-mode 1)
  (setq doom-modeline-window-width-limit 50)
  (setq doom-modeline-buffer-encoding nil)
  (setq doom-modeline-buffer-file-name-style (quote auto))
  (setq doom-modeline-env-version nil)
  (setq doom-modeline-irc nil)
  (setq doom-modeline-repl nil)
  (setq doom-modeline-vcs-max-length 7)
  (setq column-number-mode t)
  (display-time-mode 1)
  (doom-themes-visual-bell-config))
