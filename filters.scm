(define-module (elefan filters)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (elefan enums)
  #:use-module (elefan utils)
  #:use-module (ice-9 receive)
  #:use-module (json)
  #:use-module (rnrs bytevectors)
  #:use-module (srfi srfi-19)
  #:use-module (srfi srfi-26)
  #:use-module (web client)
  #:export (masto-filters-all masto-filter-status masto-unfilter-status))

(define (masto-filters-all mastoApp)
  (receive (header body)
      (http-get (string-append (masto-app-domain mastoApp) "/api/v1/filters")
                #:headers `((Authorization . ,(string-append
                                                "Bearer "
                                                (masto-app-token mastoApp)))))
    (generate-masto-filter (json-string->scm (utf8->string body)))))

(define* (masto-filter-create mastoApp #:key filter    phrase       context
                                             expiresIn irreversible wholeWord)
  (let ([f (if filter filter `(("phrase"       . ,phrase)
                               ("context"      . ,context)
                               ("expires_at"   . ,expiresIn)
                               ("irreversible" . ,irreversible)
                               ("whole_word"   . ,wholeWord)))])
    (cond
     [(not (enum-member? (masto-filter-context f) FILTER_CONTEXT_ENUM))
           (error (string-append
                    "ERROR: In procedure masto-filter-create:\n"
                    "In procedure masto-filter-create: Non-valid "
                    "context provided for second argument"))]
     [(not (masto-filter-phrase f))
           (error (string-append
                    "ERROR: In procedure masto-filter-create:\n"
                    "In procedure masto-filter-create: No phrase "
                    "provided; filter phrase is required."))]
     [else (receive (header body)
               (http-post
                 (string-append (masto-app-domain mastoApp) "/api/v1/filters"
                                (assemble-params
                                  `(("phrase"       ,(masto-filter-phrase f))
                                    ("context"      ,(enum-member-or-value->string
                                                       (masto-filter-context f)))
                                    ("irreversible" ,(if (masto-filter-irreversible f)
                                                         "true"
                                                       "false"))
                                    ("whole_word"   ,(if (masto-filter-whole-word   f)
                                                         "true"
                                                       "false"))))
                                (if-let ([ei not (masto-filter-expires-at f)])
                                    ""
                                  (string-append
                                    "&expires_in="
                                    (if (string? ei)
                                        ei
                                      (date->string ei "~Y-~m-~dT~H:~M:~S.~N~z")))))
                 #:headers `((Authorization . ,(string-append
                                                 "Bearer "
                                                 (masto-app-token mastoApp)))))
             (if-let ([bodySCM (cut assoc-ref <> "error") (json-string->scm
                                                            (utf8->string body))])
                 (error (assoc-ref bodySCM "error"))
               (generate-masto-filter bodySCM)))])))

(define (masto-filter-get mastoApp filterID)
  (receive (header body)
      (http-get
        (string-append (masto-app-domain mastoApp) "/api/v1/filters/" filterID)
        #:headers `((Authorization . ,(string-append
                                        "Bearer "
                                        (masto-app-token mastoApp)))))
    (if-let ([bodySCM (cut assoc-ref <> "error") (json-string->scm
                                                   (utf8->string body))])
        (error (assoc-ref bodySCM "error"))
      (generate-masto-filter bodySCM))))

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
     [else (receive (header body)
               (http-put
                 (string-append (masto-app-domain mastoApp) "/api/v1/filters/"
                                (masto-filter-id         f)
                                (assemble-params
                                  `(("phrase"       ,(masto-filter-phrase f))
                                    ("context"      ,(enum-member-or-value->string
                                                       (masto-filter-context f)))
                                    ("irreversible" ,(if (masto-filter-irreversible f)
                                                         "true"
                                                       "false"))
                                    ("whole_word"   ,(if (masto-filter-whole-word   f)
                                                         "true"
                                                       "false"))))
                                (if-let ([ei not (masto-filter-expires-at f)])
                                    ""
                                  (string-append
                                    "&expires_in="
                                    (if (string? ei)
                                        ei
                                      (date->string ei "~Y-~m-~dT~H:~M:~S.~N~z")))))
                 #:headers `((Authorization . ,(string-append
                                                 "Bearer "
                                                 (masto-app-token mastoApp)))))
             (if-let ([bodySCM (cut assoc-ref <> "error") (json-string->scm
                                                            (utf8->string body))])
                 (error (assoc-ref bodySCM "error"))
               (generate-masto-filter bodySCM)))])))

(define (masto-filter-delete mastoApp filterID)
  (receive (header body)
      (http-delete
        (string-append (masto-app-domain mastoApp) "/api/v1/filters/" filterID)
        #:headers `((Authorization . ,(string-append
                                        "Bearer "
                                        (masto-app-token mastoApp)))))
    (if-let ([errMsg (assoc-ref (json-string->scm (utf8->string body)) "error")])
        (error errMsg)
      #t)))
