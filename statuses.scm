(define-module (elefan statuses)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (elefan enums)
  #:use-module (elefan utils)
  #:use-module (srfi srfi-19)
  #:export (masto-status-get              masto-status-create
            masto-status-get-context      masto-status-delete
            masto-status-get-card         masto-status-reblog
            masto-status-get-reblogged-by masto-status-unreblog
            masto-status-get-favorited-by masto-status-pin
                                          masto-status-unpin))

(define (masto-status-get domainOrApp statusID)
  (generate-masto-status
    (http 'get (string-append
                 (if (masto-instance-app? domainOrApp)
                     (masto-app-domain domainOrApp)
                   (if (string-contains-ci domainOrApp "https://")
                       domainOrApp
                     (string-append/shared "https://" domainOrApp)))
                 "/api/v1/statuses/"
                 statusID))))

(define (masto-status-get-context domainOrApp statusID)
  (generate-masto-context
    (http 'get (string-append
                 (if (masto-instance-app? domainOrApp)
                     (masto-app-domain domainOrApp)
                   (if (string-contains-ci domainOrApp "https://")
                       domainOrApp
                     (string-append/shared "https://" domainOrApp)))
                 "/api/v1/statuses/"
                 statusID
                 "/context"))))

(define (masto-status-get-card domainOrApp statusID)
  (generate-masto-card
    (http 'get (string-append
                 (if (masto-instance-app? domainOrApp)
                     (masto-app-domain domainOrApp)
                   (if (string-contains-ci domainOrApp "https://")
                       domainOrApp
                     (string-append/shared "https://" domainOrApp)))
                 "/api/v1/statuses/"
                 statusID
                 "/card"))))

(define* (masto-status-get-reblogged-by domainOrApp statusID #:optional [limit 40])
  (generate-masto-page
    #f
    'get
    (string-append
      (if (masto-instance-app? domainOrApp)
          (masto-app-domain domainOrApp)
        (if (string-contains-ci domainOrApp "https://")
            domainOrApp
          (string-append/shared "https://" domainOrApp))) "/api/v1/statuses/"
      statusID                                            "/reblogged_by"
      "?limit="                                           (number->string limit))
    generate-masto-account-array))

(define* (masto-status-get-favorited-by domainOrApp statusID #:optional [limit 40])
  (generate-masto-page
    #f
    'get
    (string-append
      (if (masto-instance-app? domainOrApp)
          (masto-app-domain domainOrApp)
        (if (string-contains-ci domainOrApp "https://")
            domainOrApp
          (string-append/shared "https://" domainOrApp))) "/api/v1/statuses/"
      statusID                                            "/favourited_by"
      "?limit="                                           (number->string limit))
    generate-masto-account-array))

(define* (masto-status-create mastoApp #:key statusObject statusText
                                             inReplyToID  mediaIDs
                                             sensitive    spoilerText
                                             visibility   scheduledAt
                                             language     poll
                                             pollOptions  pollExpiresIn
                                             pollMultiple pollHideTotals idempotencyKey)
  (let ([s `(("status"            ,(if statusObject
                                       (masto-status-content        statusObject)
                                     statusText))
             ("in_reply_to_id"    ,(if statusObject
                                       (masto-status-in-reply-to-id statusObject)
                                     inReplyToID))
             ("media_ids"         ,(if statusObject
                                       (map
                                         masto-attachment-id
                                         (masto-status-media-attachments statusObject))
                                     mediaIDs))
             ("sensitive"         ,(boolean->string
                                     (if statusObject
                                         (masto-status-sensitive  statusObject)
                                       sensitive)))
             ("spoiler_text"      ,(if statusObject
                                       (masto-status-spoiler-text statusObject)
                                     spoilerText))
             ("visibility"        ,(let ([v (if statusObject
                                                (masto-status-visibility statusObject)
                                              visibility)])
                                     (cond
                                      [(and v (enum-member? v STATUS_VISIBILITY_ENUM))
                                            (enum-member-or-value->string v)]
                                      [(not v)
                                            v]
                                      [else (error (string-append
                                                     "ERROR: In procedure masto-status-create:\n"
                                                     "In procedure masto-status-create: "
                                                     "Non-valid status visibility enum provided"))])))
             ("scheduled_at"      ,(if (string? scheduledAt)
                                       scheduledAt
                                     (date->string
                                       scheduledAt
                                       "~Y-~m-~dT~H:~M:~S.~N~z")))
             ("language"          ,language)
             ("poll[options]"     ,(if poll
                                       (map
                                         masto-poll-option-title
                                         (masto-poll-options poll))
                                     pollOptions))
             ("poll[expires_in]"  ,(if-let ([ei not (if poll
                                                        (masto-poll-expires-at poll)
                                                      pollExpiresIn)])
                                       ei
                                     (number->string
                                       (cond
                                        [(date? ei)
                                              (time-second
                                                (time-difference
                                                  (date->time-utc ei)
                                                  (date->time-utc (current-date
                                                                    (date-zone-offset ei)))))]
                                        [(time? ei)
                                              (time-second ei)]
                                        [(number? ei)
                                              ei]
                                        [else (error (string-append
                                                       "ERROR: In procedure masto-status-create:\n"
                                                       "In procedure masto-status-create: "
                                                       "pollExpiresIn must be srfi-19 date or time "
                                                       "or number of seconds"))]))))
             ("poll[multiple]"    ,(boolean->string
                                     (if poll
                                         (masto-poll-multiple poll)
                                       pollMultiple)))
             ("poll[hide_totals]" ,(boolean->string pollHideTotals)))])
    (cond
     [(not (or (car (assoc-ref s "status")) (car (assoc-ref s "media_ids"))))
           (error (string-append
                    "ERROR: In procedure masto-status-create:\n"
                    "In procedure masto-status-create: "
                    "Empty statuses not permitted; provide status text or "
                    "media IDs"))]
     [(let ([o (car (assoc-ref s "poll[options]"))]
            [e (car (assoc-ref s "poll[expires_in]"))])
        (and (or o e) (not (and o e))))
           (error (string-append
                    "ERROR: In procedure masto-status-create:\n"
                    "In procedure masto-status-create: "
                    "Polls require both poll options and seconds to expire by"))]
     [(and
        (car (assoc-ref s "poll[options]"))
        (car (assoc-ref s "poll[expires_in]"))
        (not statusText))
           (error (string-append
                    "ERROR: In procedure masto-status-create:\n"
                    "In procedure masto-status-create: "
                    "Polls require status text"))]
     [(and
        (car (assoc-ref s "poll[options]"))
        (car (assoc-ref s "poll[expires_in]"))
        mediaIDs)
           (error (string-append
                    "ERROR: In procedure masto-status-create:\n"
                    "In procedure masto-status-create: "
                    "Status poll cannot be combined with media attachments"))]
     [else ((if (car (assoc-ref s "scheduled_at"))
                generate-masto-scheduled-status
              generate-masto-status)
             (http 'post
               (string-append (masto-app-domain mastoApp) "/api/v1/statuses")
               #:token          (masto-app-token mastoApp)
               #:queryParams    s
               #:idempotencyKey (if idempotencyKey idempotencyKey #f)))])))

(define (masto-status-delete mastoApp statusID)
  (http 'delete
    (string-append (masto-app-domain mastoApp) "/api/v1/statuses/" statusID)
    #:token (masto-app-token mastoApp))

  #t)

(define (masto-status-reblog mastoApp statusID)
  (generate-masto-status
    (http 'post
      (string-append (masto-app-domain mastoApp) "/api/v1/statuses/"
                     statusID                    "/reblog")
      #:token (masto-app-token mastoApp))))

(define (masto-status-unreblog mastoApp statusID)
  (generate-masto-status
    (http 'post
      (string-append (masto-app-domain mastoApp) "/api/v1/statuses/"
                     statusID                    "/unreblog")
      #:token (masto-app-token mastoApp))))

(define (masto-status-pin mastoApp statusID)
  (generate-masto-status
    (http 'post
      (string-append (masto-app-domain mastoApp) "/api/v1/statuses/"
                     statusID                    "/pin")
      #:token (masto-app-token mastoApp))))

(define (masto-status-unpin mastoApp statusID)
  (generate-masto-status
    (http 'post
      (string-append (masto-app-domain mastoApp) "/api/v1/statuses/"
                     statusID                    "/unpin")
      #:token (masto-app-token mastoApp))))
