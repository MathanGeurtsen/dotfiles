(cond 
 ((string-equal system-type "gnu/linux")
  (setq gl-sc/temp     "/tmp/")
  (setq gl-sc/open-dir "nautilus .")
  (setq gl-sc/init     "~/.emacs.d/init.el"))

 ((string-equal system-type "windows-nt")
  (setq gl-sc/temp     "~/AppData/Local/Temp/")
  (setq gl-sc/open-dir "start .")
  (setq gl-sc/init     "~/.emacs.d/init.el")))

(defvar my-keys-minor-mode-map
  (let ((map (make-sparse-keymap)))

    (defvar gl-sc/organiser (concat box/org-dir "organiser.org"))
    (defvar gl-sc/tips (concat box/org-dir      "tips.org"))
    (defvar gl-sc/projects (concat box/org-dir  "projects.org"))
    (defvar gl-sc/days (concat box/org-dir      "days.org.gpg"))
    (message "mark==")
    (progn (message gl-sc/organiser)
    (message (format-time-string "%H:%M:%S")))
    (define-key map (kbd "C-c m")       '(lambda () (interactive) (async-shell-command gl-sc/open-dir)))
    (define-key map (kbd "C-;")
      (defhydra my/main-hydra (:exit t :hint nil)
        "
^files^          ^buffers, flyspell^      ^misc
^^^^^^^^-----------------------------------------------------------------
_i_: init        _g_: magit              _m_: open dir
_o_: organiser   _b_: iBuffer            _q_: hide buffer
_t_: tips        _c_: correct word       _SPC_: toggle hide block
_p_: projects    _e_: show region errors _y_: insert date
_d_: days         ^ ^                    _<tab>_: yas expand
_f_: temp folder  ^ ^                    _u_: use url or search
^ ^               ^ ^                    _s_: search multi buffer
^ ^               ^ ^                    _r_: org-roam-node-find
"
        ("i" (find-file gl-sc/init))
        ("o" (find-file gl-sc/organiser))
        ("t" (find-file gl-sc/tips))
        ("p" (find-file gl-sc/projects))
        ("d" (find-file gl-sc/days))
        ("f" (my/tempdir gl-sc/temp))

        ("g"     (magit))
        ("b"      (ibuffer))
        ("c"      (ispell-word))
        ("e"      (call-interactively 'flyspell-region))

        ("m" (async-shell-command open-dir))
        ("q"     (quit-window))
        ("SPC"   (hs-toggle-hiding))
        ("y"     (my/insert-date-today))
        ("<tab>"  (yas-expand-from-trigger-key))
        ("u"      (browse-url-dwim-guess))
        ("s"      (call-interactively 'multi-occur-in-matching-buffers))
        ("r"      (org-roam-node-find))))

    (define-key map (kbd "C-,")
      (defhydra my/window-hydra (:exit nil :hint nil)
        "
^windows size^            ^windmove^    ^misc
^^^^^^^^-----------------------------------------------------------------
_{_: horizontal decrease  _h_: move left  _s_: Swap windows
_}_: horizontal increase  _j_: move down  _r_: register Window config
_[_: vertical decrease    _k_: move up    _g_: go to registered Window config
_]_: vertical increase    _l_: move right _o_: other window
^ ^                      ^ ^              _e_: scroll a line down
^ ^                      ^ ^              _y_: scroll a line up
"
        ("{" (shrink-window-horizontally 4))
        ("}" (enlarge-window-horizontally 4))
        ("[" (shrink-window 4))
        ("]" (enlarge-window 4))
        ("s" (window-swap-states) :exit t)
        ("r" (my/register-window-check 9) :exit t)
        ("g" (jump-to-register 9 ) :exit t)

        ("h" (windmove-left ) :exit t)
        ("j" (windmove-down ) :exit t)
        ("k" (windmove-up ) :exit t)
        ("l" (windmove-right ) :exit t)
        ("o" (other-window 1) :exit t)
        ("e" (scroll-up-line))
        ("y" (scroll-down-line))))


    (define-key map (kbd "C-x C-B")     'ivy-switch-buffer)
    (define-key map (kbd "C-c w")       'xah-copy-file-path)
    (define-key map (kbd "C-c C-q")     'quit-window)
    (define-key map (kbd "C-x C-k")     'kill-buffer)
    (define-key map (kbd "M-!")         'async-shell-command)

    (define-key map (kbd "C-s")         'swiper)
    (define-key map (kbd "C-c s")       'counsel-git-grep)

    (define-key map (kbd "C->")         'mc/mark-next-like-this)
    (define-key map (kbd "C-<")         'mc/mark-previous-like-this)
    (define-key map (kbd "C-c y")       'my/insert-date-today)

    (define-key map (kbd "C-c <C-tab>") 'yas-expand-from-trigger-key)
    (define-key map (kbd "<C-tab>")     'company-complete)
    (define-key map (kbd "C-x C-f")     'counsel-find-file)
    map)
  "My-keys-minor-mode keymap.")

(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  :init-value t
  :lighter " my-keys")

(my-keys-minor-mode 1)
(provide 'global-shortcuts)
