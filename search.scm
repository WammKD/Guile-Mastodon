(define-module (elefan search)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (elefan utils)
  #:use-module (ice-9 receive)
  #:use-module (json)
  #:use-module (rnrs bytevectors)
  #:use-module (web client)
  #:export (masto-search))

(define* (masto-search mastoApp query #:key resolve    [limit 40]
                                            [offset 0] following)
  (receive (header body)
      (http-get
        (string-append (masto-app-domain mastoApp) "/api/v2/search"
                       (assemble-params `(("q"         ,query)
                                          ("resolve"   ,(if resolve
                                                            "true"
                                                          "false"))
                                          ("limit"     ,(number->string limit))
                                          ("offset"    ,(number->string offset))
                                          ("following" ,(if following
                                                            "true"
                                                          "false")))))
        #:headers `((Authorization . ,(string-append
                                        "Bearer "
                                        (masto-app-token mastoApp)))))
    (if-let ([bodySCM (cut assoc-ref <> "error") (json-string->scm
                                                   (utf8->string body))])
        (error (assoc-ref bodySCM "error"))
      (generate-masto-results bodySCM))))
