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
  :commands (org-roam org-roam-mode)
  :ensure t
  :custom
  (org-roam-directory (concat box/org-dir "roam")
  (add-hook 'org-capture-mode-hook (org-mode))
  (org-roam-index-file (concat box/org-dir "roam/" "index.org"))
  (org-roam-encrypt-files nil)
  :bind (:map org-mode-map
              (("C-c n i" . org-roam-insert)))))

;; org mode wrap text
(setq org-startup-truncated nil)

(setq org-log-done t)

(setq org-return-follows-link 't)
(setq org-pretty-entities t)

;; org mode use [] instead of LEFT-RIGHT for better reachability
(defun my-org-mode-config ()
  "For use in `org-mode-hook'."
  (toggle-word-wrap)
  (org-display-inline-images t t)
  (org-bullets-mode)
)
(add-hook 'org-mode-hook 'my-org-mode-config)

(setq org-hide-emphasis-markers t)

(setq org-catch-invisible-edits nil)

;; (load "~/.emacs.d/setup/org-bullets")

(setq org-src-fontify-natively t)

;; org mode wrap text
(setq org-startup-truncated nil)

;; languages to load for org-babel
(org-babel-do-load-languages
 'org-babel-load-languages  
 '((emacs-lisp . t)
   (python . t)
   (dot . t)
   (haskell . t)
   (ditaa . t)
   (latex . t)))

;; allow image resizing
(setq org-image-actual-width nil)

;; set latex fragments to be scaled to 2.0 to be more easily readable
(setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0))

(setq reftex-default-bibliography '("~/.emacs.d/bibliography/references.bib"))

;;;; see org-ref for use of these variables
(setq org-ref-bibliography-notes "~/.emacs.d/bibliography/notes.org"
      org-ref-default-bibliography '("~/.emacs.d/bibliography/references.bib")
      org-ref-pdf-directory "~/.emacs.d/bibliography/bibtex-pdfs/")
