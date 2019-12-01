(define-module (elefan notifications)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (elefan utils)
  #:use-module (ice-9 receive)
  #:use-module (json)
  #:use-module (rnrs bytevectors)
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-26)
  #:use-module (web client)
  #:export (masto-notifications-all))

(define* (masto-notifications-all mastoApp #:key maxID      sinceID      minID
                                                 [limit 20] excludeTypes accountID)
  (if (every (cut enum-member? <> NOTIFICATION_TYPE_ENUM) exclude_types)
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
