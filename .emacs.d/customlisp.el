(defun my/open-cur-dir ()
  "opens current directory with nautilus. "
  (interactive)
  (async-shell-command "nautilus ."))

(defun my/insert-date-today ()
  "Insert current date"
  (interactive)
  (insert (format-time-string "%Y-%m-%d")))

(defalias 'lowercase-word 'downcase-word)

(defun my/re-replace-buffer (pattern replacement)
  (goto-char (point-min))
  (while (re-search-forward pattern nil t)
    (replace-match
     replacement
     'fixedcase
     'literal)))

(defun my/notes-to-org ()
  (interactive)
  (let ((replacements '(("◆" "**") 
                        ("▪" "*** \n") 
                        ("[─—–]" "-")
                        ("[‘’]" "'")
                        ("…" "...")
                        ("[“”]" "\""))))
    (loop for (pattern replacement) in replacements
          do 
          (my/re-replace-buffer pattern replacement))))

;; TODO: I don't think we need this one anymore, since helm is gone
(defun copy-minibuffer ()
  "addes the minibuffer input to the killring \n(copies entire buffer except non-editable text)"
  (interactive)
  (kill-new(minibuffer-contents-no-properties)))


(defun my/set-transparency (active passive)
  "sets transparancy to desired levels"
  (set-frame-parameter nil 'alpha (cons active passive)))


(defun my/transparent-theme ()
  "Load a transparent theme. "
  (interactive)
  (progn

    (my/disable-all-themes)
    (load-theme 'wheatgrass t)
    (my/set-transparency 70 40)
    (setq my/day-night-switch "my-transparent")))

(defun my/night-theme ()
  "Load default theme and set no transparency."
  (interactive)
  (my/disable-all-themes)
  (my/set-transparency 100 100)
  (setq my/day-night-switch "doom-one")
  (load-theme 'doom-one t))

(defun my/day-theme ()
  "Load default theme and set no transparency."
  (interactive)
  (my/disable-all-themes)
  (setq my/day-night-switch "doom-one-light")
  (load-theme 'doom-one-light t) 
  (my/set-transparency 100 100))

(defun my/switch-day-night-theme (&optional settotheme)
  "Switch between day and night theme, as defined in customlisp.el. Defaults to dark theme if theme is otherwise. "
  (interactive "P")
  (my/disable-all-themes)

  ;; check for argument
  (if (equal 'settotheme "doom-one")
      (progn 
        (load-theme 'doom-one-light t) 
        (setq my/day-night-switch "doom-one-light")
        (my/set-transparency 100 100))
    (if (equal 'settotheme "doom-one-light")
        (progn 
          (load-theme 'doom-one-light t) 
          (setq my/day-night-switch "doom-one-light")
          (my/set-transparency 100 100))))

  ;; if no argument, default behaviour
  (if (equal my/day-night-switch "doom-one") 
      (progn 
        (load-theme 'doom-one-light t) 
        (setq my/day-night-switch "doom-one-light")
        (my/set-transparency 100 100))
    (progn 
      (load-theme 'doom-one t)
      (setq my/day-night-switch "doom-one")
      (my/set-transparency 100 100))))

; sourced from https://stackoverflow.com/a/22872459/8887528
(defun my/disable-all-themes ()
  "disable all active themes."
  (dolist (i custom-enabled-themes)
    (disable-theme i))) 

(defun my/org-windows-screenshot ()
  "Take a screenshot into a time stamped unique-named file in the
same directory as the org-buffer and insert a link to this file."
  (interactive)
  (setq filename
        (concat
         (make-temp-name
          (concat (buffer-file-name)
                  "_"
                  (format-time-string "%Y%m%d_%H%M%S_")) ) ".png"))
  (shell-command "snippingtool /clip")
  (shell-command (concat "powershell -command \"Add-Type -AssemblyName System.Windows.Forms;if ($([System.Windows.Forms.Clipboard]::ContainsImage())) {$image = [System.Windows.Forms.Clipboard]::GetImage();[System.Drawing.Bitmap]$image.Save('" filename "',[System.Drawing.Imaging.ImageFormat]::Png); Write-Output 'clipboard content saved as file'} else {Write-Output 'clipboard does not contain image data'}\""))
  (insert (concat "[[file:" filename "]]"))
  (org-display-inline-images))          ; sourced from http://www.sastibe.de/2018/11/take-screenshots-straight-into-org-files-in-emacs-on-win10/

(defun xah-copy-file-path (&optional @dir-path-only-p)
  "Copy the current buffer's file path or dired path to `kill-ring'.
Result is full path.
If `universal-argument' is called first, copy only the dir path.

If in dired, copy the file/dir cursor is on, or marked files.

If a buffer is not file and not dired, copy value of `default-directory' (which is usually the “current” dir when that buffer was created)

URL `http://ergoemacs.org/emacs/emacs_copy_file_path.html'
Version 2017-09-01"
  (interactive "P")
  (let (($fpath
         (if (string-equal major-mode 'dired-mode)
             (progn
               (let (($result (mapconcat 'identity (dired-get-marked-files) "\n")))
                 (if (equal (length $result) 0)
                     (progn default-directory )
                   (progn $result))))
           (if (buffer-file-name)
               (buffer-file-name)
             (expand-file-name default-directory)))))
    (kill-new
     (if @dir-path-only-p
         (progn
           (message "Directory path copied: 「%s」" (file-name-directory $fpath))
           (file-name-directory $fpath))
       (progn
         (message "File path copied: 「%s」" $fpath)
         $fpath )))))

(defun my/org-to-rdf ()
  "Export region to HTML, and copy it to the clipboard."
  (interactive)
  (save-window-excursion
    (let* ((buf (org-export-to-buffer 'html "*Formatted Copy*" nil nil t t))
           (html (with-current-buffer buf (buffer-string))))
      (with-current-buffer buf
        (shell-command-on-region
         (point-min)
         (point-max)
         "textutil -stdin -format html -convert rtf -stdout | pbcopy"))
      (kill-buffer buf)))) ;; need to find alternative to textutil on windows (or just switch you know, fuck windows)

;; sourced from a site, it's gone now
(defun load-directory (dir)
  (let ((load-it (lambda (f)
		               (load-file (concat (file-name-as-directory dir) f)))))
	  (mapc load-it (directory-files dir nil "\\.el$")))) ; from https://www.emacswiki.org/emacs/LoadingLispFiles

(defun my/register-window-check (register)
  "This function fills a register with the current window configuration. If it's already filled, it asks for confirmation first. "
  (interactive "P")
  (if (get-register register)
      (progn 
        (ding)
        (if (y-or-n-p "Register is already filled, overwrite?")
            (window-configuration-to-register register)))
    (window-configuration-to-register register)))


(defun my/tempdir (&optional location)
  "Creates a directory in location if given, otherwise in /tmp/,
and enters it in a dired buffer.  "
  (interactive "P")
  (let ((tmp (shell-command-to-string "mktemp -d"))
        (prefix-length))
    (if location
          (setq prefix-length 4)
      (progn
        (setq location nil)
        (setq prefix-length 0)))
    
    (find-file (concat location (substring tmp prefix-length (- (length tmp) 1)) "/" ))))

(defun endless/fill-or-unfill ()
  "Like `fill-paragraph', but unfill if used twice."
  ;; from http://endlessparentheses.com/fill-and-unfill-paragraphs-with-a-single-key.html
  (interactive)
  (let ((fill-column
         (if (eq last-command 'endless/fill-or-unfill)
             (progn (setq this-command nil)
                    (point-max))
           fill-column)))
    (call-interactively #'fill-paragraph)))

(defun my/unfill-paragraph ()
  "unfills a paragraph, the opposite of `fill-paragraph'.  "
  (interactive)
  (let ((fill-column
         (progn (setq this-command nil)
                (point-max)
                fill-column)))
    (call-interactively #'fill-paragraph)))

(defun my/rand-chars ()
  "Create a small random set of chars based on the sha1 of
current nanosecond.  "
  (interactive)
  (string-join (nthcdr 34 (split-string (sha1 (format-time-string "%N")) ""))))


(defun my/big-font-size ()
  "Set the font size to be big"
  (interactive)
  (set-face-attribute 'default nil :height 200))

(defun my/standard-font-size ()
  "Set the font size to standard"
  (interactive)
  (set-face-attribute 'default nil :height 140))

(defun my/present-mode (args)
  "makes emacs use bigger font, use lightmode, and disable transparancy. "
  (interactive "P")
  (progn 
    (load-theme 'doom-one-light t) 
    (setq my/day-night-switch "doom-one-light")
    (my/set-transparency 100 100)
    (my/big-font-size)))
