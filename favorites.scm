(define-module (elefan favorites)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (elefan utils)
  #:export (masto-favorites-all masto-favorite-status masto-unfavorite-status))

(define* (masto-favorites-all mastoApp #:optional [limit 20])
  (generate-masto-page
    mastoApp
    'get
    (string-append (masto-app-domain mastoApp) "/api/v1/favourites"
                   "?limit="                   (number->string limit))
    generate-masto-status-array))

(define (masto-favorite-status mastoApp statusID)
  (generate-masto-status
    (http 'post
      (string-append (masto-app-domain mastoApp) "/api/v1/statuses/"
                     statusID                    "/favourite")
      #:token (masto-app-token mastoApp))))

(define (masto-unfavorite-status mastoApp statusID)
  (generate-masto-status
    (http 'post
      (string-append (masto-app-domain mastoApp) "/api/v1/statuses/"
                     statusID                    "/unfavourite")
      #:token (masto-app-token mastoApp))))
