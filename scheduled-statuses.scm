(define-module (elefan scheduled-statuses)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (elefan utils)
  #:use-module (ice-9 receive)
  #:use-module (json)
  #:use-module (rnrs bytevectors)
  #:use-module (web client)
  #:export ())

(define (masto-scheduled-statuses-all mastoApp)
  (receive (header body)
      (http-get
        (string-append (masto-app-domain mastoApp) "/api/v1/scheduled_statuses")
        #:headers `((Authorization . ,(string-append
                                        "Bearer "
                                        (masto-app-token mastoApp)))))
    (if-let ([bodySCM (cut assoc-ref <> "error") (json-string->scm
                                                   (utf8->string body))])
        (error (assoc-ref bodySCM "error"))
      (generate-masto-scheduled-status-array bodySCM))))

(define (masto-scheduled-status-get mastoApp scheduledStatusID)
  (receive (header body)
      (http-get
        (string-append (masto-app-domain mastoApp) "/api/v1/scheduled_statuses/"
                       scheduledStatusID)
        #:headers `((Authorization . ,(string-append
                                        "Bearer "
                                        (masto-app-token mastoApp)))))
    (if-let ([bodySCM (cut assoc-ref <> "error") (json-string->scm
                                                   (utf8->string body))])
        (error (assoc-ref bodySCM "error"))
      (generate-masto-scheduled-status bodySCM))))

(define* (masto-scheduled-status-update mastoApp #:key scheduledStatusID scheduledAt scheduledStatus)
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
      (receive (header body)
          (http-put
            (string-append (masto-app-domain mastoApp) "/api/v1/scheduled_statuses/"
                           finalID
                           (assemble-params
                             `(("scheduled_at" ,(if (string? finalScheduledAt)
                                                    finalScheduledAt
                                                  (date->string
                                                    finalScheduledAt
                                                    "~Y-~m-~dT~H:~M:~S.~N~z"))))))
            #:headers `((Authorization . ,(string-append
                                            "Bearer "
                                            (masto-app-token mastoApp)))))
        (if-let ([bodySCM (cut assoc-ref <> "error") (json-string->scm
                                                       (utf8->string body))])
            (error (assoc-ref bodySCM "error"))
          (generate-masto-scheduled-status bodySCM))))))

(define (masto-scheduled-status-delete mastoApp scheduledStatusID)
  (receive (header body)
      (http-delete
        (string-append (masto-app-domain mastoApp) "/api/v1/scheduled_statuses/"
                       scheduledStatusID)
        #:headers `((Authorization . ,(string-append
                                        "Bearer "
                                        (masto-app-token mastoApp)))))
    (if-let ([errMsg (assoc-ref (json-string->scm (utf8->string body)) "error")])
        (error errMsg)
      #t)))
