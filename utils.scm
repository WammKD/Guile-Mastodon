(define-module (elefan utils)
  #:use-module (srfi srfi-26)
  #:export (assemble-params))

(define (assemble-params params)
  (string-append/shared "?" (string-join (map (cut string-join <> "=") params) "&")))
