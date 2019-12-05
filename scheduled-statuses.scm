(define-module (elefan scheduled-statuses)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (elefan utils)
  #:use-module (srfi srfi-19)
  #:export (masto-scheduled-statuses-all  masto-scheduled-status-get
            masto-scheduled-status-update masto-scheduled-status-delete))

(define (masto-scheduled-statuses-all mastoApp)
  (generate-masto-scheduled-status-array
    (http 'get
      (string-append (masto-app-domain mastoApp) "/api/v1/scheduled_statuses")
      #:token (masto-app-token mastoApp))))

(define (masto-scheduled-status-get mastoApp scheduledStatusID)
  (generate-masto-scheduled-status
    (http 'get
      (string-append (masto-app-domain mastoApp) "/api/v1/scheduled_statuses/"
                     scheduledStatusID)
      #:token (masto-app-token mastoApp))))

(define* (masto-scheduled-status-update mastoApp #:key scheduledStatus
                                                       scheduledStatusID scheduledAt)
  (if (and (not scheduledStatus) (not (and scheduledStatusID scheduledAt)))
      (error (string-append
               "ERROR: In procedure masto-scheduled-status-update:\n"
               "In procedure masto-scheduled-status-update: "
               "If not providing a <mastodon-scheduled-status> record, both "
               "an ID of the Scheduled Status to update and the new "
               "scheduled_at time must be provided"))
    (let ([finalScheduledAt (if scheduledStatus
                                (masto-scheduled-status-scheduled-at
                                  scheduledStatus)
                              scheduledAt)]
          [finalID          (if scheduledStatus
                                (masto-scheduled-status-id scheduledStatus)
                              scheduledStatusID)])
      (generate-masto-scheduled-status
        (http 'put
          (string-append (masto-app-domain mastoApp) "/api/v1/scheduled_statuses/"
                         finalID)
          #:token       (masto-app-token mastoApp)
          #:queryParams `(("scheduled_at" ,(if (string? finalScheduledAt)
                                               finalScheduledAt
                                             (date->string
                                               finalScheduledAt
                                               "~Y-~m-~dT~H:~M:~S.~N~z")))))))))

(define (masto-scheduled-status-delete mastoApp scheduledStatusID)
  (http 'delete
    (string-append (masto-app-domain mastoApp) "/api/v1/scheduled_statuses/"
                   scheduledStatusID)
    #:token (masto-app-token mastoApp))

  #t)
