(define-module (elefan search)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (elefan utils)
  #:export (masto-search))

(define* (masto-search mastoApp query #:key resolve    [limit 40]
                                            [offset 0] following)
  (generate-masto-results
    (http 'get
      (string-append (masto-app-domain mastoApp) "/api/v2/search")
      #:token       (masto-app-token mastoApp)
      #:queryParams `(("q"         ,query)
                      ("resolve"   ,(boolean->string resolve))
                      ("limit"     ,(number->string  limit))
                      ("offset"    ,(number->string  offset))
                      ("following" ,(boolean->string following))))))
