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
;;             masto-app-token
;;             masto-app-name
;;             masto-app-redirect
;;             masto-app-scopes
;;             masto-app-website
;;             instantiate-masto-app))
(use-modules (srfi srfi-9)  (web   client)  (json)
             (srfi srfi-26) (ice-9 receive) (rnrs bytevectors))

(define (assemble-params params)
  (string-append "?" (string-join (map (cut string-join <> "=") params) "&")))



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

(define* (masto-app-instantiate domain #:key website id secret key token
                                             [name                            "Elefan"]
                                             [redirects '("urn:ietf:wg:oauth:2.0:oob")]
                                             [scopes                         '("read")])
  (let ([app (if (or (not key) (not secret))
                 (receive (header body)
                     (http-post
                       (string-append
                         domain            "/api/v1/apps"
                         (assemble-params
                           `(("client_name"   ,name)
                             ("redirect_uris" ,(string-join redirects "\n"))
                             ("scopes"        ,(string-join scopes    "%20"))))
                         (if website (string-append "&website=" website) "")))
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
