;; (eval-after-load 'autoinsert
;;   '(define-auto-insert '("\\.c\\'" . "C skeleton")
;;      '(
;;        "Short description: "
;;        "/**\n * "
;;        (file-name-nondirectory (buffer-file-name))
;;        " -- " str \n
;;        " *" \n
;;        " * Written on " (format-time-string "%a, %e %B %Y.") \n
;;        " */" > \n \n
;;        "#include <stdio.h>" \n
;;        "#include \""
;;        (file-name-sans-extension
;;         (file-name-nondirectory (buffer-file-name)))
;;        ".h\"" \n \n
;;        "int main()" \n
;;        "{" > \n
;;        > _ \n
;;        "}" > \n)))


(eval-after-load 'autoinsert
  '(define-auto-insert '("\\.py\\'" . "python docstring")
     '(
       ""
       "#!/usr/bin/env python3\n"
       "# -*- coding: utf-8 -*-\n"
       "\"\"\"\n"
       "Created on " (format-time-string "%a, %Y-%m-%d %H:%M")
       "\n\n"
       "@author: mgeurtsen"
       "\n\"\"\"\n"
       )))
