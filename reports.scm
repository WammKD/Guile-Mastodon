(define-module (elefan reports)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (elefan utils)
  #:use-module (ice-9 receive)
  #:use-module (json)
  #:use-module (rnrs bytevectors)
  #:use-module (web client)
  #:export (masto-report-account))

(define* (masto-report-account mastoApp accountID #:key statusIDs comment forward)
  (receive (header body)
      (http-post
        (string-append (masto-app-domain mastoApp) "/api/v1/reports"
                       (assemble-params `(("account_id" ,accountID)
                                          ("status_ids" ,statusIDs)
                                          ("comment"    ,comment)
                                          ("forward"    ,(if forward
                                                             "true"
                                                           "false")))))
        #:headers `((Authorization . ,(string-append
                                        "Bearer "
                                        (masto-app-token mastoApp)))))
    (if-let ([errMsg (assoc-ref (json-string->scm (utf8->string body)) "error")])
        (error errMsg)
      #t)))
