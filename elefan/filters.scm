(define-module (elefan filters)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (elefan enums)
  #:use-module (elefan utils)
  #:use-module (srfi srfi-19)
  #:export (masto-filters-all masto-filter-create
            masto-filter-get  masto-filter-update masto-filter-delete)
  #:re-export (<mastodon-filter> masto-filter? masto-filter-id
                                               masto-filter-phrase
                                               masto-filter-context
                                               masto-filter-expires-at
                                               masto-filter-irreversible
                                               masto-filter-whole-word))

(define (masto-filters-all mastoApp)
  "Retrieve all filters created by the user tied to `mastoApp`.

This function will return a list of [\\<mastodon-filter\\>](#mastodon-filter)s.

Find the original documentation [here](https://docs.joinmastodon.org/entities/filter/)."
  (generate-masto-filter-array
    (http 'get
      (string-append (masto-app-domain mastoApp) "/api/v1/filters")
      #:token (masto-app-token mastoApp))))

(define* (masto-filter-create mastoApp #:key filter    phrase       context
                                             expiresIn irreversible wholeWord)
  (let ([f `(("phrase"       ,(if filter (masto-filter-phrase filter) phrase))
             ("context"      ,(enum-member-or-value->string
                                (if filter (masto-filter-context filter) context)))
             ("irreversible" ,(boolean->string
                                (if filter (masto-filter-irreversible
                                             filter)                   irreversible)))
             ("whole_word"   ,(boolean->string
                                (if filter (masto-filter-whole-word
                                             filter)                 wholeWord)))
             ("expires_in"   ,(if-let ([ei not (if filter
                                                   (masto-filter-expires-at filter)
                                                 expiresIn)])
                                  ei
                                (number->string
                                  (cond
                                   [(date?   ei)
                                         (time-second
                                           (time-difference
                                             (date->time-utc ei)
                                             (date->time-utc (current-date
                                                               (date-zone-offset ei)))))]
                                   [(time?   ei)
                                         (time-second ei)]
                                   [(number? ei)
                                         ei]
                                   [else (error (string-append
                                                  "ERROR: In procedure masto-filter-create:\n"
                                                  "In procedure masto-filter-create: "
                                                  "expiresIn must be srfi-19 date or time "
                                                  "or number of seconds"))])))))])
    (cond
     [(not (enum-member? (car (assoc-ref "context" f)) FILTER_CONTEXT_ENUM))
           (error (string-append
                    "ERROR: In procedure masto-filter-create:\n"
                    "In procedure masto-filter-create: Non-valid "
                    "context provided for second argument"))]
     [(not (car (assoc-ref "phrase" f)))
           (error (string-append
                    "ERROR: In procedure masto-filter-create:\n"
                    "In procedure masto-filter-create: No phrase "
                    "provided; filter phrase is required."))]
     [else (generate-masto-filter
             (http 'post
               (string-append (masto-app-domain mastoApp) "/api/v1/filters")
               #:token       (masto-app-token mastoApp)
               #:queryParams f))])))

(define (masto-filter-get mastoApp filterID)
  "Retrieve a particular filter created by the user tied to `mastoApp`.

`filterID` refers to the ID of the filter that you wish to retrieve.

This function will return a [\\<mastodon-filter\\>](#mastodon-filter).

Find the original documentation [here](https://docs.joinmastodon.org/methods/accounts/filters/)."
  (generate-masto-filter
    (http 'get
      (string-append (masto-app-domain mastoApp) "/api/v1/filters/" filterID)
      #:token (masto-app-token mastoApp))))

(define* (masto-filter-update mastoApp #:key filter  id        phrase
                                             context expiresIn irreversible wholeWord)
  (let ([f (if filter filter `(("id"           . ,id)
                               ("phrase"       . ,phrase)
                               ("context"      . ,context)
                               ("expires_at"   . ,expiresIn)
                               ("irreversible" . ,irreversible)
                               ("whole_word"   . ,wholeWord)))])
    (cond
     [(not (enum-member? (masto-filter-context f) FILTER_CONTEXT_ENUM))
           (error (string-append
                    "ERROR: In procedure masto-filter-update:\n"
                    "In procedure masto-filter-update: Non-valid "
                    "context provided for second argument"))]
     [(not (masto-filter-phrase f))
           (error (string-append
                    "ERROR: In procedure masto-filter-update:\n"
                    "In procedure masto-filter-update: No phrase "
                    "provided; filter phrase is required."))]
     [(not (masto-filter-id f))
           (error (string-append
                    "ERROR: In procedure masto-filter-update:\n"
                    "In procedure masto-filter-update: No phrase "
                    "provided; filter id is required."))]
     [else (generate-masto-filter
             (http 'post
               (string-append (masto-app-domain mastoApp) "/api/v1/filters/"
                              (masto-filter-id         f))
               #:token       (masto-app-token mastoApp)
               #:queryParams `(("phrase"       ,(masto-filter-phrase f))
                               ("context"      ,(enum-member-or-value->string
                                                  (masto-filter-context f)))
                               ("irreversible" ,(boolean->string
                                                  (masto-filter-irreversible f)))
                               ("whole_word"   ,(boolean->string
                                                  (masto-filter-whole-word   f)))
                               ("expires_in"   ,(if-let ([ei not (masto-filter-expires-at f)])
                                                    ei
                                                  (number->string
                                                    (cond
                                                     [(date? ei)
                                                           (time-second
                                                             (time-difference
                                                               (date->time-utc ei)
                                                               (date->time-utc (current-date
                                                                                 (date-zone-offset ei)))))]
                                                     [(time? ei)
                                                           (time-second ei)]
                                                     [(number? ei)
                                                           ei]
                                                     [else (error (string-append
                                                                    "ERROR: In procedure masto-filter-update:\n"
                                                                    "In procedure masto-filter-update: "
                                                                    "expiresIn must be srfi-19 date or time "
                                                                    "or number of seconds"))])))))))])))

(define (masto-filter-delete mastoApp filterID)
  (http 'delete
    (string-append (masto-app-domain mastoApp) "/api/v1/filters/" filterID)
    #:token (masto-app-token mastoApp))

  #t)
