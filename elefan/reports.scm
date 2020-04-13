(define-module (elefan reports)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (elefan utils)
  #:export (masto-report-account))

(define* (masto-report-account mastoApp accountID #:key statusIDs comment forward)
  (http 'post
    (string-append (masto-app-domain mastoApp) "/api/v1/reports")
    #:token       (masto-app-token mastoApp)
    #:queryParams `(("account_id" ,accountID)
                    ("status_ids" ,statusIDs)
                    ("comment"    ,comment)
                    ("forward"    ,(boolean->string forward))))

  #t)
