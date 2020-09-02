(define-module (elefan follow-suggestions)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (elefan utils)
  #:export (masto-follow-suggestions-all
            masto-follow-suggestion-delete)
  #:re-export (<mastodon-emoji>   masto-emoji?   masto-emoji-shortcode
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

(define (masto-follow-suggestions-all mastoApp)
  "Retrieve all follow suggestions for the user tied to `mastoApp`.

This function returns a list of <mastodon-account>s that the user has had past,
positive interactions with but is, not yet, following.

Find the original documentation [here](https://docs.joinmastodon.org/methods/accounts/suggestions/)."
  (generate-masto-account-array
    (http 'get
      (string-append (masto-app-domain mastoApp) "/api/v1/suggestions")
      #:token (masto-app-token mastoApp))))

(define (masto-follow-suggestion-delete mastoApp accountID)
  "Remove a follow suggestion for the user tied to `mastoApp`.

`accountID` refers to the ID of the account you wish to no longer suggest.

If successful, this function will return `#t`.

Find the original documentation [here](https://docs.joinmastodon.org/methods/accounts/suggestions/)."
  (http 'delete
    (string-append (masto-app-domain mastoApp) "/api/v1/suggestions/" accountID)
    #:token (masto-app-token mastoApp))

  #t)
