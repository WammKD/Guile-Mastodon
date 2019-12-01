(define-module (elefan mutes)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (elefan utils)
  #:use-module (ice-9 receive)
  #:use-module (json)
  #:use-module (rnrs bytevectors)
  #:use-module (srfi srfi-26)
  #:use-module (web client)
  #:export (masto-mutes-all
            masto-mute-account
            masto-unmute-account
            masto-mute-status
            masto-unmute-status))

(define* (masto-mutes-all mastoApp #:optional [limit 40])
  (generate-masto-page
    mastoApp
    http-get
    (string-append (masto-app-domain mastoApp) "/api/v1/mutes"
                   "?limit="                   (number->string limit))
    generate-masto-account-array))

(define* (masto-mute-account mastoApp accountID #:optional [notifications #t])
  (receive (header body)
      (http-post
        (string-append (masto-app-domain mastoApp) "/api/v1/accounts/"
                       accountID                   "/mute"
                       "?notifications="           (if notifications "true" "false"))
        #:headers `((Authorization . ,(string-append
                                        "Bearer "
                                        (masto-app-token mastoApp)))))
    (if-let ([bodySCM (cut assoc-ref <> "error") (json-string->scm
                                                   (utf8->string body))])
        (error (assoc-ref bodySCM "error"))
      (generate-masto-relationship bodySCM))))

(define* (masto-unmute-account mastoApp accountID #:optional [notifications #t])
  (receive (header body)
      (http-post
        (string-append (masto-app-domain mastoApp) "/api/v1/accounts/"
                       accountID                   "/unmute"
                       "?notifications="           (if notifications "true" "false"))
        #:headers `((Authorization . ,(string-append
                                        "Bearer "
                                        (masto-app-token mastoApp)))))
    (if-let ([bodySCM (cut assoc-ref <> "error") (json-string->scm
                                                   (utf8->string body))])
        (error (assoc-ref bodySCM "error"))
      (generate-masto-relationship bodySCM))))

(define (masto-mute-status mastoApp statusID)
  (receive (header body)
      (http-post
        (string-append (masto-app-domain mastoApp) "/api/v1/statuses/"
                       statusID                    "/mute")
        #:headers `((Authorization . ,(string-append
                                        "Bearer "
                                        (masto-app-token mastoApp)))))
    (if-let ([bodySCM (cut assoc-ref <> "error") (json-string->scm
                                                   (utf8->string body))])
        (error (assoc-ref bodySCM "error"))
      (generate-masto-status bodySCM))))

(define (masto-unmute-status mastoApp statusID)
  (receive (header body)
      (http-post
        (string-append (masto-app-domain mastoApp) "/api/v1/statuses/"
                       statusID                    "/unmute")
        #:headers `((Authorization . ,(string-append
                                        "Bearer "
                                        (masto-app-token mastoApp)))))
    (if-let ([bodySCM (cut assoc-ref <> "error") (json-string->scm
                                                   (utf8->string body))])
        (error (assoc-ref bodySCM "error"))
      (generate-masto-status bodySCM))))
