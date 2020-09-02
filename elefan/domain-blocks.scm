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
  "Retrieve all domain blocks associated with the user tied to `mastoApp`.

If no `limit` value is provided, the value 40 is used.

A <mastodon-pagination-object> is returned,
consisting of the domains that the user has blocked, as Strings.

Find the original documentation [here](https://docs.joinmastodon.org/methods/accounts/domain_blocks/)."
  (generate-masto-page
    mastoApp
    'get
    (string-append (masto-app-domain mastoApp) "/api/v1/domain_blocks"
                   "?limit="                   (number->string limit))
    vector->list))

(define (masto-block-domain mastoApp domain)
  "Block an existing Fediverse instance for the user tied to `mastoApp`.

`domain` refers to the domain of the instance that you wish to block.

If successful, this function will return `#t`.

Find the original documentation [here](https://docs.joinmastodon.org/methods/accounts/domain_blocks/)."
  (http 'post
    (string-append (masto-app-domain mastoApp) "/api/v1/domain_blocks")
    #:token       (masto-app-token mastoApp)
    #:queryParams `(("domain" ,domain)))

  #t)

(define (masto-unblock-domain mastoApp domain)
  "Unblock an existing Fediverse instance for the user tied to `mastoApp`.

`domain` refers to the domain of the instance that you wish to unblock.

If successful, this function will return `#t`.

Find the original documentation [here](https://docs.joinmastodon.org/methods/accounts/domain_blocks/)."
  (http 'delete
    (string-append (masto-app-domain mastoApp) "/api/v1/domain_blocks")
    #:token       (masto-app-token mastoApp)
    #:queryParams `(("domain" ,domain)))

  #t)
