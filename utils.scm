(define-module (elefan utils)
  #:use-module (ice-9 receive)
  #:use-module (json)
  #:use-module (rnrs bytevectors)
  #:use-module (web client)
  #:use-module (web response)
  #:use-module (web uri)
  #:export (assemble-params
            boolean->string
            http
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
            (string-join (let ([filteredValues (filter identity values)])
                           (map
                             (lambda (index value)
                               (string-append/shared
                                 (uri-encode key) "[" (number->string index) "]="
                                 (uri-encode value)))
                             (iota (length filteredValues))
                             filteredValues)) "&")))
        (filter (lambda (elem)
                  (and (cadr elem) (not (null? (cadr elem))))) params))
      "&")))

(define (boolean->string bool)
  (if bool "true" "false"))

(define* (http type url #:key body
                              token
                              queryParams
                              [contentType "application/x-www-form-urlencoded"]
                              idempotencyKey)
  (receive (headers body)
      ((assoc-ref `((get    . ,http-get)
                    (post   . ,http-post)
                    (put    . ,http-put)
                    (delete . ,http-delete)) type)
        (string-append/shared url (if queryParams (assemble-params queryParams) ""))
        #:body         (if (string? body) (string->utf8 body) body)
        #:version      '(1 . 1)
        #:keep-alive?  #f
        #:headers      (filter
                         (lambda (elem) (not (unspecified? elem)))
                         (list
                           (when token
                             (cons 'Authorization (string-append "Bearer " token)))
                           (when body (cons 'Content-Type  contentType))
                           (when idempotencyKey
                             (cons 'Idempotency-Key idempotencyKey))))
        #:decode-body? #t
        #:streaming?   #f)
    (case (response-code headers)
      [(200) (json-string->scm (utf8->string body))]
      [else  (throw 'elefan `(("response-code"   . ,(response-code          headers))
                              ("response-phrase" . ,(response-reason-phrase headers))
                              ("response"        . ,(if (bytevector? body)
                                                        (utf8->string body)
                                                      body))))])))
