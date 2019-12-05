(define-module (elefan endorsements)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (elefan utils)
  #:export (masto-endorsements-all
            masto-endorse-account
            masto-unendorse-account))

(define* (masto-endorsements-all mastoApp #:optional [limit 40])
  (generate-masto-page
    mastoApp
    'get
    (string-append (masto-app-domain mastoApp) "/api/v1/endorsements"
                   "?limit="                   (number->string limit))
    generate-masto-account-array))
    
(define (masto-endorse-account mastoApp accountID)
  (generate-masto-relationship
    (http 'post
      (string-append (masto-app-domain mastoApp) "/api/v1/accounts/"
                     accountID                   "/pin")
      #:token (masto-app-token mastoApp))))

(define (masto-unendorse-account mastoApp accountID)
  (generate-masto-relationship
    (http 'post
      (string-append (masto-app-domain mastoApp) "/api/v1/accounts/"
                     accountID                   "/unpin")
      #:token (masto-app-token mastoApp))))
