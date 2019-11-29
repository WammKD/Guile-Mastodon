(define-module (elefan domain-blocks)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (elefan utils)
  #:use-module (ice-9 receive)
  #:use-module (json)
  #:use-module (rnrs bytevectors)
  #:use-module (web client)
  #:export (masto-domain-blocks-all
            masto-block-domain
            masto-unblock-domain))

(define* (masto-domain-blocks-all mastoApp #:optional [limit 40])
  (generate-masto-page
    mastoApp
    http-get
    (string-append (masto-app-domain mastoApp) "/api/v1/domain_blocks"
                   "?limit="                   (number->string limit))
    vector->list))

(define (masto-block-domain mastoApp domain)
  (receive (header body)
      (http-post
        (string-append (masto-app-domain mastoApp) "/api/v1/domain_blocks"
                       "?domain="                  domain)
        #:headers `((Authorization . ,(string-append
                                        "Bearer "
                                        (masto-app-token mastoApp)))))
    (if-let ([errMsg (assoc-ref (json-string->scm (utf8->string body)) "error")])
        (error errMsg)
      #t)))

(define (masto-unblock-domain mastoApp domain)
  (receive (header body)
      (http-delete
        (string-append (masto-app-domain mastoApp) "/api/v1/domain_blocks"
                       "?domain="                  domain)
        #:headers `((Authorization . ,(string-append
                                        "Bearer "
                                        (masto-app-token mastoApp)))))
    (if-let ([errMsg (assoc-ref (json-string->scm (utf8->string body)) "error")])
        (error errMsg)
      #t)))
