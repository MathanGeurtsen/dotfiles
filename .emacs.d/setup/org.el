;; org config

(use-package org
  :bind (
         ("\C-cl" . org-store-link)
         ("\C-ca" . org-agenda)
         ("\C-cc" . org-capture)

         :map org-mode-map
         (("C-c n i" . org-roam-insert)
          ("M-[" . org-metaleft)
          ("M-]" . org-metaright)
          ("C-{" . org-shiftleft)
          ("C-}" . org-shiftright)
          ("C-x f" . org-footnote-new)))
  :config
  (add-to-list 'org-emphasis-alist
               '("&" (:foreground "red")
                 )))

(use-package org-roam
  :init
  (setq org-roam-v2-ack t)
  :ensure t
  :custom
  (org-roam-directory (file-truename (concat box/org-dir "roam"))
  (add-hook 'org-capture-mode-hook (org-mode))
  (org-roam-index-file (file-truename (concat box/org-dir "roam/" "index.org")))
  (org-roam-encrypt-files nil)
  (org-roam-db-autosync-mode)))




;; org mode wrap text
(setq org-startup-truncated nil)

(setq org-log-done t)

(setq org-return-follows-link 't)
(setq org-pretty-entities t)

(defun my/org-confirm-babel-evaluate (lang body)
  (not (string= lang "latex")))  ;don't ask for latex

;; org mode use [] instead of LEFT-RIGHT for better reachability
(defun my/org-mode-config ()
  "For use in `org-mode-hook'."
  (toggle-word-wrap)
  (org-display-inline-images t t)
  (org-bullets-mode)
  (highlight-regexp  "\\todo\\[.*?\\]{.*?}"  'org-table-header)
  (setq org-confirm-babel-evaluate #'my/org-confirm-babel-evaluate
        org-hide-emphasis-markers t
        org-catch-invisible-edits nil
        org-src-fontify-natively t
        org-startup-truncated nil
        org-edit-src-content-indentation 0
        org-image-actual-width nil))
(add-hook 'org-mode-hook 'my/org-mode-config)


;; languages to load for org-babel
(org-babel-do-load-languages
 'org-babel-load-languages  
 '((emacs-lisp . t)
   (R . t)
   (python . t)
   (dot . t)
   (haskell . t)
   (ditaa . t)
   (latex . t)))



;; set latex fragments to be scaled to 2.0 to be more easily readable
;; (setq org-format-latex-options (plist-put org-format-latex-options :scale 1.3))

(setq reftex-default-bibliography '("~/.emacs.d/bibliography/references.bib"))

;;;; see org-ref for use of these variables
(setq org-ref-bibliography-notes "~/.emacs.d/bibliography/notes.org"
      org-ref-default-bibliography '("~/.emacs.d/bibliography/references.bib")
      org-ref-pdf-directory "~/.emacs.d/bibliography/bibtex-pdfs/")
