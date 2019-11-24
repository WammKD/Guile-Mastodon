(define-module (elefan accounts)
  #:use-module (elefan utils)
  #:use-module (ice-9 receive)
  #:use-module (json)
  #:use-module (rnrs bytevectors)
  #:use-module (web client)
  #:export (masto-accounts-token))

(define (masto-accounts-token mastoApp eMail username password locale)
  (receive (header body)
      (http-post
        (string-append (masto-app-domain mastoApp) "/api/v1/accounts"
                       (assemble-params `(("username"  ,username)
                                          ("email"     ,eMail)
                                          ("password"  ,password)
                                          ("agreement" "true")
                                          ("locale"    ))))
        #:headers `((Authorization . ,(string-append
                                        "Bearer "
                                        (masto-app-token-via-client-cred
                                          mastoApp)))))
    (reverse (json-string->scm (utf8->string body)))))
