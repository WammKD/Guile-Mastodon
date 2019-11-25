(define-module (elefan emojis)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (ice-9 receive)
  #:use-module (json)
  #:use-module (rnrs bytevectors)
  #:use-module (web client)
  #:export (masto-emojis-on-instance))

(define (masto-emojis-on-instance mastoApp)
  (receive (header body)
      (http-get
        (string-append (masto-app-domain mastoApp) "/api/v1/custom_emojis")
        #:headers `((Authorization . ,(string-append
                                        "Bearer "
                                        (masto-app-token mastoApp)))))
    (generate-masto-emoji-array (json-string->scm (utf8->string body)))))
