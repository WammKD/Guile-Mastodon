(define-module (elefan entities)
  #:use-module (elefan auth)
  #:use-module (elefan utils)
  #:use-module (ice-9 receive)
  #:use-module (json)
  #:use-module (rnrs bytevectors)
  #:use-module (srfi srfi-9)
  #:use-module (srfi srfi-19)
  #:use-module (srfi srfi-26)
  #:use-module (srfi srfi-43)
  #:use-module (web client)
  #:use-module (web response)
  #:use-module (web uri)
  #:export (<mastodon-pagination-object> masto-page? masto-page-objects
                                                     masto-page-url-prev masto-page-prev
                                                     masto-page-url-next masto-page-next
            generate-masto-page
            generate-masto-page-prev
            generate-masto-page-next
            <mastodon-emoji>   masto-emoji?   masto-emoji-shortcode masto-emoji-static-url
                                              masto-emoji-url       masto-emoji-visible-in-picker
            generate-masto-emoji
            generate-masto-emoji-array
            <mastodon-field>   masto-field?   masto-field-name        masto-field-value
                                              masto-field-verified-at
            <mastodon-account> masto-account? masto-account-id             masto-account-username
                                              masto-account-acct           masto-account-displayName
                                              masto-account-locked         masto-account-createdAt
                                              masto-account-followersCount masto-account-followingCount
                                              masto-account-statusesCount  masto-account-note
                                              masto-account-url            masto-account-avatar
                                              masto-account-avatarStatic   masto-account-header
                                              masto-account-headerStatic   masto-account-emojis
                                              masto-account-moved          masto-account-fields
                                              masto-account-bot
            generate-masto-account
            generate-masto-account-array
            <mastodon-relationship> masto-relationship? masto-relationship-id
                                                        masto-relationship-following
                                                        masto-relationship-followed-by
                                                        masto-relationship-blocking
                                                        masto-relationship-muting
                                                        masto-relationship-muting-notifications
                                                        masto-relationship-requested
                                                        masto-relationship-domain-blocking
                                                        masto-relationship-showing-reblogs
                                                        masto-relationship-endorsed
            generate-masto-relationship))

(define-record-type <mastodon-pagination-object>
  (make-masto-page objectCollection prevURL nextURL http-call generate-fn)
  masto-page?
  (objectCollection masto-page-objects     masto-page-objects-set!)
  (prevURL          masto-page-url-prev    masto-page-url-prev-set!)
  (prevPage         masto-page-prev        masto-page-prev-set!)
  (nextURL          masto-page-url-next    masto-page-url-next-set!)
  (nextPage         masto-page-next        masto-page-next-set!)
  (http-call        masto-page-http-call   masto-page-http-call-set!)
  (generate-fn      masto-page-generate-fn masto-page-generate-fn-set!))

(define (generate-masto-page mastoApp http-type url generate-fn)
  (receive (header body)
      (http-type url #:headers `((Authorization . ,(string-append
                                                     "Bearer "
                                                     (masto-app-token mastoApp)))))
    (if-let ([links (assoc-ref (response-headers header) 'link)])
        (let ([pages (map
                       (lambda (elem)
                          (let ([page (reverse
                                        (map
                                          (lambda (e)
                                            (if-let ([refined (cut string-contains <> "<") (string-trim e)])
                                                (substring refined 1 (1- (string-length refined)))
                                              (substring refined 5 (1- (string-length refined)))))
                                          (string-split elem #\;)))])
                            (cons (car page) (cadr page))))
                       (map string-trim (string-split links #\,)))])
          (make-masto-page
            (generate-fn (json-string->scm (utf8->string body)))
            (assoc-ref pages "prev")
            (assoc-ref pages "next")
            http-type
            generate-fn))
      (make-masto-page
        (generate-fn (json-string->scm (utf8->string body)))
        #f
        #f
        http-type
        generate-fn))))

(define (generate-masto-page-prev mastoApp page)
  (let ([prevURL     (masto-page-url-prev    page)]
        [http-type   (masto-page-http-call   page)]
        [prevPage    (masto-page-prev        page)]
        [generate-fn (masto-page-generate-fn page)])
    (cond
     [prevPage      prevPage]
     [(not prevURL) #f]
     [else          (let ([newPage (generate-masto-page mastoApp http-type
                                                        prevURL  generate-fn)])
                      (if (and
                            (masto-page-url-prev newPage)
                            (masto-page-url-next newPage)
                            (not (null? (masto-page-objects newPage))))
                          (begin
                            (masto-page-next-set! newPage page)
                            (masto-page-prev-set! page newPage)

                            newPage)
                        #f))])))

(define (generate-masto-page-next mastoApp page)
  (let ([nextURL     (masto-page-url-next    page)]
        [http-type   (masto-page-http-call   page)]
        [nextPage    (masto-page-next        page)]
        [generate-fn (masto-page-generate-fn page)])
    (cond
     [nextPage      nextPage]
     [(not nextURL) #f]
     [else          (let ([newPage (generate-masto-page mastoApp http-type
                                                        nextURL  generate-fn)])
                      (if (and
                            (masto-page-url-prev newPage)
                            (masto-page-url-next newPage)
                            (not (null? (masto-page-objects newPage))))
                          (begin
                            (masto-page-prev-set! newPage page)
                            (masto-page-next-set! page newPage)

                            newPage)
                        #f))])))



(define-record-type <mastodon-emoji>
  (make-masto-emoji shortcode staticURL url visibleInPicker)
  masto-emoji?
  (shortcode       masto-emoji-shortcode         masto-emoji-shortcode-set!)
  (staticURL       masto-emoji-static-url        masto-emoji-static-url-set!)
  (url             masto-emoji-url               masto-emoji-url-set!)
  (visibleInPicker masto-emoji-visible-in-picker masto-emoji-visible-in-picker-set!))

(define (generate-masto-emoji emoji)
  (make-masto-emoji
    (assoc-ref emoji "shortcode")
    (string->uri (assoc-ref emoji "url"))
    (string->uri (assoc-ref emoji "static_url"))
    (assoc-ref emoji "visible_in_picker")))

(define (generate-masto-emoji-array emojis)
  (vector-fold (lambda (index finalList emoji)
                 (cons (generate-masto-emoji emoji) finalList)) '() emojis))



(define-record-type <mastodon-field>
  (make-masto-field name value verifiedAt)
  masto-field?
  (name       masto-field-name        masto-field-name-set!)
  (value      masto-field-value       masto-field-value-set!)
  (verifiedAt masto-field-verified-at masto-field-verified-at-set!))

(define-record-type <mastodon-account>
  (make-masto-account id             username       acct
                      displayName    locked         createdAt
                      followersCount followingCount statusesCount
                      note           url            avatar
                      avatarStatic   header         headerStatic
                      emojis         moved          fields        bot)
  masto-account?
  (id             masto-account-id             masto-account-id-set!)
  (username       masto-account-username       masto-account-username-set!)
  (acct           masto-account-acct           masto-account-acct-set!)
  (displayName    masto-account-displayName    masto-account-displayName-set!)
  (locked         masto-account-locked         masto-account-locked-set!)
  (createdAt      masto-account-createdAt      masto-account-createdAt-set!)
  (followersCount masto-account-followersCount masto-account-followersCount-set!)
  (followingCount masto-account-followingCount masto-account-followingCount-set!)
  (statusesCount  masto-account-statusesCount  masto-account-statusesCount-set!)
  (note           masto-account-note           masto-account-note-set!)
  (url            masto-account-url            masto-account-url-set!)
  (avatar         masto-account-avatar         masto-account-avatar-set!)
  (avatarStatic   masto-account-avatarStatic   masto-account-avatarStatic-set!)
  (header         masto-account-header         masto-account-header-set!)
  (headerStatic   masto-account-headerStatic   masto-account-headerStatic-set!)
  (emojis         masto-account-emojis         masto-account-emojis-set!)
  (moved          masto-account-moved          masto-account-moved-set!)
  (fields         masto-account-fields         masto-account-fields-set!)
  (bot            masto-account-bot            masto-account-bot-set!))

(define (generate-masto-account account)
  (make-masto-account
    (assoc-ref account "id")
    (assoc-ref account "username")
    (assoc-ref account "acct")
    (assoc-ref account "display_name")
    (assoc-ref account "locked")
    (string->date
      (assoc-ref account "created_at")
      (if (or
            (> (string->number (substring (version) 0 3)) 2.2)
            (and
              (string=? (substring (version) 0 4) "2.2.")
              (> (string->number (substring (version) 4)) 4)))
          "~Y-~m-~dT~H:~M:~S.~N~z"
        "~Y-~m-~dT~H:~M:~S.~z"))
    (assoc-ref account "followers_count")
    (assoc-ref account "following_count")
    (assoc-ref account "statuses_count")
    (assoc-ref account "note")
    (string->uri (assoc-ref account "url"))
    (string->uri (assoc-ref account "avatar"))
    (string->uri (assoc-ref account "avatar_static"))
    (string->uri (assoc-ref account "header"))
    (string->uri (assoc-ref account "header_static"))
    (generate-masto-emoji-array (assoc-ref account "emojis"))
    (if-let ([moved (assoc-ref account "moved")])
        (generate-masto-account moved)
      #f)
    (if-let ([fields (assoc-ref account "fields")])
        (vector-fold
          (lambda (i finalFieldsList field)
            (cons
              (make-masto-field
                (assoc-ref field "name")
                (assoc-ref field "value")
                (assoc-ref field "verified_at"))
              finalFieldsList))
          '()
          fields)
      #f)
    (if-let ([bot (assoc-ref account "bot")]) bot #f)))

(define (generate-masto-account-array accounts)
  (vector-fold
    (lambda (index finalList account)
      (cons (generate-masto-account account) finalList))
    '()
    accounts))



(define-record-type <mastodon-relationship>
  (make-masto-relationship id        following      followedBy
                           blocking  muting         mutingNotifications
                           requested domainBlocking showingReblogs      endorsed)
  masto-relationship?
  (id                  masto-relationship-id                   masto-relationship-id-set!)
  (following           masto-relationship-following            masto-relationship-following-set!)
  (followedBy          masto-relationship-followed-by          masto-relationship-followed-by-set!)
  (blocking            masto-relationship-blocking             masto-relationship-blocking-set!)
  (muting              masto-relationship-muting               masto-relationship-muting-set!)
  (mutingNotifications masto-relationship-muting-notifications masto-relationship-muting-notifications-set!)
  (requested           masto-relationship-requested            masto-relationship-requested-set!)
  (domainBlocking      masto-relationship-domain-blocking      masto-relationship-domain-blocking-set!)
  (showingReblogs      masto-relationship-showing-reblogs      masto-relationship-showing-reblogs-set!)
  (endorsed            masto-relationship-endorsed             masto-relationship-endorsed-set!))

(define (generate-masto-relationship ship)
  (make-masto-relationship
    (assoc-ref ship "id")
    (assoc-ref ship "following")
    (assoc-ref ship "followed_by")
    (assoc-ref ship "blocking")
    (assoc-ref ship "muting")
    (assoc-ref ship "muting_notifications")
    (assoc-ref ship "requested")
    (assoc-ref ship "domain_blocking")
    (assoc-ref ship "showing_reblogs")
    (assoc-ref ship "endorsed")))
