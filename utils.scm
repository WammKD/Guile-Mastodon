(define-module (elefan utils)
  #:export (assemble-params))

(define (assemble-params params)
  (string-append/shared "?" (string-join (map (cut string-join <> "=") params) "&")))
