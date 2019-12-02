(define-module (elefan instances)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (ice-9 receive)
  #:use-module (json)
  #:use-module (rnrs bytevectors)
  #:use-module (web client)
  #:export (masto-instance-info))

(define (masto-instance-info domainOrApp)
  (receive (header body)
      (http-get (string-append
                  (if (masto-instance-app? domainOrApp)
                      (masto-app-domain domainOrApp)
                    (if (string-contains-ci domainOrApp "https://")
                        domainOrApp
                      (string-append/shared "https://" domainOrApp)))
                  "/api/v1/instance"))
    (generate-masto-instance (json-string->scm (utf8->string body)))))
