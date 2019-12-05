(define-module (elefan timelines)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (elefan utils)
  #:export (masto-timelines-home
            masto-conversations-all
            masto-timelines-public
            masto-timelines-tag
            masto-timelines-list))

(define* (masto-timelines-home mastoApp #:key maxID sinceID minID [limit 20])
  (generate-masto-status-array
    (http 'get
      (string-append (masto-app-domain mastoApp) "/api/v1/timelines/home")
      #:token       (masto-app-token mastoApp)
      #:queryParams `((  "max_id" ,maxID)
                      ("since_id" ,sinceID)
                      (  "min_id" ,minID)
                      ("limit"    ,limit)))))

(define* (masto-conversations-all mastoApp #:key maxID sinceID minID [limit 20])
  (generate-masto-page
    mastoApp
    'get
    (string-append (masto-app-domain mastoApp) "/api/v1/conversations"
                   (assemble-params `((  "max_id" ,maxID)
                                      ("since_id" ,sinceID)
                                      (  "min_id" ,minID)
                                      ("limit"    ,limit))))
    generate-masto-convo-array))

(define* (masto-timelines-public domainOrApp #:key local   onlyMedia maxID
                                                   sinceID minID     [limit 20])
  (generate-masto-page
    #f
    'get
    (string-append
      (if (masto-instance-app? domainOrApp)
          (masto-app-domain domainOrApp)
        (if (string-contains-ci domainOrApp "https://")
            domainOrApp
          (string-append/shared "https://" domainOrApp)))
      "/api/v1/timelines/public"
      (assemble-params `(("local"      ,(boolean->string local))
                         ("only_media" ,(boolean->string onlyMedia))
                         (  "max_id"   ,maxID)
                         ("since_id"   ,sinceID)
                         (  "min_id"   ,minID)
                         ("limit"      ,limit))))
    generate-masto-status-array))

(define* (masto-timelines-tag domainOrApp hashtag #:key local onlyMedia
                                                        maxID sinceID
                                                        minID [limit 20])
  (generate-masto-page
    #f
    'get
    (string-append
      (if (masto-instance-app? domainOrApp)
          (masto-app-domain domainOrApp)
        (if (string-contains-ci domainOrApp "https://")
            domainOrApp
          (string-append/shared "https://" domainOrApp)))
      "/api/v1/timelines/tag/" hashtag
      (assemble-params `(("local"      ,(boolean->string local))
                         ("only_media" ,(boolean->string onlyMedia))
                         (  "max_id"   ,maxID)
                         ("since_id"   ,sinceID)
                         (  "min_id"   ,minID)
                         ("limit"      ,limit))))
    generate-masto-status-array))

(define* (masto-timelines-list mastoApp listID #:key maxID sinceID
                                                     minID [limit 20])
  (generate-masto-page
    mastoApp
    'get
    (string-append (masto-app-domain mastoApp) "/api/v1/timelines/list/" listID
                   (assemble-params `((  "max_id" ,maxID)
                                      ("since_id" ,sinceID)
                                      (  "min_id" ,minID)
                                      ("limit"    ,limit))))
    generate-masto-status-array))
