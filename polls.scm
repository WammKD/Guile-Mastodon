(define-module (elefan polls)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (elefan utils)
  #:export (masto-poll-get
            masto-poll-send-vote))

(define (masto-poll-get mastoApp pollID)
  (generate-masto-poll
    (http 'get
      (string-append (masto-app-domain mastoApp) "/api/v1/polls/" pollID)
      #:token (masto-app-token mastoApp))))

(define (masto-poll-send-vote mastoApp choices)
  (generate-masto-poll
    (http 'post
      (string-append (masto-app-domain mastoApp) "/api/v1/polls/"
                     pollID                      "/votes")
      #:token       (masto-app-token mastoApp)
      #:queryParams `(("choices" ,choices)))))
