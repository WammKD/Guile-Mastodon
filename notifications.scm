(define-module (elefan notifications)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (elefan enums)
  #:use-module (elefan utils)
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-26)
  #:use-module (web uri)
  #:export (masto-notifications-all            masto-notification-get
            masto-notifications-all-clear      masto-notification-delete
            masto-web-push-get-subscription    masto-web-push-update-subscription
            masto-web-push-delete-subscription))

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

(define (masto-notification-delete mastoApp notificationID)
  (http 'post
    (string-append (masto-app-domain mastoApp) "/api/v1/notifications/dismiss")
    #:token       (masto-app-token mastoApp)
    #:queryParams `(("id" ,notificationID)))

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
