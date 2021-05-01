;;; encryption

(cond
 ((string-equal system-type "windows-nt")
  (progn
    (setq epg-gpg-home-directory "c:/Users/Mathan/.gnupg")))
  
  ((string-equal system-type "darwin")
   (progn
     (warn "encryption not yet setup for mac OS. ")))
  
  ((string-equal system-type "gnu/linux")
   (progn
     (message "Setting epa for linux")
     (setq epg-gpg-home-directory "~/.gnupg")
     )))

(require 'epa-file)
(epa-file-enable)
(setq epa-file-select-keys nil)
(setq epa-file-cache-passphrase-for-symmetric-encryption nil)
(setq epa-file-inhibit-auto-save nil)
(setq epa-pinentry-mode 'loopback)

