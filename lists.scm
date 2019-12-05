(define-module (elefan lists)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (elefan utils)
  #:export (masto-lists-all
            masto-lists-by-account
            masto-accounts-by-list
            masto-list-get
            masto-list-create
            masto-list-update
            masto-list-delete
            masto-list-add-account
            masto-list-delete-account))

(define (masto-lists-all mastoApp)
  (generate-masto-list-array
    (http 'get
      (string-append (masto-app-domain mastoApp) "/api/v1/lists")
      #:token (masto-app-token mastoApp))))

(define (masto-lists-by-account mastoApp accountID)
  (generate-masto-list-array
    (http 'get
      (string-append (masto-app-domain mastoApp) "/api/v1/accounts/"
                     accountID                   "/lists")
      #:token (masto-app-token mastoApp))))

(define* (masto-accounts-by-list mastoApp listID #:optional [limit 40])
  (generate-masto-page
    mastoApp
    'get
    (string-append (masto-app-domain mastoApp) "/api/v1/lists/"
                   listID                      "/accounts"
                   "?limit="                   (number->string limit))
    generate-masto-account-array))

(define (masto-list-get mastoApp listID)
  (generate-masto-list
    (http 'get
      (string-append (masto-app-domain mastoApp) "/api/v1/lists/" listID)
      #:token (masto-app-token mastoApp))))

(define (masto-list-create mastoApp title)
  (generate-masto-list
    (http 'post
      (string-append (masto-app-domain mastoApp) "/api/v1/lists")
      #:token       (masto-app-token mastoApp)
      #:queryParams `(("title" ,title)))))

(define (masto-list-update mastoApp listID title)
  (generate-masto-list
    (http 'put
      (string-append (masto-app-domain mastoApp) "/api/v1/lists/" listID)
      #:token       (masto-app-token mastoApp)
      #:queryParams `(("title" ,title)))))

(define (masto-list-delete mastoApp listID)
  (http 'delete
    (string-append (masto-app-domain mastoApp) "/api/v1/lists/" listID)
    #:token (masto-app-token mastoApp))

  #t)

(define (masto-list-add-account mastoApp listID accountIDs)
  (http 'post
    (string-append (masto-app-domain mastoApp) "/api/v1/lists/"
                   listID                      "/accounts")
    #:token       (masto-app-token mastoApp)
    #:queryParams `(("account_ids" ,accountIDs)))

  #t)

(define (masto-list-delete-account mastoApp listID accountIDs)
  (http 'delete
    (string-append (masto-app-domain mastoApp) "/api/v1/lists/"
                   listID                      "/accounts")
    #:token       (masto-app-token mastoApp)
    #:queryParams `(("account_ids" ,accountIDs)))

  #t)
