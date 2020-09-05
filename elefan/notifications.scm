(define-module (elefan notifications)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (elefan enums)
  #:use-module (elefan utils)
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-26)
  #:use-module (web uri)
  #:export (masto-notifications-all            masto-notification-get
            masto-notifications-all-clear      masto-notification-dismiss
            masto-web-push-create-subscription masto-web-push-get-subscription
            masto-web-push-update-subscription masto-web-push-delete-subscription)
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
               <mastodon-meta-subtree> masto-meta-subtree? masto-meta-subtree-width
                                                           masto-meta-subtree-height
                                                           masto-meta-subtree-size
                                                           masto-meta-subtree-aspect
                                                           masto-meta-subtree-frame-rate
                                                           masto-meta-subtree-duration
                                                           masto-meta-subtree-bitrate
               <mastodon-meta-focus>   masto-meta-focus?   masto-meta-focus-x
                                                           masto-meta-focus-y
               <mastodon-meta>         masto-meta?         masto-meta-small
                                                           masto-meta-original
                                                           masto-meta-focus
               <mastodon-attachment>   masto-attachment?   masto-attachment-id
                                                           masto-attachment-type
                                                           masto-attachment-url
                                                           masto-attachment-remote-url
                                                           masto-attachment-preview-url
                                                           masto-attachment-text-url
                                                           masto-attachment-meta
                                                           masto-attachment-description
                                                           masto-attachment-blurhash
               <mastodon-mention> masto-mention? masto-mention-url
                                                 masto-mention-username
                                                 masto-mention-acct
                                                 masto-mention-id
               <mastodon-history> masto-history? masto-history-day
                                                 masto-history-uses
                                                 masto-history-accounts
               <mastodon-tag>     masto-tag?     masto-tag-name
                                                 masto-tag-url
                                                 masto-tag-history
               <mastodon-card>    masto-card?    masto-card-url
                                                 masto-card-title
                                                 masto-card-description
                                                 masto-card-image
                                                 masto-card-type
                                                 masto-card-author-name
                                                 masto-card-author-url
                                                 masto-card-provider-name
                                                 masto-card-provider-url
                                                 masto-card-html
                                                 masto-card-width
                                                 masto-card-height
               <mastodon-poll> masto-poll? masto-poll-id
                                           masto-poll-expires-at
                                           masto-poll-expired
                                           masto-poll-multiple
                                           masto-poll-votes-count
                                           masto-poll-options
                                           masto-poll-voted
               <mastodon-application> masto-application? masto-application-name
                                                         masto-application-website
               <mastodon-status> masto-status? masto-status-id
                                               masto-status-uri
                                               masto-status-url
                                               masto-status-account
                                               masto-status-in-reply-to-id
                                               masto-status-in-reply-to-account-id
                                               masto-status-reblog-status
                                               masto-status-content
                                               masto-status-created-at
                                               masto-status-emojis
                                               masto-status-replies-count
                                               masto-status-reblogs-count
                                               masto-status-favorites-count
                                               masto-status-reblogged
                                               masto-status-favorited
                                               masto-status-muted
                                               masto-status-sensitive
                                               masto-status-spoiler-text
                                               masto-status-visibility
                                               masto-status-media-attachments
                                               masto-status-mentions
                                               masto-status-tags
                                               masto-status-card
                                               masto-status-poll
                                               masto-status-application
                                               masto-status-language
                                               masto-status-pinned
               <mastodon-notification> masto-notification? masto-notification-id
                                                           masto-notification-type
                                                           masto-notification-create-at
                                                           masto-notification-account
                                                           masto-notification-status
               <mastodon-web-push-subscription-alerts> masto-web-push-subscription-alerts? masto-web-push-subscription-alerts-poll
                                                                                           masto-web-push-subscription-alerts-mention
                                                                                           masto-web-push-subscription-alerts-reblog
                                                                                           masto-web-push-subscription-alerts-favorite
                                                                                           masto-web-push-subscription-alerts-follow
               <mastodon-web-push-subscription> masto-web-push-subscription? masto-web-push-subscription-id
                                                                             masto-web-push-subscription-endpoint
                                                                             masto-web-push-subscription-server-key
                                                                             masto-web-push-subscription-alerts))

(define* (masto-notifications-all mastoApp #:key maxID              sinceID
                                                 minID              [limit 20]
                                                 [excludeTypes '()] accountID)
  (if (every (cut enum-member? <> NOTIFICATION_TYPE_ENUM) excludeTypes)
      (generate-masto-page
        mastoApp
        'get
        (string-append (masto-app-domain mastoApp) "/api/v1/notifications"
                       (assemble-params
                         `(("max_id"        ,maxID)
                           ("since_id"      ,sinceID)
                           ("min_id"        ,minID)
                           ("limit"         ,(number->string limit))
                           ("exclude_types" ,(map
                                               enum-member-or-value->string
                                               excludeTypes))
                           ("account_id"    ,accountID))))
        generate-masto-notification-array)
    (error (string-append
             "ERROR: In procedure masto-notifications-all:\n"
             "In procedure masto-notifications-all: "
             "One of the exclude_type arguments is not a valid "
             "notification type; valid types are follow, mention, "
             "reblog, or favourite"))))

(define (masto-notification-get mastoApp notificationID)
  (generate-masto-notification
    (http 'get
      (string-append (masto-app-domain mastoApp) "/api/v1/notifications/"
                     notificationID)
      #:token (masto-app-token mastoApp))))

(define (masto-notifications-all-clear mastoApp)
  (http 'post
    (string-append (masto-app-domain mastoApp) "/api/v1/notifications/clear")
    #:token (masto-app-token mastoApp))

  #t)

(define (masto-notification-dismiss mastoApp notificationID)
  (http 'post
    (string-append (masto-app-domain mastoApp) "/api/v1/notifications/"
                   notificationID              "/dismiss")
    #:token (masto-app-token mastoApp))

  #t)

(define* (masto-web-push-create-subscription mastoApp               subscriptionEndpoint
                                             subscriptionKeysP256dh subscriptionKeysAuth
                                             #:key                  dataAlertsFollow
                                                                    dataAlertsFavorite
                                                                    dataAlertsReblog
                                                                    dataAlertsMention
                                                                    dataAlertsPoll)
  (generate-masto-web-push-subscription
    (http 'post
      (string-append (masto-app-domain mastoApp) "/api/v1/push/subscription")
      #:token       (masto-app-token mastoApp)
      #:queryParams `(("subscription[endpoint]"     ,(if (uri? subscriptionEndpoint)
                                                         (uri->string
                                                           subscriptionEndpoint)
                                                       subscriptionEndpoint))
                      ("subscription[keys][p256dh]" ,subscriptionKeysP256dh)
                      ("subscription[keys][auth]"   ,subscriptionKeysAuth)
                      ("data[alerts][follow]"       ,(boolean->string dataAlertsFollow))
                      ("data[alerts][favourite]"    ,(boolean->string dataAlertsFavorite))
                      ("data[alerts][reblog]"       ,(boolean->string dataAlertsReblog))
                      ("data[alerts][mention]"      ,(boolean->string dataAlertsMention))
                      ("data[alerts][poll]"         ,(boolean->string dataAlertsPoll))))))

(define (masto-web-push-get-subscription mastoApp)
  (generate-masto-web-push-subscription
    (http 'get
      (string-append (masto-app-domain mastoApp) "/api/v1/push/subscription")
      #:token (masto-app-token mastoApp))))

(define* (masto-web-push-update-subscription mastoApp #:key dataAlertsFollow
                                                            dataAlertsFavorite
                                                            dataAlertsReblog
                                                            dataAlertsMention
                                                            dataAlertsPoll)
  (generate-masto-web-push-subscription
    (http 'put
      (string-append (masto-app-domain mastoApp) "/api/v1/push/subscription")
      #:token       (masto-app-token mastoApp)
      #:queryParams `(("data[alerts][follow]"    ,(boolean->string dataAlertsFollow))
                      ("data[alerts][favourite]" ,(boolean->string dataAlertsFavorite))
                      ("data[alerts][reblog]"    ,(boolean->string dataAlertsReblog))
                      ("data[alerts][mention]"   ,(boolean->string dataAlertsMention))
                      ("data[alerts][poll]"      ,(boolean->string dataAlertsPoll))))))

(define (masto-web-push-delete-subscription mastoApp)
  (http 'delete
    (string-append (masto-app-domain mastoApp) "/api/v1/push/subscription")
    #:token (masto-app-token mastoApp))

  #t)
