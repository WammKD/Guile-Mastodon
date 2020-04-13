;;;;    Copyright (C) 2019,2020
;;;;
;;;; This library is free software; you can redistribute it and/or
;;;; modify it under the terms of the GNU General Public
;;;; License as published by the Free Software Foundation; either
;;;; version 3 of the License, or (at your option) any later version.
;;;;
;;;; This library is distributed in the hope that it will be useful,
;;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;;;; Lesser General Public License for more details.
;;;;
;;;; You should have received a copy of the GNU Lesser General Public
;;;; License along with this library; if not, write to the Free Software
;;;; Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
;;;;
(use-modules (ice-9 documentation)
             (ice-9 session))

(add-to-load-path ".")

(let ([dir (opendir "docs")])
  (do ([entry (readdir dir) (readdir dir)])
      [(eof-object? entry)]
    (when (not (or (string=? entry ".") (string=? entry "..")))
      (delete-file (string-append "docs/" entry)))))

(let ([dir (opendir "elefan")])
  (do ([entry (readdir dir) (readdir dir)])
      [(eof-object? entry)]
    (let ([index (string-contains-ci entry ".scm")])
      (when (and
              index
              (= index (- (string-length entry) 4))
              (not (string-ci=? entry "utils.scm"))
              (not (string-ci=? entry "enums.scm"))
              (not (string-ci=? entry "entities.scm")))
        (let ([moduleName (substring entry 0 index)])
          (eval-string (string-append "(use-modules (elefan " moduleName "))"))

          (call-with-output-file (string-append "docs/" moduleName ".md")
            (lambda (outputPort)
              (define (disp str) (display str outputPort))
              (define (newln)    (newline     outputPort))

              (disp "# ")
              (disp moduleName)
              (disp " Module")
              (newln)

              (disp (file-commentary (string-append "elefan/" entry)))
              (newln)
              (newln)
              (disp "<br />")
              (newln)
              (newln)

              (module-for-each
                (lambda (sym var)
                  (disp "## ")
                  (disp (string-join
                          (string-split
                            (string-join
                              (string-split (symbol->string sym) #\<)
                              "\\<")
                            #\>)
                          "\\>"))
                  (newln)

                  (disp "#### Summary")
                  (newln)

                  (if (eval-string (string-append
                                     "(record-type? "
                                     (symbol->string sym)
                                     ")"))
                      (begin
                        (disp "A record object that can be returned by an API call.")
                        (newln)

                        (disp "#### Record Fields")
                        (newln)

                        (for-each
                          (lambda (fieldAsSym)
                            (disp "> `")
                            (disp fieldAsSym)
                            (disp "` <br />")
                            (newln))
                          (eval-string (string-append
                                         "(record-type-fields "
                                         (symbol->string sym)
                                         ")"))))
                    (begin
                      (disp (eval-string (string-append
                                           "(procedure-documentation "
                                           (symbol->string sym)
                                           ")")))
                      (newln)

                      (disp "#### Parameters")
                      (newln)

                      (for-each
                        (lambda (argAsSym)
                          (disp "> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `")
                          (disp argAsSym)
                          (disp "` <br />")
                          (newln))
                        (assoc-ref (eval-string (string-append
                                                  "(procedure-arguments "
                                                  (symbol->string sym)
                                                  ")")) 'required))

                      (for-each
                        (lambda (keywordPair)
                          (disp "> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `")
                          (disp (car keywordPair))
                          (disp "` (argument position ")
                          (disp (cdr keywordPair))
                          (disp ") <br />")
                          (newln))
                        (assoc-ref (eval-string (string-append
                                                  "(procedure-arguments "
                                                  (symbol->string sym)
                                                  ")")) 'keyword))

                      (for-each
                        (lambda (optAsSym)
                          (disp "> ![#c5f015](https://placehold.it/15/c5f015/000000?text=+) `[")
                          (disp optAsSym)
                          (disp "]` <br />")
                          (newln))
                        (assoc-ref (eval-string (string-append
                                                  "(procedure-arguments "
                                                  (symbol->string sym)
                                                  ")")) 'optional))))

                  (newln)
                  (disp "<br />")
                  (newln)
                  (newln))
                (resolve-interface `(elefan ,(string->symbol moduleName))))))))))

  (closedir dir))
