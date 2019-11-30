(define-module (elefan endorsements)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (ice-9 receive)
  #:use-module (json)
  #:use-module (rnrs bytevectors)
  #:use-module (web client)
  #:export (masto-endorsements-all
            masto-endorse-account
            masto-unendorse-account))

(define* (masto-endorsements-all mastoApp #:optional [limit 40])
  (generate-masto-page
    mastoApp
    http-get
    (string-append (masto-app-domain mastoApp) "/api/v1/endorsements"
                   "?limit="                   (number->string limit))
    generate-masto-account-array))
    
(define (masto-endorse-account mastoApp accountID)
  (receive (header body)
      (http-post
        (string-append (masto-app-domain mastoApp) "/api/v1/accounts/"
                       accountID                   "/pin")
        #:headers `((Authorization . ,(string-append
                                        "Bearer "
                                        (masto-app-token mastoApp)))))
    (generate-masto-relationship (json-string->scm (utf8->string body)))))

(define (masto-unendorse-account mastoApp accountID)
  (receive (header body)
      (http-post
        (string-append (masto-app-domain mastoApp) "/api/v1/accounts/"
                       accountID                   "/unpin")
        #:headers `((Authorization . ,(string-append
                                        "Bearer "
                                        (masto-app-token mastoApp)))))
    (generate-masto-relationship (json-string->scm (utf8->string body)))))
