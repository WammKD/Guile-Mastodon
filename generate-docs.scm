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
             (ice-9 regex)
             (ice-9 session)
             (srfi  srfi-1))

(add-to-load-path ".")

(let ([dir (opendir "docs")])
  (do ([entry (readdir dir) (readdir dir)])
      [(eof-object? entry)]
    (when (not (or (string=? entry ".") (string=? entry "..")))
      (delete-file (string-append "docs/" entry))))

  (closedir dir))

(define modulesAndExports (let ([dir (opendir "elefan")])
                            (let loop ([entry  (readdir dir)]
                                       [result           '()])
                              (if (eof-object? entry)
                                  (begin
                                    (closedir dir)

                                    result)
                                (let ([index (string-contains-ci entry ".scm")])
                                  (loop
                                    (readdir dir)
                                    (if (and
                                          index
                                          (= index (- (string-length entry) 4))
                                          (not (string-ci=? entry    "utils.scm"))
                                          (not (string-ci=? entry    "enums.scm"))
                                          (not (string-ci=? entry "entities.scm")))
                                        (let ([moduleName (substring entry 0 index)])
                                          (eval-string (string-append "(use-modules (elefan " moduleName "))"))

                                          (cons
                                            (cons
                                              moduleName
                                              (sort-list
                                                (module-map
                                                  (lambda (sym var) (symbol->string sym))
                                                  (resolve-interface `(elefan ,(string->symbol moduleName))))
                                                (lambda (s1 s2)
                                                  (let* ([singular (regexp-substitute/global #f "e?s$" moduleName 'pre "" 'post)]
                                                         [match1       (string-match (string-append "^masto-(un)?" singular) s1)]
                                                         [match2       (string-match (string-append "^masto-(un)?" singular) s2)])
                                                    (cond
                                                     [(and match1 (not match2)) #f]
                                                     [(and (not match1) match2) #t]
                                                     [(and match1 (not (eval-string (string-append "(record-type? " s1 ")")))
                                                           match2 (not (eval-string (string-append "(record-type? " s2 ")"))))
                                                                                (let ([fromRecord1 (char=?
                                                                                                     (string-ref
                                                                                                       (symbol->string
                                                                                                         (eval-string
                                                                                                           (string-append
                                                                                                             "(procedure-name "
                                                                                                             s1
                                                                                                             ")")))
                                                                                                       0)
                                                                                                     #\%)]
                                                                                      [fromRecord2 (char=?
                                                                                                     (string-ref
                                                                                                       (symbol->string
                                                                                                         (eval-string
                                                                                                           (string-append
                                                                                                             "(procedure-name "
                                                                                                             s2
                                                                                                             ")")))
                                                                                                       0)
                                                                                                     #\%)])
                                                                                  (cond
                                                                                   [(and fromRecord1 (not fromRecord2)) #t]
                                                                                   [(and (not fromRecord1) fromRecord2) #f]
                                                                                   [else                                (string<?
                                                                                                                          s1
                                                                                                                          s2)]))]
                                                     [else                      (string<? s1 s2)])))))
                                            result))
                                      result)))))))

(for-each
  (lambda (moduleNameAndExports)
    (let ([moduleName (car moduleNameAndExports)]
          [exports    (cdr moduleNameAndExports)])
      (call-with-output-file (string-append "docs/" moduleName ".md")
        (lambda (outputPort)
          (define (disp str) (display str outputPort))
          (define (newln)    (newline     outputPort))

          (disp "# ")
          (disp moduleName)
          (disp " Module")
          (newln)

          (disp (file-commentary (string-append "elefan/" moduleName ".scm")))
          (newln)
          (newln)
          (disp "<br />")
          (newln)
          (newln)

          (for-each
            (lambda (elem)
              (disp "## ")
              (disp (string-join
                      (string-split
                        (string-join (string-split elem #\<) "\\<")
                        #\>)
                      "\\>"))
              (newln)

              (disp "#### Summary")
              (newln)

              (if (eval-string (string-append "(record-type? " elem ")"))
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
                                     elem
                                     ")"))))
                (begin
                  (let* ([documentation (eval-string (string-append
                                                       "(procedure-documentation "
                                                       elem
                                                       ")"))]
                         [modulesInDocs (if (string? documentation)
                                            (filter
                                              (lambda (moduleAndExports)
                                                (any
                                                  (lambda (exportName)
                                                    (string-contains documentation exportName))
                                                  (cdr moduleAndExports)))
                                              modulesAndExports)
                                          '())])
                    (disp (if (null? modulesInDocs)
                              documentation
                            (let ([currentModule (assoc moduleName modulesInDocs)])
                              (let ([remainingModules (if (not currentModule)
                                                          modulesInDocs
                                                        (fold
                                                          (lambda (currentModuleExportName result)
                                                            (set! documentation (regexp-substitute/global
                                                                                  #f
                                                                                  currentModuleExportName
                                                                                  documentation
                                                                                  'pre
                                                                                  (string-append
                                                                                    "[`"
                                                                                    currentModuleExportName
                                                                                    "`](#"
                                                                                    (if (eval-string (string-append
                                                                                                       "(record-type? "
                                                                                                       currentModuleExportName
                                                                                                       ")"))
                                                                                        (substring
                                                                                          currentModuleExportName
                                                                                          1
                                                                                          (1- (string-length
                                                                                                currentModuleExportName)))
                                                                                      currentModuleExportName)
                                                                                    ")")
                                                                                  'post))

                                                            (map
                                                              (lambda (module)
                                                                (cons
                                                                  (car module)
                                                                  (filter
                                                                    (lambda (otherModuleExportName)
                                                                      (not (string=?
                                                                               otherModuleExportName
                                                                             currentModuleExportName)))
                                                                    (cdr module))))
                                                              result))
                                                          (filter
                                                            (lambda (module)
                                                              (not (equal? module currentModule)))
                                                            modulesInDocs)
                                                          (cdr currentModule)))])
                                  (fold
                                    (lambda (module result)
                                      (append
                                        result
                                        (fold
                                          (lambda (exportName r2)
                                            (if (any (lambda (mod)
                                                       (string=? exportName (cdr mod))) result)
                                                r2
                                              (cons (cons (car module) exportName) r2)))
                                          '()
                                          (cdr module))))
                                    '()
                                    remainingModules)

                                documentation)))))
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
                                              elem
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
                                              elem
                                              ")")) 'keyword))

                  (for-each
                    (lambda (optAsSym)
                      (disp "> ![#c5f015](https://placehold.it/15/c5f015/000000?text=+) `[")
                      (disp optAsSym)
                      (disp "]` <br />")
                      (newln))
                    (assoc-ref (eval-string (string-append
                                              "(procedure-arguments "
                                              elem
                                              ")")) 'optional))))

              (newln)
              (disp "<br />")
              (newln)
              (newln))
            exports)))))
  modulesAndExports)
