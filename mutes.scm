(define-module (elefan mutes)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (elefan utils)
  #:export (masto-mutes-all      masto-mute-account
            masto-unmute-account masto-mute-status  masto-unmute-status))

(define* (masto-mutes-all mastoApp #:optional [limit 40])
  (generate-masto-page
    mastoApp
    'get
    (string-append (masto-app-domain mastoApp) "/api/v1/mutes"
                   "?limit="                   (number->string limit))
    generate-masto-account-array))

(define* (masto-mute-account mastoApp accountID #:optional [notifications #t])
  (generate-masto-relationship
    (http 'post
      (string-append (masto-app-domain mastoApp) "/api/v1/accounts/"
                     accountID                   "/mute")
      #:token       (masto-app-token mastoApp)
      #:queryParams `(("notifications" ,(boolean->string notifications))))))

(define* (masto-unmute-account mastoApp accountID #:optional [notifications #t])
  (generate-masto-relationship
    (http 'post
      (string-append (masto-app-domain mastoApp) "/api/v1/accounts/"
                     accountID                   "/unmute")
      #:token       (masto-app-token mastoApp)
      #:queryParams `(("notifications" ,(boolean->string notifications))))))

(define (masto-mute-status mastoApp statusID)
  (generate-masto-status
    (http 'post
      (string-append (masto-app-domain mastoApp) "/api/v1/statuses/"
                     statusID                    "/mute")
      #:token (masto-app-token mastoApp))))

(define (masto-unmute-status mastoApp statusID)
  (generate-masto-status
    (http 'post
      (string-append (masto-app-domain mastoApp) "/api/v1/statuses/"
                     statusID                    "/unmute")
      #:token (masto-app-token mastoApp))))
