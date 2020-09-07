(define-module (elefan scheduled-statuses)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (elefan utils)
  #:use-module (srfi srfi-19)
  #:export (masto-scheduled-statuses-all  masto-scheduled-status-get
            masto-scheduled-status-update masto-scheduled-status-delete)
  #:re-export (<mastodon-meta-subtree> masto-meta-subtree? masto-meta-subtree-width
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
               <mastodon-scheduled-status-params> masto-scheduled-status-params? masto-scheduled-status-params-text
                                                                                 masto-scheduled-status-params-in-reply-to-id
                                                                                 masto-scheduled-status-params-media-ids
                                                                                 masto-scheduled-status-params-sensitive
                                                                                 masto-scheduled-status-params-spoiler-text
                                                                                 masto-scheduled-status-params-visibility
                                                                                 masto-scheduled-status-params-scheduled-at
                                                                                 masto-scheduled-status-params-application-id
               <mastodon-scheduled-status> masto-scheduled-status? masto-scheduled-status-id
                                                                   masto-scheduled-status-scheduled-at
                                                                   masto-scheduled-status-scheduled-at-set!
                                                                   masto-scheduled-status-params
                                                                   masto-scheduled-status-media-attachments))

(define (masto-scheduled-statuses-all mastoApp)
  "Retrieve all scheduled statuses associated with the user tied to `mastoApp`.

A list of <mastodon-scheduled-status>es is returned.

Find the original documentation [here](https://docs.joinmastodon.org/methods/statuses/scheduled_statuses/)."
  (generate-masto-scheduled-status-array
    (http 'get
      (string-append (masto-app-domain mastoApp) "/api/v1/scheduled_statuses")
      #:token (masto-app-token mastoApp))))

(define (masto-scheduled-status-get mastoApp scheduledStatusID)
  "Get a scheduled status with the ID `scheduledStatusID` for the user tied to
`mastoApp`.

A <mastodon-scheduled-status> is returned.

Find the original documentation [here](https://docs.joinmastodon.org/methods/statuses/scheduled_statuses/)."
  (generate-masto-scheduled-status
    (http 'get
      (string-append (masto-app-domain mastoApp) "/api/v1/scheduled_statuses/"
                     scheduledStatusID)
      #:token (masto-app-token mastoApp))))

(define* (masto-scheduled-status-update mastoApp #:key scheduledStatus
                                                       scheduledStatusID scheduledAt)
  "Get a scheduled status for the user tied to `mastoApp`.

A <mastodon-scheduled-status> object can be used, for `scheduledStatus`, or the
ID of a scheduled status and the scheduled time to update to, for
`scheduledStatusID` and `scheduledAt` respectively.

If using a <mastodon-scheduled-status> object, you can update the `scheduledAt`
attribute of the record with masto-scheduled-status-scheduled-at-set!.

If `scheduledStatus` is provided, it will be used, regardless of the values, if
any, of `scheduledStatusID` or `scheduledAt`.

`scheduledAt` can be a SRFI-19 [date](https://www.gnu.org/software/guile/manual/html_node/SRFI_002d19-Date.html)
object or a ISO 8601 Datetime string; if using a SRFI-19 date, the appropriately
formatted string will be generated, for you.

A <mastodon-scheduled-status> is returned.

Find the original documentation [here](https://docs.joinmastodon.org/methods/statuses/scheduled_statuses/)."
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
  "Delete a scheduled status with the ID `scheduledStatusID` for the user tied
to `mastoApp`.

If successful, this function will return `#t`.

Find the original documentation [here](https://docs.joinmastodon.org/methods/statuses/scheduled_statuses/)."
  (http 'delete
    (string-append (masto-app-domain mastoApp) "/api/v1/scheduled_statuses/"
                   scheduledStatusID)
    #:token (masto-app-token mastoApp))

  #t)
