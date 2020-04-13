(define-module (elefan domain-blocks)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (elefan utils)
  #:export (masto-domain-blocks-all
            masto-block-domain
            masto-unblock-domain)
  #:re-export (<mastodon-pagination-object> masto-page? masto-page-objects
                                                        masto-page-prev
                                                        masto-page-next))

(define* (masto-domain-blocks-all mastoApp #:optional [limit 40])
  (generate-masto-page
    mastoApp
    'get
    (string-append (masto-app-domain mastoApp) "/api/v1/domain_blocks"
                   "?limit="                   (number->string limit))
    vector->list))

(define (masto-block-domain mastoApp domain)
  (http 'post
    (string-append (masto-app-domain mastoApp) "/api/v1/domain_blocks")
    #:token       (masto-app-token mastoApp)
    #:queryParams `(("domain" ,domain)))

  #t)

(define (masto-unblock-domain mastoApp domain)
  (http 'delete
    (string-append (masto-app-domain mastoApp) "/api/v1/domain_blocks")
    #:token       (masto-app-token mastoApp)
    #:queryParams `(("domain" ,domain)))

  #t)
