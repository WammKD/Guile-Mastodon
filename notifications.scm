(define-module (elefan notifications)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (elefan enums)
  #:use-module (elefan utils)
  #:use-module (ice-9 receive)
  #:use-module (json)
  #:use-module (rnrs bytevectors)
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-26)
  #:use-module (web client)
  #:use-module (web uri)
  #:export (masto-notifications-all
            masto-notification-get
            masto-notifications-all-clear
            masto-notification-delete
            masto-web-push-get-subscription
            masto-web-push-update-subscription
            masto-web-push-delete-subscription))

(define* (masto-notifications-all mastoApp #:key maxID      sinceID      minID
                                                 [limit 20] excludeTypes accountID)
  (if (every (cut enum-member? <> NOTIFICATION_TYPE_ENUM) excludeTypes)
      (generate-masto-page
        mastoApp
        http-get
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
  (receive (header body)
      (http-get
        (string-append (masto-app-domain mastoApp) "/api/v1/notifications/"
                       notificationID)
        #:headers `((Authorization . ,(string-append
                                        "Bearer "
                                        (masto-app-token mastoApp)))))
    (if-let ([bodySCM (cut assoc-ref <> "error") (json-string->scm
                                                   (utf8->string body))])
        (error (assoc-ref bodySCM "error"))
      (generate-masto-notification bodySCM))))

(define (masto-notifications-all-clear mastoApp)
  (receive (header body)
      (http-post
        (string-append (masto-app-domain mastoApp) "/api/v1/notifications/clear")
        #:headers `((Authorization . ,(string-append
                                        "Bearer "
                                        (masto-app-token mastoApp)))))
    (if-let ([errMsg (assoc-ref (json-string->scm (utf8->string body)) "error")])
        (error errMsg)
      #t)))

(define (masto-notification-delete mastoApp notificationID)
  (receive (header body)
      (http-post
        (string-append (masto-app-domain mastoApp) "/api/v1/notifications/dismiss"
                       "?id="                      notificationID)
        #:headers `((Authorization . ,(string-append
                                        "Bearer "
                                        (masto-app-token mastoApp)))))
    (if-let ([errMsg (assoc-ref (json-string->scm (utf8->string body)) "error")])
        (error errMsg)
      #t)))

(define* (masto-web-push-create-subscription mastoApp               subscriptionEndpoint
                                             subscriptionKeysP256dh subscriptionKeysAuth
                                             #:key                  dataAlertsFollow
                                                                    dataAlertsFavorite
                                                                    dataAlertsReblog
                                                                    dataAlertsMention
                                                                    dataAlertsPoll)
  (receive (header body)
      (http-post
        (string-append (masto-app-domain mastoApp) "/api/v1/push/subscription"
                       (assemble-params
                         `(("subscription[endpoint]"     ,(if (uri? subscriptionEndpoint)
                                                              (uri->string
                                                                subscriptionEndpoint)
                                                            subscriptionEndpoint))
                           ("subscription[keys][p256dh]" ,subscriptionKeysP256dh)
                           ("subscription[keys][auth]"   ,subscriptionKeysAuth)
                           ("data[alerts][follow]"       ,(if dataAlertsFollow
                                                              "true"
                                                            "false"))
                           ("data[alerts][favourite]"    ,(if dataAlertsFavorite
                                                              "true"
                                                            "false"))
                           ("data[alerts][reblog]"       ,(if dataAlertsReblog
                                                              "true"
                                                            "false"))
                           ("data[alerts][mention]"      ,(if dataAlertsMention
                                                              "true"
                                                            "false"))
                           ("data[alerts][poll]"         ,(if dataAlertsPoll
                                                              "true"
                                                            "false")))))
        #:headers `((Authorization . ,(string-append
                                        "Bearer "
                                        (masto-app-token mastoApp)))))
    (if-let ([bodySCM (cut assoc-ref <> "error") (json-string->scm
                                                   (utf8->string body))])
        (error (assoc-ref bodySCM "error"))
      (generate-masto-web-push-subscription bodySCM))))

(define (masto-web-push-get-subscription mastoApp)
  (receive (header body)
      (http-get
        (string-append (masto-app-domain mastoApp) "/api/v1/push/subscription")
        #:headers `((Authorization . ,(string-append
                                        "Bearer "
                                        (masto-app-token mastoApp)))))
    (if-let ([bodySCM (cut assoc-ref <> "error") (json-string->scm
                                                   (utf8->string body))])
        (error (assoc-ref bodySCM "error"))
      (generate-masto-web-push-subscription bodySCM))))

(define* (masto-web-push-update-subscription mastoApp #:key dataAlertsFollow
                                                            dataAlertsFavorite
                                                            dataAlertsReblog
                                                            dataAlertsMention
                                                            dataAlertsPoll)
  (receive (header body)
      (http-put
        (string-append (masto-app-domain mastoApp) "/api/v1/push/subscription"
                       (assemble-params
                         `(("data[alerts][follow]"    ,(if dataAlertsFollow
                                                           "true"
                                                         "false"))
                           ("data[alerts][favourite]" ,(if dataAlertsFavorite
                                                           "true"
                                                         "false"))
                           ("data[alerts][reblog]"    ,(if dataAlertsReblog
                                                           "true"
                                                         "false"))
                           ("data[alerts][mention]"   ,(if dataAlertsMention
                                                           "true"
                                                         "false"))
                           ("data[alerts][poll]"      ,(if dataAlertsPoll
                                                           "true"
                                                         "false")))))
        #:headers `((Authorization . ,(string-append
                                        "Bearer "
                                        (masto-app-token mastoApp)))))
    (if-let ([bodySCM (cut assoc-ref <> "error") (json-string->scm
                                                   (utf8->string body))])
        (error (assoc-ref bodySCM "error"))
      (generate-masto-web-push-subscription bodySCM))))

(define (masto-web-push-delete-subscription mastoApp)
  (receive (header body)
      (http-delete
        (string-append (masto-app-domain mastoApp) "/api/v1/push/subscription")
        #:headers `((Authorization . ,(string-append
                                        "Bearer "
                                        (masto-app-token mastoApp)))))
    (if-let ([errMsg (assoc-ref (json-string->scm (utf8->string body)) "error")])
        (error errMsg)
      #t)))
