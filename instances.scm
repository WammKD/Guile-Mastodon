(define-module (elefan instances)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (ice-9 receive)
  #:use-module (json)
  #:use-module (rnrs bytevectors)
  #:use-module (web client)
  #:export (masto-instance-info))

(define* (masto-instance-info #:key app domain)
  (receive (header body)
      (http-get (string-append (if domain
                                   (if (string-contains-ci domain "https://")
                                       domain
                                     (string-append/shared "https://" domain))
                                 (masto-app-domain app)) "/api/v1/instance"))
    (generate-masto-instance (json-string->scm (utf8->string body)))))
