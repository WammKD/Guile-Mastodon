(define-module (elefan auth)
  #:use-module (elefan utils)
  #:use-module (ice-9 receive)
  #:use-module (json)
  #:use-module (rnrs bytevectors)
  #:use-module (srfi srfi-9)
  #:use-module (web client)
  #:export (<mastodon-instance-application>
            masto-instance-app?
            masto-app-domain
            masto-app-key
            masto-app-id
            masto-app-secret
            masto-app-name
            masto-app-redirects
            masto-app-scopes
            masto-app-token
            masto-app-website
            masto-app-instantiate
            masto-app-authorize-uri
            masto-app-set-token-via-code!
            masto-app-set-token-via-user-cred!
            masto-app-set-token-via-client-cred!
            masto-app-verify-cred))

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
  (scopes    masto-app-scopes    masto-app-scopes-set!)
  (token     masto-app-token     masto-app-token-set!))

(define* (masto-app-instantiate domain #:key website id secret key
                                             [name                            "Elefan"]
                                             [redirects '("urn:ietf:wg:oauth:2.0:oob")]
                                             [scopes                         '("read")])
  (let ([app (if (or (not id) (not secret) (not key))
                 (http 'post
                   (string-append/shared domain "/api/v1/apps")
                   #:queryParams `(("client_name"   ,name)
                                   ("redirect_uris" ,(string-join redirects "\n"))
                                   ("scopes"        ,(string-join scopes    "%20"))
                                   ("website"       ,website)))
               `(("name"          . ,name)
                 ("client_id"     . ,id)
                 ("client_secret" . ,secret)
                 ("vapid_key"     . ,key)
                 ("website"       . ,website)))])
    (make-masto-app domain                      (assoc-ref app "name")
                    (assoc-ref app "website")   redirects
                    (assoc-ref app "client_id") (assoc-ref app "client_secret")
                    (assoc-ref app "vapid_key") scopes)))





(define (masto-app-set-token-via-post-call! app queryParams)
  (masto-app-token-set! app (assoc-ref (http 'post
                                         (string-append/shared
                                           (masto-app-domain app)
                                           "/oauth/token")
                                         #:queryParams queryParams) "access_token"))

  app)





(define* (masto-app-authorize-uri mastoApp #:key redirect scopes)
  (string-append (masto-app-domain mastoApp) "/oauth/authorize"
                 (assemble-params
                   `(("scope"         ,(string-join (if scopes
                                                        scopes
                                                      (masto-app-scopes
                                                        mastoApp))        "%20"))
                     ("response_type" "code")
                     ("redirect_uri"  ,(if redirect
                                           redirect
                                         (car (masto-app-redirects mastoApp))))
                     ("client_id"     ,(masto-app-id     mastoApp))
                     ("client_secret" ,(masto-app-secret mastoApp))))))

(define* (masto-app-set-token-via-code! mastoApp code #:optional redirect)
  (masto-app-set-token-via-post-call!
    mastoApp
    `(("client_id"     ,(masto-app-id     mastoApp))
      ("client_secret" ,(masto-app-secret mastoApp))
      ("grant_type"    "authorization_code")
      ("code"          ,code)
      ("redirect_uri"  ,(if redirect
                            redirect
                          (car (masto-app-redirects mastoApp)))))))



(define* (masto-app-set-token-via-user-cred! mastoApp username
                                             password #:optional scopes)
  (masto-app-set-token-via-post-call!
    mastoApp
    `(("grant_type"    "password")
      ("username"      ,username)
      ("password"      ,password)
      ("client_id"     ,(masto-app-id     mastoApp))
      ("client_secret" ,(masto-app-secret mastoApp))
      ("scope"         ,(string-join
                          (if scopes scopes (masto-app-scopes mastoApp))
                          "%20")))))



(define* (masto-app-set-token-via-client-cred! mastoApp #:optional scopes)
  (masto-app-set-token-via-post-call!
    mastoApp
    `(("grant_type"    "client_credentials")
      ("client_id"     ,(masto-app-id     mastoApp))
      ("client_secret" ,(masto-app-secret mastoApp)))))





(define (masto-app-verify-cred mastoApp)
  (http 'get (string-append/shared
               (masto-app-domain mastoApp)
               "/api/v1/apps/verify_credentials")))
