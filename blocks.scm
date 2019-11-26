(define-module (elefan blocks)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (ice-9 receive)
  #:use-module (json)
  #:use-module (rnrs bytevectors)
  #:use-module (web client)
  #:export (masto-blocks-all
            masto-block-account
            masto-unblock-account))

(define* (masto-blocks-all mastoApp #:optional [limit 40])
  (generate-masto-page
    mastoApp
    http-get
    (string-append (masto-app-domain mastoApp) "/api/v1/blocks"
                   "?limit="                   (number->string limit))
    generate-masto-account-array))

(define (masto-block-account mastoApp accountID)
  (receive (header body)
      (http-post
        (string-append (masto-app-domain mastoApp) "/api/v1/accounts/"
                       accountID                   "/block")
        #:headers `((Authorization . ,(string-append
                                        "Bearer "
                                        (masto-app-token mastoApp)))))
    (generate-masto-relationship (json-string->scm (utf8->string body)))))

(define (masto-unblock-account mastoApp accountID)
  (receive (header body)
      (http-post
        (string-append (masto-app-domain mastoApp) "/api/v1/accounts/"
                       accountID                   "/unblock")
        #:headers `((Authorization . ,(string-append
                                        "Bearer "
                                        (masto-app-token mastoApp)))))
    (generate-masto-relationship (json-string->scm (utf8->string body)))))
