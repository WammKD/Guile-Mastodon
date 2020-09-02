(define-module (elefan follow-requests)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (elefan utils)
  #:export (masto-follow-requests-all
            masto-follow-request-authorize
            masto-follow-request-reject)
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
                                                 masto-account-bot))

(define* (masto-follow-requests-all mastoApp #:optional [limit 40])
  "Retrieve all follow requests made to the user tied to `mastoApp`.

If no `limit` value is provided, the value 40 is used.

A <mastodon-pagination-object> is returned, consisting of the
<mastodon-account>s that have requested to follow the user.

Find the original documentation [here](https://docs.joinmastodon.org/methods/accounts/follow_requests/)."
  (generate-masto-page
    mastoApp
    'get
    (string-append (masto-app-domain mastoApp) "/api/v1/follow_requests"
                   "?limit="                   (number->string limit))
    generate-masto-account-array))

(define (masto-follow-request-authorize mastoApp requestID)
  "Approve an existing follow request for the user tied to `mastoApp`.

`requestID` refers to the ID of the follow request you wish to approve.

If successful, this function will return `#t`.

Find the original documentation [here](https://docs.joinmastodon.org/methods/accounts/follow_requests/)."
  (http 'post
    (string-append (masto-app-domain mastoApp) "/api/v1/follow_requests/"
                   requestID                   "/authorize")
    #:token (masto-app-token mastoApp))

  #t)

(define (masto-follow-request-reject mastoApp requestID)
  "Deny an existing follow request for the user tied to `mastoApp`.

`requestID` refers to the ID of the follow request you wish to deny.

If successful, this function will return `#t`.

Find the original documentation [here](https://docs.joinmastodon.org/methods/accounts/follow_requests/)."
  (http 'post
    (string-append (masto-app-domain mastoApp) "/api/v1/follow_requests/"
                   requestID                   "/reject")
    #:token (masto-app-token mastoApp))

  #t)
