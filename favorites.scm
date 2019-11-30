(define-module (elefan favorites)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (ice-9 receive)
  #:use-module (json)
  #:use-module (rnrs bytevectors)
  #:use-module (web client)
  #:export (masto-favorites-all masto-favorite-status masto-unfavorite-status))

(define* (masto-favorites-all mastoApp #:optional [limit 20])
  (generate-masto-page
    mastoApp
    http-get
    (string-append (masto-app-domain mastoApp) "/api/v1/favourites"
                   "?limit="                   (number->string limit))
    generate-masto-status-array))

(define (masto-favorite-status mastoApp statusID)
  (receive (header body)
      (http-post
        (string-append (masto-app-domain mastoApp) "/api/v1/statuses/"
                       statusID                    "/favourite")
        #:headers `((Authorization . ,(string-append
                                        "Bearer "
                                        (masto-app-token mastoApp)))))
    (generate-masto-status (json-string->scm (utf8->string body)))))

(define (masto-unfavorite-status mastoApp statusID)
  (receive (header body)
      (http-post
        (string-append (masto-app-domain mastoApp) "/api/v1/statuses/"
                       statusID                    "/unfavourite")
        #:headers `((Authorization . ,(string-append
                                        "Bearer "
                                        (masto-app-token mastoApp)))))
    (generate-masto-status (json-string->scm (utf8->string body)))))
