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
  "Retrieve all lists for the user tied to `mastoApp`.

This function returns a (Scheme) list of <mastodon-list>s that the user has
created.

Find the original documentation [here](https://docs.joinmastodon.org/methods/timelines/lists/)."
  (generate-masto-list-array
    (http 'get
      (string-append (masto-app-domain mastoApp) "/api/v1/lists")
      #:token (masto-app-token mastoApp))))

(define (masto-lists-by-account mastoApp accountID)
  "Retrieve all lists created by the user tied to `mastoApp` that contain
Fediverse users that have the account ID `accountID`.

This function returns a (Scheme) list of <mastodon-list>s.

Find the original documentation within [this page](https://docs.joinmastodon.org/methods/accounts/)."
  (generate-masto-list-array
    (http 'get
      (string-append (masto-app-domain mastoApp) "/api/v1/accounts/"
                     accountID                   "/lists")
      #:token (masto-app-token mastoApp))))

(define* (masto-accounts-by-list mastoApp listID #:optional [limit 40])
  "Retrieve all user accounts that are in a list created by the user tied to
`mastoApp`.

If no `limit` value is provided, the value 40 is used.

`listID` refers to the list, created by the user, that you want to get accounts
from.

A <mastodon-pagination-object> is returned, consisting of the
<mastodon-account>s that are in the specified list.

Find the original documentation [here](https://docs.joinmastodon.org/methods/timelines/lists/)."
  (generate-masto-page
    mastoApp
    'get
    (string-append (masto-app-domain mastoApp) "/api/v1/lists/"
                   listID                      "/accounts"
                   "?limit="                   (number->string limit))
    generate-masto-account-array))

(define (masto-list-get mastoApp listID)
  "Retrieve the list, created by the user tied to `mastoApp`, that has the list
 ID `listID`.

This function returns a <mastodon-list>, corresponding to the `listID`.

Find the original documentation [here](https://docs.joinmastodon.org/methods/timelines/lists/)."
  (generate-masto-list
    (http 'get
      (string-append (masto-app-domain mastoApp) "/api/v1/lists/" listID)
      #:token (masto-app-token mastoApp))))

(define (masto-list-create mastoApp title)
  "Create a list for the user tied to `mastoApp` with the title `title`.

This function returns the <mastodon-list> you just created.

Find the original documentation [here](https://docs.joinmastodon.org/methods/timelines/lists/)."
  (generate-masto-list
    (http 'post
      (string-append (masto-app-domain mastoApp) "/api/v1/lists")
      #:token       (masto-app-token mastoApp)
      #:queryParams `(("title" ,title)))))

(define (masto-list-update mastoApp listID title)
  "Update the title, of a list for the user tied to `mastoApp` and which has the
ID `listID`, to `title`.

This function returns the <mastodon-list> you just updated, with the updates.

Find the original documentation [here](https://docs.joinmastodon.org/methods/timelines/lists/)."
  (generate-masto-list
    (http 'put
      (string-append (masto-app-domain mastoApp) "/api/v1/lists/" listID)
      #:token       (masto-app-token mastoApp)
      #:queryParams `(("title" ,title)))))

(define (masto-list-delete mastoApp listID)
  "Delete the list for the user tied to `mastoApp` which has the ID `listID`.

This function, if successful, returns `#t`.

Find the original documentation [here](https://docs.joinmastodon.org/methods/timelines/lists/)."
  (http 'delete
    (string-append (masto-app-domain mastoApp) "/api/v1/lists/" listID)
    #:token (masto-app-token mastoApp))

  #t)

(define (masto-list-add-account mastoApp listID accountIDs)
  "Add an account(s) to the list which has the ID `listID` for the user tied to
`mastoApp`.

`accountIDs` should be a list of Fediverse account IDs.

This function, if successful, returns `#t`.

Find the original documentation [here](https://docs.joinmastodon.org/methods/timelines/lists/)."
  (http 'post
    (string-append (masto-app-domain mastoApp) "/api/v1/lists/"
                   listID                      "/accounts")
    #:token       (masto-app-token mastoApp)
    #:queryParams `(("account_ids" ,accountIDs)))

  #t)

(define (masto-list-delete-account mastoApp listID accountIDs)
  "Delete an account(s) from the list which has the ID `listID` for the user
tied to `mastoApp`.

`accountIDs` should be a list of Fediverse account IDs.

This function, if successful, returns `#t`.

Find the original documentation [here](https://docs.joinmastodon.org/methods/timelines/lists/)."
  (http 'delete
    (string-append (masto-app-domain mastoApp) "/api/v1/lists/"
                   listID                      "/accounts")
    #:token       (masto-app-token mastoApp)
    #:queryParams `(("account_ids" ,accountIDs)))

  #t)
