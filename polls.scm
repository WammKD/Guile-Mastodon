(define-module (elefan polls)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (elefan utils)
  #:use-module (ice-9 receive)
  #:use-module (json)
  #:use-module (rnrs bytevectors)
  #:use-module (web client)
  #:export (masto-poll-get
            masto-poll-send-vote))

(define (masto-poll-get mastoApp pollID)
  (receive (header body)
      (http-get
        (string-append (masto-app-domain mastoApp) "/api/v1/polls/" pollID)
        #:headers `((Authorization . ,(string-append
                                        "Bearer "
                                        (masto-app-token mastoApp)))))
    (if-let ([bodySCM (cut assoc-ref <> "error") (json-string->scm
                                                   (utf8->string body))])
        (error (assoc-ref bodySCM "error"))
      (generate-masto-poll bodySCM))))

(define (masto-poll-send-vote mastoApp choices)
  (receive (header body)
      (http-post
        (string-append (masto-app-domain mastoApp) "/api/v1/polls/"
                       pollID                      "/votes"
                       (assemble-params `(("choices" ,choices))))
        #:headers `((Authorization . ,(string-append
                                        "Bearer "
                                        (masto-app-token mastoApp)))))
    (if-let ([bodySCM (cut assoc-ref <> "error") (json-string->scm
                                                   (utf8->string body))])
        (error (assoc-ref bodySCM "error"))
      (generate-masto-poll bodySCM))))
