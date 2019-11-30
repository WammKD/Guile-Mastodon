(define-module (elefan follow-requests)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (ice-9 receive)
  #:use-module (json)
  #:use-module (rnrs bytevectors)
  #:use-module (web client)
  #:export (masto-follow-requests-all
            masto-follow-request-authorize
            masto-follow-request-reject))

(define* (masto-follow-requests-all mastoApp #:optional [limit 40])
  (generate-masto-page
    mastoApp
    http-get
    (string-append (masto-app-domain mastoApp) "/api/v1/follow_requests"
                   "?limit="                   (number->string limit))
    generate-masto-account-array))

(define (masto-follow-request-authorize mastoApp requestID)
  (receive (header body)
      (http-post
        (string-append (masto-app-domain mastoApp) "/api/v1/follow_requests/"
                       requestID                   "/authorize")
        #:headers `((Authorization . ,(string-append
                                        "Bearer "
                                        (masto-app-token mastoApp)))))
    (if-let ([errMsg (assoc-ref (json-string->scm (utf8->string body)) "error")])
        (error errMsg)
      #t)))

(define (masto-follow-request-reject mastoApp requestID)
  (receive (header body)
      (http-post
        (string-append (masto-app-domain mastoApp) "/api/v1/follow_requests/"
                       requestID                   "/reject")
        #:headers `((Authorization . ,(string-append
                                        "Bearer "
                                        (masto-app-token mastoApp)))))
    (if-let ([errMsg (assoc-ref (json-string->scm (utf8->string body)) "error")])
        (error errMsg)
      #t)))
