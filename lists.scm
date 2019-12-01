(define-module (elefan lists)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (elefan utils)
  #:use-module (ice-9 receive)
  #:use-module (json)
  #:use-module (rnrs bytevectors)
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-26)
  #:use-module (web client)
  #:export (masto-lists-all
            masto-lists-by-account
            masto-accounts-by-list
            masto-list-get
            masto-list-create
            masto-list-update
            masto-list-delete
            masto-list-add-account
            masto-list-delete-account))

(define (masto-lists-all mastoApp)
  (receive (header body)
      (http-get
        (string-append (masto-app-domain mastoApp) "/api/v1/lists")
        #:headers `((Authorization . ,(string-append
                                        "Bearer "
                                        (masto-app-token mastoApp)))))
    (if-let ([bodySCM (cut assoc-ref <> "error") (json-string->scm
                                                   (utf8->string body))])
        (error (assoc-ref bodySCM "error"))
      (generate-masto-list-array bodySCM))))

(define (masto-lists-by-account mastoApp accountID)
  (receive (header body)
      (http-get
        (string-append (masto-app-domain mastoApp) "/api/v1/accounts/"
                       accountID                   "/lists")
        #:headers `((Authorization . ,(string-append
                                        "Bearer "
                                        (masto-app-token mastoApp)))))
    (if-let ([bodySCM (cut assoc-ref <> "error") (json-string->scm
                                                   (utf8->string body))])
        (error (assoc-ref bodySCM "error"))
      (generate-masto-list-array bodySCM))))

(define* (masto-accounts-by-list mastoApp listID #:optional [limit 40])
  (generate-masto-page
    mastoApp
    http-get
    (string-append (masto-app-domain mastoApp) "/api/v1/lists/"
                   listID                      "/accounts"
                   "?limit="                   (number->string limit))
    generate-masto-account-array))

(define (masto-list-get mastoApp listID)
  (receive (header body)
      (http-get
        (string-append (masto-app-domain mastoApp) "/api/v1/lists/" listID)
        #:headers `((Authorization . ,(string-append
                                        "Bearer "
                                        (masto-app-token mastoApp)))))
    (if-let ([bodySCM (cut assoc-ref <> "error") (json-string->scm
                                                   (utf8->string body))])
        (error (assoc-ref bodySCM "error"))
      (generate-masto-list bodySCM))))

(define (masto-list-create mastoApp title)
  (receive (header body)
      (http-post
        (string-append (masto-app-domain mastoApp) "/api/v1/lists"
                       "?title="                   title)
        #:headers `((Authorization . ,(string-append
                                        "Bearer "
                                        (masto-app-token mastoApp)))))
    (if-let ([bodySCM (cut assoc-ref <> "error") (json-string->scm
                                                   (utf8->string body))])
        (error (assoc-ref bodySCM "error"))
      (generate-masto-list bodySCM))))

(define (masto-list-update mastoApp listID title)
  (receive (header body)
      (http-put
        (string-append (masto-app-domain mastoApp) "/api/v1/lists/" listID
                       "?title="                   title)
        #:headers `((Authorization . ,(string-append
                                        "Bearer "
                                        (masto-app-token mastoApp)))))
    (if-let ([bodySCM (cut assoc-ref <> "error") (json-string->scm
                                                   (utf8->string body))])
        (error (assoc-ref bodySCM "error"))
      (generate-masto-list bodySCM))))

(define (masto-list-delete mastoApp listID)
  (receive (header body)
      (http-delete
        (string-append (masto-app-domain mastoApp) "/api/v1/lists/" listID)
        #:headers `((Authorization . ,(string-append
                                        "Bearer "
                                        (masto-app-token mastoApp)))))
    (if-let ([errMsg (assoc-ref (json-string->scm (utf8->string body)) "error")])
        (error errMsg)
      #t)))

(define (masto-list-add-account mastoApp listID accountIDs)
  (receive (header body)
      (http-post
        (string-append (masto-app-domain mastoApp) "/api/v1/lists/"
                       listID                      "/accounts?"
                       (substring
                         (cdr (fold
                                (lambda (accountID result)
                                  (let ([index (car result)])
                                    (cons (1+ index) (string-append
                                                       (cdr result)
                                                       "&account_ids["
                                                       (number->string index)
                                                       "]="
                                                       accountID))))
                                '(0 . "")
                                accountIDs))
                         1))
        #:headers `((Authorization . ,(string-append
                                        "Bearer "
                                        (masto-app-token mastoApp)))))
    (if-let ([errMsg (assoc-ref (json-string->scm (utf8->string body)) "error")])
        (error errMsg)
      #t)))

(define (masto-list-delete-account mastoApp listID accountIDs)
  (receive (header body)
      (http-delete
        (string-append (masto-app-domain mastoApp) "/api/v1/lists/"
                       listID                      "/accounts?"
                       (substring
                         (cdr (fold
                                (lambda (accountID result)
                                  (let ([index (car result)])
                                    (cons (1+ index) (string-append
                                                       (cdr result)
                                                       "&account_ids["
                                                       (number->string index)
                                                       "]="
                                                       accountID))))
                                '(0 . "")
                                accountIDs))
                         1))
        #:headers `((Authorization . ,(string-append
                                        "Bearer "
                                        (masto-app-token mastoApp)))))
    (if-let ([errMsg (assoc-ref (json-string->scm (utf8->string body)) "error")])
        (error errMsg)
      #t)))
