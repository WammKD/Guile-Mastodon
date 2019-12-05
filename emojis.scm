(define-module (elefan emojis)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (elefan utils)
  #:export     (masto-emojis-on-instance)
  #:re-export  (<mastodon-emoji> masto-emoji? masto-emoji-shortcode
                                              masto-emoji-static-url
                                              masto-emoji-url
                                              masto-emoji-visible-in-picker))

(define (masto-emojis-on-instance domainOrApp)
  (generate-masto-emoji-array
    (http 'get (string-append
                 (if (masto-instance-app? domainOrApp)
                     (masto-app-domain domainOrApp)
                   (if (string-contains-ci domainOrApp "https://")
                       domainOrApp
                     (string-append/shared "https://" domainOrApp)))
                 "/api/v1/custom_emojis"))))
