(define-module (elefan follow-suggestions)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (elefan utils)
  #:export (masto-follow-suggestions-all
            masto-follow-suggestion-delete))

(define (masto-follow-suggestions-all mastoApp)
  (generate-masto-account-array
    (http 'get
      (string-append (masto-app-domain mastoApp) "/api/v1/suggestions")
      #:token (masto-app-token mastoApp))))

(define (masto-follow-suggestion-delete mastoApp accountID)
  (http 'delete
    (string-append (masto-app-domain mastoApp) "/api/v1/suggestions/" accountID)
    #:token (masto-app-token mastoApp))

  #t)
