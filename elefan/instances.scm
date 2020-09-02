(define-module (elefan instances)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (elefan utils)
  #:export (masto-instance-info)
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
                                                 masto-account-bot
               <mastodon-instance-urls>  masto-instance-urls?  masto-instance-urls-streaming-api
               <mastodon-instance-stats> masto-instance-stats? masto-instance-stats-user-count
                                                               masto-instance-stats-status-count
                                                               masto-instance-stats-domain-count
               <mastodon-instance>       masto-instance?       masto-instance-uri
                                                               masto-instance-title
                                                               masto-instance-short-description
                                                               masto-instance-description
                                                               masto-instance-email
                                                               masto-instance-version
                                                               masto-instance-thumbnail
                                                               masto-instance-urls
                                                               masto-instance-stats
                                                               masto-instance-languages
                                                               masto-instance-contact-account))

(define (masto-instance-info domainOrApp)
  "Retrieve information about a particular instance.

`domainOrApp` can be the instance domain as a String or a
<mastodon-instance-application>, whose associated `domain` will be used instead.

Domains can include or lack the preceding \"https://\"; this function will add
one, if needed.

This function will return a <mastodon-instance> record.

Documentation for this API call can be found [here](https://docs.joinmastodon.org/methods/instance/)."
  (generate-masto-instance
    (http 'get (string-append
                 (if (masto-instance-app? domainOrApp)
                     (masto-app-domain domainOrApp)
                   (if (string-contains-ci domainOrApp "https://")
                       domainOrApp
                     (string-append/shared "https://" domainOrApp)))
                 "/api/v1/instance"))))
