(define-module (elefan blocks)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (elefan utils)
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
  (generate-masto-relationship
    (http 'post
      (string-append (masto-app-domain mastoApp) "/api/v1/accounts/"
                     accountID                   "/block")
      #:token (masto-app-token mastoApp))))

(define (masto-unblock-account mastoApp accountID)
  (generate-masto-relationship
    (http 'post
      (string-append (masto-app-domain mastoApp) "/api/v1/accounts/"
                     accountID                   "/unblock")
      #:token (masto-app-token mastoApp))))
