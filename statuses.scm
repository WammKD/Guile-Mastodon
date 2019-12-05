(define-module (elefan statuses)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (elefan enums)
  #:use-module (elefan utils)
  #:use-module (srfi srfi-19)
  #:export (masto-status-get              masto-status-create
            masto-status-get-context      masto-status-delete
            masto-status-get-card         masto-status-reblog
            masto-status-get-reblogged-by masto-status-unreblog
            masto-status-get-favorited-by masto-status-pin
                                          masto-status-unpin))

(define (masto-status-get domainOrApp statusID)
  (generate-masto-status
    (http 'get (string-append
                 (if (masto-instance-app? domainOrApp)
                     (masto-app-domain domainOrApp)
                   (if (string-contains-ci domainOrApp "https://")
                       domainOrApp
                     (string-append/shared "https://" domainOrApp)))
                 "/api/v1/statuses/"
                 statusID))))

(define (masto-status-get-context domainOrApp statusID)
  (generate-masto-context
    (http 'get (string-append
                 (if (masto-instance-app? domainOrApp)
                     (masto-app-domain domainOrApp)
                   (if (string-contains-ci domainOrApp "https://")
                       domainOrApp
                     (string-append/shared "https://" domainOrApp)))
                 "/api/v1/statuses/"
                 statusID
                 "/context"))))

(define (masto-status-get-card domainOrApp statusID)
  (generate-masto-card
    (http 'get (string-append
                 (if (masto-instance-app? domainOrApp)
                     (masto-app-domain domainOrApp)
                   (if (string-contains-ci domainOrApp "https://")
                       domainOrApp
                     (string-append/shared "https://" domainOrApp)))
                 "/api/v1/statuses/"
                 statusID
                 "/card"))))

(define* (masto-status-get-reblogged-by domainOrApp statusID #:optional [limit 40])
  (generate-masto-page
    #f
    'get
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
    'get
    (string-append
      (if (masto-instance-app? domainOrApp)
          (masto-app-domain domainOrApp)
        (if (string-contains-ci domainOrApp "https://")
            domainOrApp
          (string-append/shared "https://" domainOrApp))) "/api/v1/statuses/"
      statusID                                            "/favourited_by"
      "?limit="                                           (number->string limit))
    generate-masto-account-array))
