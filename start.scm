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
