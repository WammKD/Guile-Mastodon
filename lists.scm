(define-module (elefan lists)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (elefan utils)
  #:use-module (ice-9 receive)
  #:use-module (json)
  #:use-module (rnrs bytevectors)
  #:use-module (srfi srfi-26)
  #:use-module (web client)
  #:export ())

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
