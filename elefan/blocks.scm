(define-module (elefan blocks)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (elefan utils)
  #:export (masto-blocks-all
            masto-block-account
            masto-unblock-account)
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
               <mastodon-relationship> masto-relationship? masto-relationship-id
                                                           masto-relationship-following
                                                           masto-relationship-followed-by
                                                           masto-relationship-blocking
                                                           masto-relationship-muting
                                                           masto-relationship-muting-notifications
                                                           masto-relationship-requested
                                                           masto-relationship-domain-blocking
                                                           masto-relationship-showing-reblogs
                                                           masto-relationship-endorsed))

(define* (masto-blocks-all mastoApp #:optional [limit 40])
  "Retrieve all blocks associated with the user tied to `mastoApp`.

If no `limit` value is provided, 40 is used.

A [<mastodon-pagination-object>](#mastodon-pagination-object) is returned,
consisting of the [<mastodon-account>](#mastodon-account)s that the user has
blocked."
  (generate-masto-page
    mastoApp
    'get
    (string-append (masto-app-domain mastoApp) "/api/v1/blocks"
                   "?limit="                   (number->string limit))
    generate-masto-account-array))

(define (masto-block-account mastoApp accountID)
  (generate-masto-relationship
    (http 'post
      (string-append (masto-app-domain mastoApp) "/api/v1/accounts/"
                     accountID                   "/block")
      #:token (masto-app-token mastoApp))))

(define (masto-unblock-account mastoApp accountID)
  (generate-masto-relationship
    (http 'post
      (string-append (masto-app-domain mastoApp) "/api/v1/accounts/"
                     accountID                   "/unblock")
      #:token (masto-app-token mastoApp))))
