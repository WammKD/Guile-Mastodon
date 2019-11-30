(define-module (elefan emojis)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (ice-9 receive)
  #:use-module (json)
  #:use-module (rnrs bytevectors)
  #:use-module (web client)
  #:export (masto-emojis-on-instance))

(define* (masto-emojis-on-instance #:key app domain)
  (receive (header body)
      (http-get (string-append (if domain
                                   (if (string-contains-ci domain "https://")
                                       domain
                                     (string-append/shared "https://" domain))
                                 (masto-app-domain app)) "/api/v1/custom_emojis"))
    (generate-masto-emoji-array (json-string->scm (utf8->string body)))))
