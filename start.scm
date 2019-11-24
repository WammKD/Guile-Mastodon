;; (define-module ()
;;   #:use-module (ice-9 receive)
;;   #:use-module (json)
;;   #:use-module (rnrs bytevectors)
;;   #:use-module (srfi srfi-9)
;;   #:use-module (srfi srfi-26)
;;   #:use-module (web client)
;;   #:export (<mastodon-instance-application>
;;             masto-instance-app?
;;             masto-app-domain
;;             masto-app-key
;;             masto-app-secret
;;             masto-app-name
;;             masto-app-redirect
;;             masto-app-scopes
;;             masto-app-website
;;             instantiate-masto-app))
(use-modules (srfi srfi-9)  (web   client)  (json)
             (srfi srfi-26) (ice-9 receive) (rnrs bytevectors))

(define (assemble-params params)
  (string-append/shared "?" (string-join (map (cut string-join <> "=") params) "&")))



(define-record-type <mastodon-instance-application>
  (make-masto-app domain name website redirects id secret key scopes)
  masto-instance-app?
  (domain    masto-app-domain    masto-app-domain-set!)
  (name      masto-app-name      masto-app-name-set!)
  (website   masto-app-website   masto-app-website-set!)
  (redirects masto-app-redirects masto-app-redirects-set!)
  (id        masto-app-id        masto-app-id-set!)
  (secret    masto-app-secret    masto-app-secret-set!)
  (key       masto-app-key       masto-app-key-set!)
  (scopes    masto-app-scopes    masto-app-scopes-set!))

(define* (masto-app-instantiate domain #:key website id secret key
                                             [name                            "Elefan"]
                                             [redirects '("urn:ietf:wg:oauth:2.0:oob")]
                                             [scopes                         '("read")])
  (let ([app (if (or (not key) (not secret))
                 (receive (header body)
                     (http-post
                       (string-append/shared
                         domain            "/api/v1/apps"
                         (assemble-params
                           `(("client_name"   ,name)
                             ("redirect_uris" ,(string-join redirects "\n"))
                             ("scopes"        ,(string-join scopes    "%20"))))
                         (if website (string-append/shared "&website=" website) "")))
                   (json-string->scm (utf8->string body)))
               `(("name"          . ,name)
                 ("client_id"     . ,key)
                 ("client_secret" . ,secret)
                 ("vapid_key"     . ,key)
                 ("website"       . ,website)))])
    (make-masto-app domain                      (assoc-ref app "name")
                    (assoc-ref app "website")   redirects
                    (assoc-ref app "client_id") (assoc-ref app "client_secret")
                    (assoc-ref app "vapid_key") scopes)))





(define* (masto-app-authorize-uri mastoApp #:key redirect scopes)
  (string-append (masto-app-domain mastoApp) "/oauth/authorize"
                 (assemble-params
                   `(("scope"         ,(string-join (if scopes
                                                        scopes
                                                      (masto-app-scopes
                                                        mastoApp)        "%20")))
                     ("response_type" "code")
                     ("redirect_uri"  ,(if redirect
                                           redirect
                                         (car (masto-app-redirects mastoApp))))
                     ("client_id"     ,(masto-app-id     mastoApp))
                     ("client_secret" ,(masto-app-secret mastoApp))))))

(define* (masto-app-token-via-code mastoApp code #:optional redirect)
  (receive (header body)
      (http-post
        (string-append/shared
          (masto-app-domain mastoApp) "/oauth/token"
          (assemble-params
            `(("client_id"     ,(masto-app-id     mastoApp))
              ("client_secret" ,(masto-app-secret mastoApp))
              ("grant_type"    "authorization_code")
              ("code"          ,code)
              ("redirect_uri"  ,(if redirect
                                    redirect
                                  (car (masto-app-redirects mastoApp))))))))
    (let ([bodySCM (json-string->scm (utf8->string body))])
      (if (assoc-ref bodySCM "error")
          (error (assoc-ref bodySCM "error_description"))
        (assoc-ref bodySCM "access_token")))))



(define* (masto-app-token-via-user-cred mastoApp username
                                        password #:optional scopes)
  (receive (header body)
      (http-post
        (string-append/shared
          (masto-app-domain mastoApp) "/oauth/token"
          (assemble-params
            `(("grant_type"    "password")
              ("username"      ,username)
              ("password"      ,password)
              ("client_id"     ,(masto-app-id     mastoApp))
              ("client_secret" ,(masto-app-secret mastoApp))
              ("scope"         ,(string-join
                                  (if scopes scopes (masto-app-scopes mastoApp))
                                  "%20")))))
        #:headers `((Content-type . "application/x-www-form-urlencoded")))
    (let ([bodySCM (json-string->scm (utf8->string body))])
      (if (assoc-ref bodySCM "error")
          (error (assoc-ref bodySCM "error_description"))
        (assoc-ref bodySCM "access_token")))))



(define* (masto-app-token-via-client-cred mastoApp #:optional scopes)
  (receive (header body)
      (http-post (string-append/shared
                   (masto-app-domain mastoApp) "/token"
                   (assemble-params
                     `(("grant_type"    "client_credentials")
                       ("client_id"     ,(masto-app-id     mastoApp))
                       ("client_secret" ,(masto-app-secret mastoApp))))))
    (let ([bodySCM (json-string->scm (utf8->string body))])
      (if (assoc-ref bodySCM "error")
          (error (assoc-ref bodySCM "error_description"))
        (assoc-ref bodySCM "access_token")))))
