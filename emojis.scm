(define-module (elefan emojis)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (ice-9 receive)
  #:use-module (json)
  #:use-module (rnrs bytevectors)
  #:use-module (web client)
  #:export (masto-emojis-on-instance))

(define (masto-emojis-on-instance domainOrApp)
  (receive (header body)
      (http-get (string-append
                  (if (masto-instance-app? domainOrApp)
                      (masto-app-domain domainOrApp)
                    (if (string-contains-ci domainOrApp "https://")
                        domainOrApp
                      (string-append/shared "https://" domainOrApp)))
                  "/api/v1/custom_emojis"))
    (generate-masto-emoji-array (json-string->scm (utf8->string body)))))
