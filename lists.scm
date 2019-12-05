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
            masto-list-delete-account)
  #:re-export (<mastodon-pagination-object> masto-page? masto-page-objects
                                                        masto-page-prev
                                                        masto-page-next
               <mastodon-emoji>   masto-emoji?   masto-emoji-shortcode
                                                 masto-emoji-static-url
                                                 masto-emoji-url
                                                 masto-emoji-visible-in-picker
               <mastodon-field>   masto-field?   masto-field-name
                                                 masto-field-value
                                                 masto-field-verified-at
               <mastodon-account> masto-account? masto-account-id
                                                 masto-account-username
                                                 masto-account-acct
                                                 masto-account-display-name
                                                 masto-account-locked
                                                 masto-account-created-at
                                                 masto-account-followers-count
                                                 masto-account-following-count
                                                 masto-account-statuses-count
                                                 masto-account-note
                                                 masto-account-url
                                                 masto-account-avatar
                                                 masto-account-avatar-static
                                                 masto-account-header
                                                 masto-account-header-static
                                                 masto-account-emojis
                                                 masto-account-moved
                                                 masto-account-fields
                                                 masto-account-bot
               <mastodon-list> masto-list? masto-list-id masto-list-title))

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
