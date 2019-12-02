(define-module (elefan statuses)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (elefan utils)
  #:use-module (ice-9 receive)
  #:use-module (json)
  #:use-module (rnrs bytevectors)
  #:use-module (web client)
  #:export (masto-status-get))

(define (masto-status-get domainOrApp statusID)
  (receive (header body)
      (http-get (string-append
                  (if (masto-instance-app? domainOrApp)
                      (masto-app-domain domainOrApp)
                    (if (string-contains-ci domainOrApp "https://")
                        domainOrApp
                      (string-append/shared "https://" domainOrApp)))
                  "/api/v1/statuses/"
                  statusID))
    (if-let ([bodySCM (cut assoc-ref <> "error") (json-string->scm
                                                   (utf8->string body))])
        (error (assoc-ref bodySCM "error"))
      (generate-masto-status bodySCM))))

(define (masto-status-get-context domainOrApp statusID)
  (receive (header body)
      (http-get (string-append
                  (if (masto-instance-app? domainOrApp)
                      (masto-app-domain domainOrApp)
                    (if (string-contains-ci domainOrApp "https://")
                        domainOrApp
                      (string-append/shared "https://" domainOrApp)))
                  "/api/v1/statuses/"
                  statusID
                  "/context"))
    (if-let ([bodySCM (cut assoc-ref <> "error") (json-string->scm
                                                   (utf8->string body))])
        (error (assoc-ref bodySCM "error"))
      (generate-masto-context bodySCM))))

(define (masto-status-get-card domainOrApp statusID)
  (receive (header body)
      (http-get (string-append
                  (if (masto-instance-app? domainOrApp)
                      (masto-app-domain domainOrApp)
                    (if (string-contains-ci domainOrApp "https://")
                        domainOrApp
                      (string-append/shared "https://" domainOrApp)))
                  "/api/v1/statuses/"
                  statusID
                  "/card"))
    (if-let ([bodySCM (cut assoc-ref <> "error") (json-string->scm
                                                   (utf8->string body))])
        (error (assoc-ref bodySCM "error"))
      (generate-masto-card bodySCM))))

(define* (masto-status-get-reblogged-by domainOrApp statusID #:optional [limit 40])
  (generate-masto-page
    #f
    http-get
    (string-append
      (if (masto-instance-app? domainOrApp)
          (masto-app-domain domainOrApp)
        (if (string-contains-ci domainOrApp "https://")
            domainOrApp
          (string-append/shared "https://" domainOrApp))) "/api/v1/statuses/"
      statusID                                            "/reblogged_by"
      "?limit="                                           (number->string limit))
    generate-masto-account-array))

(define* (masto-status-get-favorited-by domainOrApp statusID #:optional [limit 40])
  (generate-masto-page
    #f
    http-get
    (string-append
      (if (masto-instance-app? domainOrApp)
          (masto-app-domain domainOrApp)
        (if (string-contains-ci domainOrApp "https://")
            domainOrApp
          (string-append/shared "https://" domainOrApp))) "/api/v1/statuses/"
      statusID                                            "/favourited_by"
      "?limit="                                           (number->string limit))
    generate-masto-account-array))
