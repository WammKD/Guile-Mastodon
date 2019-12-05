(define-module (elefan follow-requests)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (elefan utils)
  #:export (masto-follow-requests-all
            masto-follow-request-authorize
            masto-follow-request-reject))

(define* (masto-follow-requests-all mastoApp #:optional [limit 40])
  (generate-masto-page
    mastoApp
    'get
    (string-append (masto-app-domain mastoApp) "/api/v1/follow_requests"
                   "?limit="                   (number->string limit))
    generate-masto-account-array))

(define (masto-follow-request-authorize mastoApp requestID)
  (http 'post
    (string-append (masto-app-domain mastoApp) "/api/v1/follow_requests/"
                   requestID                   "/authorize")
    #:token (masto-app-token mastoApp))

  #t)

(define (masto-follow-request-reject mastoApp requestID)
  (http 'post
    (string-append (masto-app-domain mastoApp) "/api/v1/follow_requests/"
                   requestID                   "/reject")
    #:token (masto-app-token mastoApp))

  #t)
