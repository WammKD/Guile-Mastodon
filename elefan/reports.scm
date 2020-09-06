(define-module (elefan reports)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (elefan utils)
  #:export (masto-report-account))

(define* (masto-report-account mastoApp accountID #:key statusIDs comment forward)
  "File a report against an account with ID `accountID` for the user tied to
`mastoApp`.

`statusIDs` are a list of status IDs to attach to the report, for context.

`comment` are any comments you wish to attach to the report, with a max of 1,000
characters.

`forward` is a boolean determining, if the account is remote, whether the report
should be forwarded to the remote admin.

This function, if successful, returns `#t`.

Find the original documentation [here](https://docs.joinmastodon.org/methods/accounts/reports/)."
  (if (and comment (> (string-length comment) 1000))
      (error (string-append
               "ERROR: In procedure masto-report-account:\n"
               "In procedure masto-report-account: "
               "Function argument comment exceeds max. length of 1000"))
    (http 'post
      (string-append (masto-app-domain mastoApp) "/api/v1/reports")
      #:token       (masto-app-token mastoApp)
      #:queryParams `(("account_id" ,accountID)
                      ("status_ids" ,statusIDs)
                      ("comment"    ,comment)
                      ("forward"    ,(boolean->string forward)))))

  #t)
