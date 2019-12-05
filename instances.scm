(define-module (elefan instances)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (elefan utils)
  #:export (masto-instance-info))

(define (masto-instance-info domainOrApp)
  (generate-masto-instance
    (http 'get (string-append
                 (if (masto-instance-app? domainOrApp)
                     (masto-app-domain domainOrApp)
                   (if (string-contains-ci domainOrApp "https://")
                       domainOrApp
                     (string-append/shared "https://" domainOrApp)))
                 "/api/v1/instance"))))
