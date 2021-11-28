(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t))

(setq package-check-signature nil)
(package-initialize)

(eval-when-compile
  (require 'use-package))
(load "~/.emacs.d/box") 
(load "~/.emacs.d/customlisp")

(load "~/.emacs.d/setup/packages")
(load "~/.emacs.d/setup/modes")

(load-directory "~/.emacs.d/setup")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(async-shell-command-buffer 'new-buffer)
 '(auth-source-save-behavior nil)
 '(beacon-mode t)
 '(browse-url-dwim-search-url "https://duckduckgo.com/?q=")
 '(c-basic-offset 2)
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(compilation-message-face 'default)
 '(css-indent-offset 2)
 '(custom-safe-themes
   '("77113617a0642d74767295c4408e17da3bfd9aa80aaa2b4eeb34680f6172d71a" "f4876796ef5ee9c82b125a096a590c9891cec31320569fc6ff602ff99ed73dca" "0058a6b4a07da711bb084ecc06af893e8e13ddd4a7372ebdc5ed4e1a23f00d8f" "e074be1c799b509f52870ee596a5977b519f6d269455b84ed998666cf6fc802a" "9efb2d10bfb38fe7cd4586afb3e644d082cbcdb7435f3d1e8dd9413cbe5e61fc" "f2927d7d87e8207fa9a0a003c0f222d45c948845de162c885bf6ad2a255babfd" "990e24b406787568c592db2b853aa65ecc2dcd08146c0d22293259d400174e37" "f7216d3573e1bd2a2b47a2331f368b45e7b5182ddbe396d02b964b1ea5c5dc27" "c4bdbbd52c8e07112d1bfd00fee22bf0f25e727e95623ecb20c4fa098b74c1bd" "57bd93e7dc5fbb5d8d27697185b753f8563fe0db5db245592bab55a8680fdd8c" "76bfa9318742342233d8b0b42e824130b3a50dcc732866ff8e47366aed69de11" "a3b6a3708c6692674196266aad1cb19188a6da7b4f961e1369a68f06577afa16" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "2f1518e906a8b60fac943d02ad415f1d8b3933a5a7f75e307e6e9a26ef5bf570" "e1ecb0536abec692b5a5e845067d75273fe36f24d01210bf0aa5842f2a7e029f" "99ea831ca79a916f1bd789de366b639d09811501e8c092c85b2cb7d697777f93" "e47c0abe03e0484ddadf2ae57d32b0f29f0b2ddfe7ec810bd6d558765d9a6a6c" "6cbf6003e137485fb3f904e76fb15bc48abc386540f43f54e2a47a9884e679f6" "f589e634c9ff738341823a5a58fc200341b440611aaa8e0189df85b44533692b" "728eda145ad16686d4bbb8e50d540563573592013b10c3e2defc493f390f7d83" "2d1fe7c9007a5b76cea4395b0fc664d0c1cfd34bb4f1860300347cdad67fb2f9" "7e13dae26544cdfb7f78f6a0e01a032c350b76d9846e7420e40e7f1a02d0ffd9" "0f1733ad53138ddd381267b4033bcb07f5e75cd7f22089c7e650f1bb28fc67f4" "100e7c5956d7bb3fd0eebff57fde6de8f3b9fafa056a2519f169f85199cc1c96" "151bde695af0b0e69c3846500f58d9a0ca8cb2d447da68d7fbf4154dcf818ebc" "1c082c9b84449e54af757bcae23617d11f563fc9f33a832a8a2813c4d7dfb652" "1c68ad348a28e105d4aae205960f8e9a7cc74c46ad4a40654159e2f1c0fa39a5" "1cbdf1c508e037558c4a9b24d5b2fc7e3624b0ef584a8cd6e861a9cabaabb3c7" "1d0ee3d14476f29dc12e3ed9803c4a634ed8f375d2b160e7eae24fe71c324083" "207d0136715f18123edf9dfd9092a085071bf7fd41046e2a48c2be84edffcf3f" "2642a1b7f53b9bb34c7f1e032d2098c852811ec2881eec2dc8cc07be004e45a0" "2757944f20f5f3a2961f33220f7328acc94c88ef6964ad4a565edc5034972a53" "28bf1b0a72e3a1e08242d776c5befc44ba67a36ced0e55df27cfc7ae6be6c24d" "2a9039b093df61e4517302f40ebaf2d3e95215cb2f9684c8c1a446659ee226b9" "341c1c68fe9c8f85736f7fb3e4ab109f2d721bc06bab762b23ed8987b062e353" "349f63f41ca90d411daa4bf68fb6245faa0a778230aa9f422dfbc31dfabb4b32" "3adb42835b51c3a55bc6c1e182a0dd8d278c158769830da43705646196fc367e" "3ce89d5be2e45e0c32d0cfa114ad716b76d3f10704b0e8940ce5e0f4416b10f0" "3da031b25828b115c6b50bb92a117f5c0bbd3d9d0e9ba5af3cd2cb9db80db1c2" "4697a2d4afca3f5ed4fdf5f715e36a6cac5c6154e105f3596b44a4874ae52c45" "565aa482e486e2bdb9c3cf5bfb14d1a07c4a42cfc0dc9d6a14069e53b6435b56" "57ce54bd15e53ba857b4080ebbeccf3b21bf6a332cfce68b8fed6e163d9c7841" "595617a3c537447aa7e76ce05c8d43146a995296ea083211225e7efc069c598f" "638804ac37c0d35746cd9c933f5e03d60b830c92e05b0bbcbedffc95bee3f775" "6b2636879127bf6124ce541b1b2824800afc49c6ccd65439d6eb987dbf200c36" "6b289bab28a7e511f9c54496be647dc60f5bd8f9917c9495978762b99d8c96a0" "6d589ac0e52375d311afaa745205abb6ccb3b21f6ba037104d71111e7e76a3fc" "718fb4e505b6134cc0eafb7dad709be5ec1ba7a7e8102617d87d3109f56d9615" "75d3dde259ce79660bac8e9e237b55674b910b470f313cdf4b019230d01a982a" "7e78a1030293619094ea6ae80a7579a562068087080e01c2b8b503b27900165c" "7f89ec3c988c398b88f7304a75ed225eaac64efa8df3638c815acc563dfd3b55" "834dd2f8d07bee7897b8119afa1f97aa24f1864ba232eb769c3236ea236ca99a" "85968e61ff2c490f687a8159295efb06dd05764ec37a5aef2c59abbd485f0ee4" "8aca557e9a17174d8f847fb02870cb2bb67f3b6e808e46c0e54a44e3e18e1020" "8b4d8679804cdca97f35d1b6ba48627e4d733531c64f7324f764036071af6534" "9399db70f2d5af9c6e82d4f5879b2354b28bc7b5e00cc8c9d568e5db598255c4" "93a0885d5f46d2aeac12bf6be1754faa7d5e28b27926b8aa812840fe7d0b7983" "9d8a6fc87b97f99cc88f89ac39591c70a92a41253bffe1068a783b48a059db76" "a0befffb88a6ef016010ee95e4799648f5aa6f0ab92cedb37868b97e45f85a13" "a3fa4abaf08cc169b61dea8f6df1bbe4123ec1d2afeb01c17e11fdc31fc66379" "a4df5d4a4c343b2712a8ed16bc1488807cd71b25e3108e648d4a26b02bc990b3" "a622aaf6377fe1cd14e4298497b7b2cae2efc9e0ce362dade3a58c16c89e089c" "a63355b90843b228925ce8b96f88c587087c3ee4f428838716505fd01cf741c8" "aaffceb9b0f539b6ad6becb8e96a04f2140c8faa1de8039a343a4f1e009174fb" "b54826e5d9978d59f9e0a169bbd4739dd927eead3ef65f56786621b53c031a7c" "bd7b7c5df1174796deefce5debc2d976b264585d51852c962362be83932873d9" "be327a6a477b07f76081480fb93a61fffaa8ddc2acc18030e725da75342b2c2e" "c3d4af771cbe0501d5a865656802788a9a0ff9cf10a7df704ec8b8ef69017c68" "cc8d032279b50d4c8a0caa9df6245cbbbfbfcc74f9b2ec26054ea4306fdf6b24" "cd736a63aa586be066d5a1f0e51179239fe70e16a9f18991f6f5d99732cabb32" "d1b4990bd599f5e2186c3f75769a2c5334063e9e541e37514942c27975700370" "d1ede12c09296a84d007ef121cd72061c2c6722fcb02cb50a77d9eae4138a3ff" "d2e9c7e31e574bf38f4b0fb927aaff20c1e5f92f72001102758005e53d77b8c9" "d890583c83cb36550c2afb38b891e41992da3b55fecd92e0bb458fb047d65fb3" "d950e6bcd6209e222e71771e0f9c6354a41f416a4257a22fd69ce61ce1566379" "e1ad20f721b90cc8e1f57fb8150f81e95deb7ecdec2062939389a4b66584c0cf" "e2ba9d9a5609c6809615d68b2e3ee6817079cd0195143385c24ee4e4a8e05c23" "e2fd81495089dc09d14a88f29dfdff7645f213e2c03650ac2dd275de52a513de" "e3fc83cdb5f9db0d0df205f5da89af76feda8c56d79a653a5d092c82c7447e02" "e893b3d424a9b8b19fb8ab8612158c5b12b9071ea09bade71ba60f43c69355e6" "ec5f697561eaf87b1d3b087dd28e61a2fc9860e4c862ea8e6b0b77bd4967d0ba" "ecba61c2239fbef776a72b65295b88e5534e458dfe3e6d7d9f9cb353448a569e" "eea01f540a0f3bc7c755410ea146943688c4e29bea74a29568635670ab22f9bc" "f0dc4ddca147f3c7b1c7397141b888562a48d9888f1595d69572db73be99a024" "f2fa15848120eac87914c1c6628d97399436f879cb4bb01e98ddb36875cbb5e6" "f41ecd2c34a9347aeec0a187a87f9668fa8efb843b2606b6d5d92a653abe2439" "f4260b30a578a781b4c0858a4a0a6071778aaf69aed4ce2872346cbb28693c1a" "f97e1d3abc6303757e38130f4003e9e0d76026fc466d9286d661499158a06d99" "fd3c7bd752f48dcb7efa5f852ef858c425b1c397b73851ff8816c0580eab92f1" "fe666e5ac37c2dfcf80074e88b9252c71a22b6f5d2f566df9a7aa4f9bea55ef8" "0f1733ad53138ddd381267b4033bcb07f5e75cd7f22089c7e650f1bb28fc67f4" "100e7c5956d7bb3fd0eebff57fde6de8f3b9fafa056a2519f169f85199cc1c96" "151bde695af0b0e69c3846500f58d9a0ca8cb2d447da68d7fbf4154dcf818ebc" "1c082c9b84449e54af757bcae23617d11f563fc9f33a832a8a2813c4d7dfb652" "1c68ad348a28e105d4aae205960f8e9a7cc74c46ad4a40654159e2f1c0fa39a5" "1cbdf1c508e037558c4a9b24d5b2fc7e3624b0ef584a8cd6e861a9cabaabb3c7" "1d0ee3d14476f29dc12e3ed9803c4a634ed8f375d2b160e7eae24fe71c324083" "207d0136715f18123edf9dfd9092a085071bf7fd41046e2a48c2be84edffcf3f" "2757944f20f5f3a2961f33220f7328acc94c88ef6964ad4a565edc5034972a53" "28bf1b0a72e3a1e08242d776c5befc44ba67a36ced0e55df27cfc7ae6be6c24d" "2a9039b093df61e4517302f40ebaf2d3e95215cb2f9684c8c1a446659ee226b9" "341c1c68fe9c8f85736f7fb3e4ab109f2d721bc06bab762b23ed8987b062e353" "349f63f41ca90d411daa4bf68fb6245faa0a778230aa9f422dfbc31dfabb4b32" "3adb42835b51c3a55bc6c1e182a0dd8d278c158769830da43705646196fc367e" "3ce89d5be2e45e0c32d0cfa114ad716b76d3f10704b0e8940ce5e0f4416b10f0" "4697a2d4afca3f5ed4fdf5f715e36a6cac5c6154e105f3596b44a4874ae52c45" "49ec957b508c7d64708b40b0273697a84d3fee4f15dd9fc4a9588016adee3dad" "565aa482e486e2bdb9c3cf5bfb14d1a07c4a42cfc0dc9d6a14069e53b6435b56" "571a762840562ec5b31b6a9d4b45cfb1156ce52339e188a8b66749ed9b3b22a2" "57ce54bd15e53ba857b4080ebbeccf3b21bf6a332cfce68b8fed6e163d9c7841" "638804ac37c0d35746cd9c933f5e03d60b830c92e05b0bbcbedffc95bee3f775" "6b2636879127bf6124ce541b1b2824800afc49c6ccd65439d6eb987dbf200c36" "6b289bab28a7e511f9c54496be647dc60f5bd8f9917c9495978762b99d8c96a0" "6d589ac0e52375d311afaa745205abb6ccb3b21f6ba037104d71111e7e76a3fc" "718fb4e505b6134cc0eafb7dad709be5ec1ba7a7e8102617d87d3109f56d9615" "75d3dde259ce79660bac8e9e237b55674b910b470f313cdf4b019230d01a982a" "7e78a1030293619094ea6ae80a7579a562068087080e01c2b8b503b27900165c" "7f89ec3c988c398b88f7304a75ed225eaac64efa8df3638c815acc563dfd3b55" "834dd2f8d07bee7897b8119afa1f97aa24f1864ba232eb769c3236ea236ca99a" "85968e61ff2c490f687a8159295efb06dd05764ec37a5aef2c59abbd485f0ee4" "8aca557e9a17174d8f847fb02870cb2bb67f3b6e808e46c0e54a44e3e18e1020" "8b4d8679804cdca97f35d1b6ba48627e4d733531c64f7324f764036071af6534" "9399db70f2d5af9c6e82d4f5879b2354b28bc7b5e00cc8c9d568e5db598255c4" "93a0885d5f46d2aeac12bf6be1754faa7d5e28b27926b8aa812840fe7d0b7983" "9d8a6fc87b97f99cc88f89ac39591c70a92a41253bffe1068a783b48a059db76" "a0befffb88a6ef016010ee95e4799648f5aa6f0ab92cedb37868b97e45f85a13" "a3fa4abaf08cc169b61dea8f6df1bbe4123ec1d2afeb01c17e11fdc31fc66379" "a4df5d4a4c343b2712a8ed16bc1488807cd71b25e3108e648d4a26b02bc990b3" "a622aaf6377fe1cd14e4298497b7b2cae2efc9e0ce362dade3a58c16c89e089c" "a63355b90843b228925ce8b96f88c587087c3ee4f428838716505fd01cf741c8" "aaffceb9b0f539b6ad6becb8e96a04f2140c8faa1de8039a343a4f1e009174fb" "b54826e5d9978d59f9e0a169bbd4739dd927eead3ef65f56786621b53c031a7c" "bd7b7c5df1174796deefce5debc2d976b264585d51852c962362be83932873d9" "be327a6a477b07f76081480fb93a61fffaa8ddc2acc18030e725da75342b2c2e" "c3d4af771cbe0501d5a865656802788a9a0ff9cf10a7df704ec8b8ef69017c68" "cc8d032279b50d4c8a0caa9df6245cbbbfbfcc74f9b2ec26054ea4306fdf6b24" "cd736a63aa586be066d5a1f0e51179239fe70e16a9f18991f6f5d99732cabb32" "d1b4990bd599f5e2186c3f75769a2c5334063e9e541e37514942c27975700370" "d1ede12c09296a84d007ef121cd72061c2c6722fcb02cb50a77d9eae4138a3ff" "d2e9c7e31e574bf38f4b0fb927aaff20c1e5f92f72001102758005e53d77b8c9" "d890583c83cb36550c2afb38b891e41992da3b55fecd92e0bb458fb047d65fb3" "d950e6bcd6209e222e71771e0f9c6354a41f416a4257a22fd69ce61ce1566379" "e1ad20f721b90cc8e1f57fb8150f81e95deb7ecdec2062939389a4b66584c0cf" "e2ba9d9a5609c6809615d68b2e3ee6817079cd0195143385c24ee4e4a8e05c23" "e2fd81495089dc09d14a88f29dfdff7645f213e2c03650ac2dd275de52a513de" "e3fc83cdb5f9db0d0df205f5da89af76feda8c56d79a653a5d092c82c7447e02" "e893b3d424a9b8b19fb8ab8612158c5b12b9071ea09bade71ba60f43c69355e6" "ec5f697561eaf87b1d3b087dd28e61a2fc9860e4c862ea8e6b0b77bd4967d0ba" "ecba61c2239fbef776a72b65295b88e5534e458dfe3e6d7d9f9cb353448a569e" "eea01f540a0f3bc7c755410ea146943688c4e29bea74a29568635670ab22f9bc" "f0dc4ddca147f3c7b1c7397141b888562a48d9888f1595d69572db73be99a024" "f2fa15848120eac87914c1c6628d97399436f879cb4bb01e98ddb36875cbb5e6" "f41ecd2c34a9347aeec0a187a87f9668fa8efb843b2606b6d5d92a653abe2439" "f4260b30a578a781b4c0858a4a0a6071778aaf69aed4ce2872346cbb28693c1a" "f97e1d3abc6303757e38130f4003e9e0d76026fc466d9286d661499158a06d99" "fe666e5ac37c2dfcf80074e88b9252c71a22b6f5d2f566df9a7aa4f9bea55ef8"))
 '(doc-view-continuous t)
 '(doc-view-ghostscript-program "C:\\Program Files\\gs\\gs9.2D\\bin\\gswin64.exe")
 '(elfeed-curl-extra-arguments '("--insecure"))
 '(elfeed-curl-timeout 120)
 '(elfeed-goodies/entry-pane-position 'bottom)
 '(elfeed-goodies/entry-pane-size 0.9)
 '(elfeed-goodies/feed-source-column-width 24)
 '(elfeed-goodies/html-decode-title-tags '(em))
 '(elfeed-goodies/powerline-default-separator 'butt)
 '(elfeed-goodies/show-mode-padding 1)
 '(elfeed-goodies/tag-column-width 0)
 '(elfeed-goodies/wide-threshold 0.8)
 '(ensime-sem-high-faces
   '((var :foreground "#000000" :underline
          (:style wave :color "yellow"))
     (val :foreground "#000000")
     (varField :foreground "#600e7a" :slant italic)
     (valField :foreground "#600e7a" :slant italic)
     (functionCall :foreground "#000000" :slant italic)
     (implicitConversion :underline
                         (:color "#c0c0c0"))
     (implicitParams :underline
                     (:color "#c0c0c0"))
     (operator :foreground "#000080")
     (param :foreground "#000000")
     (class :foreground "#20999d")
     (trait :foreground "#20999d" :slant italic)
     (object :foreground "#5974ab" :slant italic)
     (package :foreground "#000000")
     (deprecated :strike-through "#000000")))
 '(evil-buffer-regexps '(("\\*Tetris\\*") ("^ \\*load\\*")))
 '(fci-rule-color "#3C3D37")
 '(fill-column 70)
 '(flycheck-disabled-checkers '(haskell-stack-ghc))
 '(flycheck-pylintrc "~/.pylintrc")
 '(flycheck-python-mypy-config "~/.mypy.ini")
 '(helm-completion-style 'emacs)
 '(helm-ff-auto-update-initial-value t)
 '(helm-minibuffer-history-key "M-p")
 '(highlight-changes-colors '("#FD5FF0" "#AE81FF"))
 '(highlight-tail-colors
   '(("#3C3D37" . 0)
     ("#679A01" . 20)
     ("#4BBEAE" . 30)
     ("#1DB4D0" . 50)
     ("#9A8F21" . 60)
     ("#A75B00" . 70)
     ("#F309DF" . 85)
     ("#3C3D37" . 100)))
 '(ibuffer-saved-filter-groups
   '(("standardFilter"
      ("standardFilter"
       (name . "\\`[^*.]")))))
 '(ibuffer-saved-filters
   '((stand
      (name . "\\`[^*.]"))
     ("standardFilter"
      ((name . "\\`[^*.]")))
     ("gnus"
      ((or
        (mode . message-mode)
        (mode . mail-mode)
        (mode . gnus-group-mode)
        (mode . gnus-summary-mode)
        (mode . gnus-article-mode))))
     ("programming"
      ((or
        (mode . emacs-lisp-mode)
        (mode . cperl-mode)
        (mode . c-mode)
        (mode . java-mode)
        (mode . idl-mode)
        (mode . lisp-mode))))))
 '(interleave-disable-narrowing t)
 '(ispell-personal-dictionary "~/.emacs.d/ispell-personal-dictionary")
 '(jdee-db-active-breakpoint-face-colors (cons "#1B2229" "#51afef"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#1B2229" "#98be65"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#1B2229" "#3f444a"))
 '(js-indent-level 4)
 '(keyboard-coding-system 'utf-8)
 '(lsp-eldoc-render-all t)
 '(lsp-pyls-plugins-pycodestyle-enabled nil)
 '(lsp-pyls-plugins-pycodestyle-ignore "e231")
 '(lsp-pyls-plugins-pyflakes-enabled t)
 '(magit-diff-use-overlays nil)
 '(midnight-mode t)
 '(minimap-hide-fringes t)
 '(minimap-highlight-line nil)
 '(minimap-mode nil)
 '(minimap-window-location 'right)
 '(nrepl-message-colors
   '("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3"))
 '(objed-cursor-color "#ff6c6b")
 '(org-attach-screenshot-command-line "gnome-screenshot -a -f %f")
 '(org-ditaa-jar-path "/usr/bin/ditaa")
 '(org-emphasis-alist
   '(("~"
      (:foreground "red"))
     ("*" bold)
     ("/" italic)
     ("_" underline)
     ("=" org-verbatim verbatim)
     ("~" org-code verbatim)))
 '(org-entities-user
   '(("interrobang" "\\textinterrobang" nil "&#8253;" "?" "" "‽")
     ("vdash" "\\vdash" t "&#10205" "|" "|" "⊢")
     ("whitediamond" "\\whitediamond" t "&#9671" "d" "d" "◇")
     ("naturals" "\\mathbb{N}" t "&#8469" "N" "N" "ℕ")
     ("integers" "\\mathbb{Z}" t "&#8484" "Z" "Z" "ℤ")
     ("square" "\\square" t "&#9633" "■" "" "□")))
 '(org-format-latex-options
   '(:foreground default :background default :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
                 ("begin" "$1" "$" "$$" "\\(" "\\[")))
 '(org-hide-leading-stars t)
 '(org-latex-packages-alist '(("" "amsmath" nil)))
 '(org-list-allow-alphabetical t)
 '(org-odt-preferred-output-format "docx")
 '(org-roam-capture-templates
   '(("d" "default" plain #'org-roam-capture--get-point "%?" :file-name "%<%Y%m%d%H%M%S>-${slug}" :head "#+title: ${title}
#+roam_alias: 
#+roam_tags:  " :unnarrowed t)))
 '(org-roam-encrypt-files nil)
 '(package-check-signature 'allow-unsigned)
 '(package-selected-packages
   '(vimrc-mode dockerfile-mode yaml-mode ag vterm workgroups2 window-purpose which-key use-package treemacs-all-the-icons ssh-agency speed-type sass-mode ranger projectile powershell pdf-tools org-roam org-bullets omnisharp ob-async multiple-cursors minimap markdown-mode+ lsp-ui lsp-java lsp-ivy json-mode interleave highlight-parentheses hide-lines helpful helm-lsp git-gutter-fringe fish-mode evil-magit evil-collection ess emojify elpy elisp-demos elfeed-goodies ein editorconfig doom-themes doom-modeline direx dired-k dimmer counsel company-quickhelp company-lsp cmake-mode browse-url-dwim beacon atomic-chrome all-the-icons-dired))
 '(pdf-view-midnight-colors '("#DCDCCC" . "#383838"))
 '(pos-tip-background-color "#FFFACE")
 '(pos-tip-foreground-color "#272822")
 '(powerline-default-separator 'alternate)
 '(powerline-display-mule-info nil)
 '(powerline-gui-use-vcs-glyph t)
 '(powerline-image-apple-rgb t t)
 '(powerline-text-scale-factor 0.8)
 '(powerline-utf-8-separator-left 2503)
 '(powerline-utf-8-separator-right 2503)
 '(purpose-mode nil)
 '(python-indent-offset 4)
 '(ranger-show-literal nil)
 '(rtags-diagnostics-summary-in-mode-line nil)
 '(rtags-path "/home/mathan/Downloads/rtags/bin/")
 '(rustic-ansi-faces
   ["#282c34" "#ff6c6b" "#98be65" "#ECBE7B" "#51afef" "#c678dd" "#46D9FF" "#bbc2cf"])
 '(safe-local-variable-values
   '((flycheck-disabled-checkers . emacs-lisp-checkdoc)
     (eval auto-save-mode t)))
 '(sh-basic-offset 2)
 '(truncate-lines nil)
 '(vc-annotate-background "#282c34")
 '(vc-annotate-color-map
   '((20 . "#F92672")
     (40 . "#CF4F1F")
     (60 . "#C26C0F")
     (80 . "#E6DB74")
     (100 . "#AB8C00")
     (120 . "#A18F00")
     (140 . "#989200")
     (160 . "#8E9500")
     (180 . "#A6E22E")
     (200 . "#729A1E")
     (220 . "#609C3C")
     (240 . "#4E9D5B")
     (260 . "#3C9F79")
     (280 . "#A1EFE4")
     (300 . "#299BA6")
     (320 . "#2896B5")
     (340 . "#2790C3")
     (360 . "#66D9EF")))
 '(vc-annotate-very-old-color nil)
 '(warning-suppress-types '((\(yasnippet\ backquote-change\))))
 '(weechat-color-list
   '(unspecified "#272822" "#3C3D37" "#F70057" "#F92672" "#86C30D" "#A6E22E" "#BEB244" "#E6DB74" "#40CAE4" "#66D9EF" "#FB35EA" "#FD5FF0" "#74DBCD" "#A1EFE4" "#F8F8F2" "#F8F8F0"))
 '(writeroom-maximize-window nil)
 '(writeroom-width 135)
 '(yas-wrap-around-region t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-echo-common ((t (:foreground "gray59"))))
 '(company-preview ((t (:background "gray15" :foreground "wheat"))))
 '(company-preview-common ((t (:inherit company-preview :foreground "gray59"))))
 '(company-scrollbar-bg ((t (:background "slate gray"))))
 '(company-scrollbar-fg ((t (:background "AntiqueWhite3"))))
 '(company-template-field ((t (:background "gray38" :foreground "snow"))))
 '(company-tooltip ((t (:background "gray27" :foreground "snow"))))
 '(company-tooltip-selection ((t (:background "DeepSkyBlue4"))))
 '(helm-selection ((t (:background "medium blue" :distant-foreground "black"))))
 '(helm-source-header ((t (:background "gray29" :foreground "white" :weight bold :height 1.3 :family "Sans Serif"))))
 '(table-cell ((t (:background "#36273E" :inverse-video nil)))))

;;; init.el ends here
