(define-module (elefan utils)
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-26)
  #:export (assemble-params
            if-let
            if-let-helper))

(define-syntax if-let-helper
  (syntax-rules ()
    [(_ letVersion
        ([bnd             val]    ...)
        (cnd                      ...)
        ()                             then else) (letVersion ([bnd val] ...)
                                                    (if (and cnd ...) then else))]
    [(_ letVersion
        ([bnd             val]    ...)
        (cnd                      ...)
        ([binding       value] . rest) then else) (if-let-helper letVersion
                                                                 ([bnd val] ... [binding value])
                                                                 (cnd       ...           value)
                                                                 rest                            then else)]
    [(_ letVersion
        ([bnd             val]    ...)
        (cnd                      ...)
        ([binding funct value] . rest) then else) (if-let-helper letVersion
                                                                 ([bnd val] ... [binding value])
                                                                 (cnd       ... (funct binding))
                                                                 rest                            then else)]))
(define-syntax if-let
  (syntax-rules ()
    [(_ ([binding         value]  ...) then else) (let ([binding value] ...)
                                                    (if (and binding ...) then else))]
    [(_ (binding-funct-value      ...) then else) (if-let-helper let
                                                                 ()
                                                                 ()
                                                                 (binding-funct-value ...) then else)]))
(define-syntax if-let*
  (syntax-rules ()
    [(_ ([binding         value]  ...) then else) (let* ([binding value] ...)
                                                    (if (and binding ...) then else))]
    [(_ (binding-funct-value      ...) then else) (if-let-helper let*
                                                                 ()
                                                                 ()
                                                                 (binding-funct-value ...) then else)]))

(define (assemble-params params)
  (string-append/shared
    "?"
    (string-join
      (map
        (lambda (param)
          (if-let ([key            (car  param)]
                   [values string? (cadr param)])
              (string-join param "=")
            (let ([r (cdr (fold
                            (lambda (value result)
                              (let ([index (car result)])
                                (cons
                                  (1+ index)
                                  (string-append
                                    (cdr result)
                                    "&" (uri-encode key)
                                    "[" (number->string index) "]="
                                    (uri-encode value)))))
                            '(0 . "")
                            (filter identity values)))])
              (substring r (if (string-null? r) 0 1)))))
        (filter cadr params))
      "&")))
