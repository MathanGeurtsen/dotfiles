(use-package flycheck
  :ensure t)

(add-to-list 'display-buffer-alist
             `(,(rx bos "*Flycheck errors*" eos)
               (display-buffer-reuse-window
                display-buffer-in-side-window)
               (side            . bottom)
               (reusable-frames . visible)
               (window-height   . 0.15)))
(flycheck-define-checker
    python-mypy ""
    :command ("mypy"
              "--ignore-missing-imports"
              "--python-version" "3.7"
              source-original)
    :error-patterns
    ((error line-start (file-name) ":" line ": error:" (message) line-end))
    :modes python-mode)

(add-to-list 'flycheck-checkers 'python-mypy t)
(flycheck-add-next-checker 'python-pylint 'python-mypy t)
;; sourced from https://www.reddit.com/r/emacs/comments/7dbunc/emacs_python_36_type_checking_support_using_mypy/
;; change width of id column, code from https://github.com/flycheck/flycheck/issues/1101, doesn't work yet
(add-hook 'flycheck-error-list-mode-hook
          (lambda ()
            (setq tabulated-list-format 
                  '[("Line" 5 flycheck-error-list-entry-< :right-align t)
                    ("Col" 3 nil :right-align t)
                    ("Level" 8 flycheck-error-list-entry-level-<)
                    ("ID" 50 t)
                    (#("Message (Checker)" 0 9
                       (face default)
                       9 16
                       (face flycheck-error-list-checker-name)
                       16 17
                       (face default))
                     0 t)])))

