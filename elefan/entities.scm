(define-module (elefan entities)
  #:use-module (elefan auth)
  #:use-module (elefan enums)
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
                                                     masto-page-url-prev masto-page-internal-prev
                                                     masto-page-url-next masto-page-internal-next
            generate-masto-page
            masto-page-prev
            masto-page-next
            <mastodon-emoji>   masto-emoji?   masto-emoji-shortcode masto-emoji-static-url
                                              masto-emoji-url       masto-emoji-visible-in-picker
            generate-masto-emoji
            generate-masto-emoji-array
            <mastodon-field>   masto-field?   masto-field-name        masto-field-value
                                              masto-field-verified-at
            <mastodon-account> masto-account? masto-account-id              masto-account-username
                                              masto-account-acct            masto-account-display-name
                                              masto-account-locked          masto-account-created-at
                                              masto-account-followers-count masto-account-following-count
                                              masto-account-statuses-count  masto-account-note
                                              masto-account-url             masto-account-avatar
                                              masto-account-avatar-static   masto-account-header
                                              masto-account-header-static   masto-account-emojis
                                              masto-account-moved           masto-account-fields
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
            generate-masto-relationship
            <mastodon-meta-subtree> masto-meta-subtree? masto-meta-subtree-width      masto-meta-subtree-height
                                                        masto-meta-subtree-size       masto-meta-subtree-aspect
                                                        masto-meta-subtree-frame-rate masto-meta-subtree-duration
                                                        masto-meta-subtree-bitrate
            generate-masto-meta-subtree
            <mastodon-meta-focus>   masto-meta-focus?   masto-meta-focus-x            masto-meta-focus-y
            generate-masto-meta-focus
            <mastodon-meta>         masto-meta?         masto-meta-small              masto-meta-original
                                                        masto-meta-focus
            generate-masto-meta
            <mastodon-attachment>   masto-attachment?   masto-attachment-id           masto-attachment-type
                                                        masto-attachment-url          masto-attachment-remote-url
                                                        masto-attachment-preview-url  masto-attachment-text-url
                                                        masto-attachment-meta         masto-attachment-description
                                                        masto-attachment-blurhash
            generate-masto-attachment
            generate-masto-attachment-array
            <mastodon-mention> masto-mention? masto-mention-url       masto-mention-username
                                              masto-mention-acct      masto-mention-id
            generate-masto-mention
            generate-masto-mention-array
            <mastodon-history> masto-history? masto-history-day       masto-history-uses
                                              masto-history-accounts
            generate-masto-history
            generate-masto-history-array
            <mastodon-tag>     masto-tag?     masto-tag-name          masto-tag-url
                                              masto-tag-history
            generate-masto-tag
            generate-masto-tag-array
            <mastodon-card>    masto-card?    masto-card-url          masto-card-title
                                              masto-card-description  masto-card-image
                                              masto-card-type         masto-card-author-name
                                              masto-card-author-url   masto-card-provider-name
                                              masto-card-provider-url masto-card-html
                                              masto-card-width        masto-card-height
            generate-masto-card
            <mastodon-poll-option> masto-poll-option? masto-poll-option-title masto-poll-option-votes-count
            generate-masto-poll-option
            generate-masto-poll-option-array
            <mastodon-poll> masto-poll? masto-poll-id          masto-poll-expires-at
                                        masto-poll-expired     masto-poll-multiple
                                        masto-poll-votes-count masto-poll-options    masto-poll-voted
            generate-masto-poll
            <mastodon-application> masto-application? masto-application-name masto-application-website
            generate-masto-application
            <mastodon-status> masto-status? masto-status-id              masto-status-uri
                                            masto-status-url             masto-status-account
                                            masto-status-in-reply-to-id  masto-status-in-reply-to-account-id
                                            masto-status-reblog-status   masto-status-content
                                            masto-status-created-at      masto-status-emojis
                                            masto-status-replies-count   masto-status-reblogs-count
                                            masto-status-favorites-count masto-status-reblogged
                                            masto-status-favorited       masto-status-muted
                                            masto-status-sensitive       masto-status-spoiler-text
                                            masto-status-visibility      masto-status-media-attachments
                                            masto-status-mentions        masto-status-tags
                                            masto-status-card            masto-status-poll
                                            masto-status-application     masto-status-language
                                            masto-status-pinned
            generate-masto-status
            generate-masto-status-array
            <mastodon-filter> masto-filter? masto-filter-id                masto-filter-phrase
                                                                           masto-filter-phrase-set!
                                            masto-filter-context           masto-filter-expires-at
                                            masto-filter-context-set!      masto-filter-expires-at-set!
                                            masto-filter-irreversible      masto-filter-whole-word
                                            masto-filter-irreversible-set! masto-filter-whole-word-set!
            generate-masto-filter
            <mastodon-instance-urls> masto-instance-urls? masto-instance-urls-streaming-api
            generate-masto-instance-urls
            <mastodon-instance-stats> masto-instance-stats? masto-instance-stats-user-count
                                                            masto-instance-stats-status-count
                                                            masto-instance-stats-domain-count
            generate-masto-instance-stats
            <mastodon-instance> masto-instance? masto-instance-uri               masto-instance-title
                                                masto-instance-short-description masto-instance-description
                                                masto-instance-email             masto-instance-version
                                                masto-instance-thumbnail         masto-instance-urls
                                                masto-instance-stats             masto-instance-languages
                                                masto-instance-contact-account
            generate-masto-instance
            <mastodon-list> masto-list? masto-list-id masto-list-title
            generate-masto-list
            generate-masto-list-array
            <mastodon-notification> masto-notification? masto-notification-id        masto-notification-type
                                                        masto-notification-create-at masto-notification-account
                                                        masto-notification-status
            generate-masto-notification
            generate-masto-notification-array
            <mastodon-web-push-subscription-alerts> masto-web-push-subscription-alerts? masto-web-push-subscription-alerts-poll
                                                                                        masto-web-push-subscription-alerts-mention
                                                                                        masto-web-push-subscription-alerts-reblog
                                                                                        masto-web-push-subscription-alerts-favorite
                                                                                        masto-web-push-subscription-alerts-follow
            generate-masto-web-push-subscription-alerts
            <mastodon-web-push-subscription> masto-web-push-subscription? masto-web-push-subscription-id
                                                                          masto-web-push-subscription-endpoint
                                                                          masto-web-push-subscription-server-key
                                                                          masto-web-push-subscription-alerts
            generate-masto-web-push-subscription
            <mastodon-scheduled-status-params> masto-scheduled-status-params? masto-scheduled-status-params-text
                                                                              masto-scheduled-status-params-in-reply-to-id
                                                                              masto-scheduled-status-params-media-ids
                                                                              masto-scheduled-status-params-sensitive
                                                                              masto-scheduled-status-params-spoiler-text
                                                                              masto-scheduled-status-params-visibility
                                                                              masto-scheduled-status-params-scheduled-at
                                                                              masto-scheduled-status-params-application-id
            generate-masto-scheduled-status-params
            <mastodon-scheduled-status> masto-scheduled-status? masto-scheduled-status-id
                                                                masto-scheduled-status-scheduled-at
                                                                masto-scheduled-status-params
                                                                masto-scheduled-status-media-attachments
            generate-masto-scheduled-status
            generate-masto-scheduled-status-array
            <mastodon-results> masto-results? masto-results-accounts masto-results-statuses masto-results-hashtags
            generate-masto-results
            <mastodon-context> masto-context? masto-context-ancestors masto-context-descendants
            generate-masto-context
            <mastodon-conversation> masto-convo? masto-convo-id          masto-convo-accounts
                                                 masto-convo-last-status masto-convo-unread
            generate-masto-convo
            generate-masto-convo-array))

(define-syntax generate-masto-object-helper
  (syntax-rules ()
    [(_ generate-funct alist
        (args                     ...)
        ()                            ) (apply generate-funct (list args ...))]
    [(_ generate-funct alist
        (args                     ...)
        ([key transform-funct] . rest)) (generate-masto-object-helper generate-funct alist
                                                                      (args ... (let ([value (assoc-ref alist key)])
                                                                                  (if (and value (not (eq? value 'null)))
                                                                                      (transform-funct value)
                                                                                    #f)))
                                                                      rest)]
    [(_ generate-funct alist
        (args                     ...)
        ([key]                 . rest)) (generate-masto-object-helper generate-funct alist
                                                                      (args ... (let ([value (assoc-ref alist key)])
                                                                                  (if (and value (not (eq? value 'null))) value #f)))
                                                                      rest)]))

(define-syntax generate-masto-object
  (syntax-rules ()
    [(_ generate-funct alist args ...)  (generate-masto-object-helper generate-funct alist
                                                                      ()
                                                                      (args ...))]))



(define (generate-masto-object-array objects generate-fn)
  (vector-fold (lambda (index finalList object)
                 (cons (generate-fn object) finalList)) '() objects))



(define (masto-string->date str)
  (let ([strLen (string-length str)])
    (string->date
      (if (char=? (char-upcase (string-ref str (1- strLen))) #\Z)
          str
        (string-append
          (substring str 0 (- strLen 3))
          (substring str (- strLen 2))))
      (if (or
            (> (string->number (substring (version) 0 3)) 2.2)
            (and
              (string=? (substring (version) 0 4) "2.2.")
              (> (string->number (substring (version) 4)) 4)))
          "~Y-~m-~dT~H:~M:~S.~N~z"
        "~Y-~m-~dT~H:~M:~S.~z"))))



(define-record-type <mastodon-pagination-object>
  (make-masto-page objectCollection prevURL nextURL http-call generate-fn)
  masto-page?
  (objectCollection masto-page-objects       masto-page-objects-set!)
  (prevURL          masto-page-url-prev      masto-page-url-prev-set!)
  (prevPage         masto-page-internal-prev masto-page-internal-prev-set!)
  (nextURL          masto-page-url-next      masto-page-url-next-set!)
  (nextPage         masto-page-internal-next masto-page-internal-next-set!)
  (http-call        masto-page-http-call     masto-page-http-call-set!)
  (generate-fn      masto-page-generate-fn   masto-page-generate-fn-set!))

(define (generate-masto-page mastoApp type url generate-fn)
  (let ([http-type (assoc-ref `((get    . ,http-get)
                                (post   . ,http-post)
                                (put    . ,http-put)
                                (delete . ,http-delete)) type)])
    (receive (header body)
        (if (not mastoApp)
            (http-type url)
          (http-type url #:headers `((Authorization . ,(string-append
                                                         "Bearer "
                                                         (masto-app-token mastoApp))))))
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
          generate-fn)))))

(define (masto-page-prev mastoApp page)
  (let ([prevURL     (masto-page-url-prev      page)]
        [http-type   (masto-page-http-call     page)]
        [prevPage    (masto-page-internal-prev page)]
        [generate-fn (masto-page-generate-fn   page)])
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
                            (masto-page-internal-next-set! newPage page)
                            (masto-page-internal-prev-set! page newPage)

                            newPage)
                        #f))])))

(define (masto-page-next mastoApp page)
  (let ([nextURL     (masto-page-url-next      page)]
        [http-type   (masto-page-http-call     page)]
        [nextPage    (masto-page-internal-next page)]
        [generate-fn (masto-page-generate-fn   page)])
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
                            (masto-page-internal-prev-set! newPage page)
                            (masto-page-internal-next-set! page newPage)

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
  (generate-masto-object make-masto-emoji emoji
    ["shortcode"]
    ["url"               string->uri]
    ["static_url"        string->uri]
    ["visible_in_picker"]))

(define (generate-masto-emoji-array emojis)
  (generate-masto-object-array emojis generate-masto-emoji))



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
  (id             masto-account-id              masto-account-id-set!)
  (username       masto-account-username        masto-account-username-set!)
  (acct           masto-account-acct            masto-account-acct-set!)
  (displayName    masto-account-display-name    masto-account-display-name-set!)
  (locked         masto-account-locked          masto-account-locked-set!)
  (createdAt      masto-account-created-at      masto-account-created-at-set!)
  (followersCount masto-account-followers-count masto-account-followers-count-set!)
  (followingCount masto-account-following-count masto-account-following-count-set!)
  (statusesCount  masto-account-statuses-count  masto-account-statuses-count-set!)
  (note           masto-account-note            masto-account-note-set!)
  (url            masto-account-url             masto-account-url-set!)
  (avatar         masto-account-avatar          masto-account-avatar-set!)
  (avatarStatic   masto-account-avatar-static   masto-account-avatar-static-set!)
  (header         masto-account-header          masto-account-header-set!)
  (headerStatic   masto-account-header-static   masto-account-header-static-set!)
  (emojis         masto-account-emojis          masto-account-emojis-set!)
  (moved          masto-account-moved           masto-account-moved-set!)
  (fields         masto-account-fields          masto-account-fields-set!)
  (bot            masto-account-bot             masto-account-bot-set!))

(define (generate-masto-account account)
  (generate-masto-object make-masto-account account
    ["id"]
    ["username"]
    ["acct"]
    ["display_name"]
    ["locked"]
    ["created_at"      masto-string->date]
    ["followers_count"]
    ["following_count"]
    ["statuses_count"]
    ["note"]
    ["url"             string->uri]
    ["avatar"          string->uri]
    ["avatar_static"   string->uri]
    ["header"          string->uri]
    ["header_static"   string->uri]
    ["emojis"          generate-masto-emoji-array]
    ["moved"           generate-masto-account]
    ["fields"          (cut
                         vector-fold
                          (lambda (i finalFieldsList field)
                            (cons
                              (generate-masto-object make-masto-field field
                                ["name"]
                                ["value"]
                                ["verified_at" masto-string->date])
                              finalFieldsList))
                          '()
                          <>)]
    ["bot"]))

(define (generate-masto-account-array accounts)
  (generate-masto-object-array accounts generate-masto-account))



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
  (generate-masto-object make-masto-relationship ship
    ["id"]        ["following"]       ["followed_by"]
    ["blocking"]  ["muting"]          ["muting_notifications"]
    ["requested"] ["domain_blocking"] ["showing_reblogs"]      ["endorsed"]))



(define-record-type <mastodon-meta-subtree>
  (make-masto-meta-subtree width height size aspect frameRate duration bitrate)
  masto-meta-subtree?
  (width     masto-meta-subtree-width      masto-meta-subtree-width-set!)
  (height    masto-meta-subtree-height     masto-meta-subtree-height-set!)
  (size      masto-meta-subtree-size       masto-meta-subtree-size-set!)
  (aspect    masto-meta-subtree-aspect     masto-meta-subtree-aspect-set!)
  (frameRate masto-meta-subtree-frame-rate masto-meta-subtree-frame-rate-set!)
  (duration  masto-meta-subtree-duration   masto-meta-subtree-duration-set!)
  (bitrate   masto-meta-subtree-bitrate    masto-meta-subtree-bitrate-set!))

(define (generate-masto-meta-subtree subtree)
  (generate-masto-object make-masto-meta-subtree subtree
    ["width"]  ["height"]     ["size"]
    ["aspect"] ["frame_rate"] ["duration"] ["bitrate"]))



(define-record-type <mastodon-meta-focus>
  (make-masto-meta-focus x y)
  masto-meta-focus?
  (x masto-meta-focus-x masto-meta-focus-x-set!)
  (y masto-meta-focus-y masto-meta-focus-y-set!))

(define (generate-masto-meta-focus focus)
  (generate-masto-object make-masto-meta-focus focus ["x"] ["y"]))



(define-record-type <mastodon-meta>
  (make-masto-meta small original focus)
  masto-meta?
  (small    masto-meta-small    masto-meta-small-set!)
  (original masto-meta-original masto-meta-original-set!)
  (focus    masto-meta-focus    masto-meta-focus-set!))

(define (generate-masto-meta meta)
  (generate-masto-object make-masto-meta meta
    ["small"    generate-masto-meta-subtree]
    ["original" generate-masto-meta-subtree]
    ["focus"    generate-masto-meta-focus]))



(define-record-type <mastodon-attachment>
  (make-masto-attachment id         type    url  remoteURL
                         previewURL textURL meta description blurhash)
  masto-attachment?
  (id          masto-attachment-id          masto-attachment-id-set!)
  (type        masto-attachment-type        masto-attachment-type-set!)
  (url         masto-attachment-url         masto-attachment-url-set!)
  (remoteURL   masto-attachment-remote-url  masto-attachment-remote-url-set!)
  (previewURL  masto-attachment-preview-url masto-attachment-preview-url-set!)
  (textURL     masto-attachment-text-url    masto-attachment-text-url-set!)
  (meta        masto-attachment-meta        masto-attachment-meta-set!)
  (description masto-attachment-description masto-attachment-description-set!)
  (blurhash    masto-attachment-blurhash    masto-attachment-blurhash-set!))

(define (generate-masto-attachment attachment)
  (generate-masto-object make-masto-attachment attachment
    ["id"]                              ["type"        (cut enum-value-of <> ATTACHMENT_TYPE_ENUM)]
    ["url"         string->uri]         ["remote_url"  string->uri]
    ["preview_url" string->uri]         ["text_url"    string->uri]
    ["meta"        generate-masto-meta] ["description"]
    ["blurhash"]))

(define (generate-masto-attachment-array attachments)
  (generate-masto-object-array attachments generate-masto-attachment))



(define-record-type <mastodon-mention>
  (make-masto-mention url username acct id)
  masto-mention?
  (url      masto-mention-url      masto-mention-url-set!)
  (username masto-mention-username masto-mention-username-set!)
  (acct     masto-mention-acct     masto-mention-acct-set!)
  (id       masto-mention-id       masto-mention-id-set!))

(define (generate-masto-mention mention)
  (generate-masto-object make-masto-mention mention
    ["url" string->uri] ["username"] ["acct"] ["id"]))

(define (generate-masto-mention-array mentions)
  (generate-masto-object-array mentions generate-masto-mention))



(define-record-type <mastodon-history>
  (make-masto-history day uses accounts)
  masto-history?
  (day      masto-history-day      masto-history-day-set!)
  (uses     masto-history-uses     masto-history-uses-set!)
  (accounts masto-history-accounts masto-history-accounts-set!))

(define (generate-masto-history history)
  (make-masto-history
    (if-let ([day (assoc-ref history "day")])
        (make-time time-utc 0 (string->number day))
      #f)
    (if-let ([uses     (assoc-ref history "uses"    )]) uses     #f)
    (if-let ([accounts (assoc-ref history "accounts")]) accounts #f)))

(define (generate-masto-history-array histories)
  (generate-masto-object-array histories generate-masto-history))



(define-record-type <mastodon-tag>
  (make-masto-tag name url history)
  masto-tag?
  (name    masto-tag-name    masto-tag-name-set!)
  (url     masto-tag-url     masto-tag-url-set!)
  (history masto-tag-history masto-tag-history-set!))

(define (generate-masto-tag tag)
  (generate-masto-object make-masto-tag tag
    ["name"]
    ["url"     string->uri]
    ["history" generate-masto-history-array]))

(define (generate-masto-tag-array tags)
  (generate-masto-object-array tags generate-masto-tag))



(define-record-type <mastodon-card>
  (make-masto-card url       title        description image type  authorName
                   authorURL providerName providerURL html  width height)
  masto-card?
  (url          masto-card-url           masto-card-url-set!)
  (title        masto-card-title         masto-card-title-set!)
  (description  masto-card-description   masto-card-description-set!)
  (image        masto-card-image         masto-card-image-set!)
  (type         masto-card-type          masto-card-type-set!)
  (authorName   masto-card-author-name   masto-card-author-name-set!)
  (authorURL    masto-card-author-url    masto-card-author-url-set!)
  (providerName masto-card-provider-name masto-card-provider-name-set!)
  (providerURL  masto-card-provider-url  masto-card-provider-url-set!)
  (html         masto-card-html          masto-card-html-set!)
  (width        masto-card-width         masto-card-width-set!)
  (height       masto-card-height        masto-card-height-set!))

(define (generate-masto-card card)
  (generate-masto-object make-masto-card card
    ["url"           string->uri]
    ["title"]
    ["description"]
    ["image"         string->uri]
    ["type"          (cut enum-value-of <> CARD_TYPE_ENUM)]
    ["author_name"]
    ["author_url"    string->uri]
    ["provider_name"]
    ["provider_url"  string->uri]
    ["html"]
    ["width"]
    ["height"]))



(define-record-type <mastodon-poll-option>
  (make-masto-poll-option title votesCount)
  masto-poll-option?
  (title      masto-poll-option-title       masto-poll-option-title-set!)
  (votesCount masto-poll-option-votes-count masto-poll-option-votes-count-set!))

(define (generate-masto-poll-option pollOption)
  (generate-masto-object make-masto-poll-option pollOption
    ["title"]
    ["votes_count"]))

(define (generate-masto-poll-option-array pollOptions)
  (generate-masto-object-array pollOptions generate-masto-poll-option))



(define-record-type <mastodon-poll>
  (make-masto-poll id expiresAt expired multiple votesCount options voted)
  masto-poll?
  (id         masto-poll-id          masto-poll-id-set!)
  (expiresAt  masto-poll-expires-at  masto-poll-expires-at-set!)
  (expired    masto-poll-expired     masto-poll-expired-set!)
  (multiple   masto-poll-multiple    masto-poll-multiple-set!)
  (votesCount masto-poll-votes-count masto-poll-votes-count-set!)
  (options    masto-poll-options     masto-poll-options-set!)
  (voted      masto-poll-voted       masto-poll-voted-set!))

(define (generate-masto-poll poll)
  (generate-masto-object make-masto-poll poll
    ["id"]          ["expires_at" masto-string->date]
    ["expired"]     ["multiple"]
    ["votes_count"] ["options"    generate-masto-poll-option-array] ["voted"]))



(define-record-type <mastodon-application>
  (make-masto-application name website)
  masto-application?
  (name    masto-application-name    masto-application-name-set!)
  (website masto-application-website masto-application-website-set!))

(define (generate-masto-application application)
  (generate-masto-object make-masto-application application
    ["name"]
    ["website" string->uri]))



(define-record-type <mastodon-status>
  (make-masto-status id             uri              url
                     account        inReplyToID      inReplyToAccountID
                     reblogStatus   content          createdAt
                     emojis         repliesCount     reblogsCount
                     favoritesCount reblogged        favorited
                     muted          sensitive        spoilerText
                     visibility     mediaAttachments mentions
                     tags           card             poll
                     application    language         pinned)
  masto-status?
  (id                 masto-status-id                     masto-status-id-set!)
  (uri                masto-status-uri                    masto-status-uri-set!)
  (url                masto-status-url                    masto-status-url-set!)
  (account            masto-status-account                masto-status-account-set!)
  (inReplyToID        masto-status-in-reply-to-id         masto-status-in-reply-to-id-set!)
  (inReplyToAccountID masto-status-in-reply-to-account-id masto-status-in-reply-to-account-id-set!)
  (reblogStatus       masto-status-reblog-status          masto-status-reblog-status-set!)
  (content            masto-status-content                masto-status-content-set!)
  (createdAt          masto-status-created-at             masto-status-created-at-set!)
  (emojis             masto-status-emojis                 masto-status-emojis-set!)
  (repliesCount       masto-status-replies-count          masto-status-replies-count-set!)
  (reblogsCount       masto-status-reblogs-count          masto-status-reblogs-count-set!)
  (favoritesCount     masto-status-favorites-count        masto-status-favorites-count-set!)
  (reblogged          masto-status-reblogged              masto-status-reblogged-set!)
  (favorited          masto-status-favorited              masto-status-favorited-set!)
  (muted              masto-status-muted                  masto-status-muted-set!)
  (sensitive          masto-status-sensitive              masto-status-sensitive-set!)
  (spoilerText        masto-status-spoiler-text           masto-status-spoiler-text-set!)
  (visibility         masto-status-visibility             masto-status-visibility-set!)
  (mediaAttachments   masto-status-media-attachments      masto-status-media-attachments-set!)
  (mentions           masto-status-mentions               masto-status-mentions-set!)
  (tags               masto-status-tags                   masto-status-tags-set!)
  (card               masto-status-card                   masto-status-card-set!)
  (poll               masto-status-poll                   masto-status-poll-set!)
  (application        masto-status-application            masto-status-application-set!)
  (language           masto-status-language               masto-status-language-set!)
  (pinned             masto-status-pinned                 masto-status-pinned-set!))

(define (generate-masto-status status)
  (generate-masto-object make-masto-status status
    ["id"]
    ["uri"]
    ["url"                    string->uri]
    ["account"                generate-masto-account]
    ["in_reply_to_id"]
    ["in_reply_to_account_id"]
    ["reblog"                 generate-masto-status]
    ["content"]
    ["created_at"             masto-string->date]
    ["emojis"                 generate-masto-emoji-array]
    ["replies_count"]
    ["reblogs_count"]
    ["favourites_count"]
    ["reblogged"]
    ["favourited"]
    ["muted"]
    ["sensitive"]
    ["spoiler_text"]
    ["visibility"             (cut enum-value-of <> STATUS_VISIBILITY_ENUM)]
    ["media_attachments"      generate-masto-attachment-array]
    ["mentions"               generate-masto-mention-array]
    ["tags"                   generate-masto-tag-array]
    ["card"                   generate-masto-card]
    ["poll"                   generate-masto-poll]
    ["application"            generate-masto-application]
    ["language"]
    ["pinned"]))

(define (generate-masto-status-array statuses)
  (generate-masto-object-array statuses generate-masto-status))



(define-record-type <mastodon-filter>
  (make-masto-filter id phrase context expiresAt irreversible wholeWord)
  masto-filter?
  (id           masto-filter-id           masto-filter-id-set!)
  (phrase       masto-filter-phrase       masto-filter-phrase-set!)
  (context      masto-filter-context      masto-filter-context-set!)
  (expiresAt    masto-filter-expires-at   masto-filter-expires-at-set!)
  (irreversible masto-filter-irreversible masto-filter-irreversible-set!)
  (wholeWord    masto-filter-whole-word   masto-filter-whole-word-set!))

(define (generate-masto-filter filter)
  (generate-masto-object make-masto-filter filter
    ["id"]
    ["phrase"]
    ["context"      (cut enum-value-of <> FILTER_CONTEXT_ENUM)]
    ["expires_at"   masto-string->date]
    ["irreversible"]
    ["whole_word"]))



(define-record-type <mastodon-instance-urls>
  (make-masto-instance-urls streamingAPI)
  masto-instance-urls?
  (streamingAPI masto-instance-urls-streaming-api masto-instance-urls-streaming-api-set!))

(define (generate-masto-instance-urls urls)
  (generate-masto-object make-masto-instance-urls urls
    ["streaming_api" string->uri]))



(define-record-type <mastodon-instance-stats>
  (make-masto-instance-stats userCount statusCount domainCount)
  masto-instance-stats?
  (  userCount masto-instance-stats-user-count   masto-instance-stats-user-count-set!)
  (statusCount masto-instance-stats-status-count masto-instance-stats-status-count-set!)
  (domainCount masto-instance-stats-domain-count masto-instance-stats-domain-count-set!))

(define (generate-masto-instance-stats stats)
  (generate-masto-object make-masto-instance-stats stats
    ["user_count"] ["status_count"] ["domain_count"]))



(define-record-type <mastodon-instance>
  (make-masto-instance uri   title     shortDescription description
                       email version   thumbnail        urls
                       stats languages contactAccount)
  masto-instance?
  (uri              masto-instance-uri               masto-instance-uri-set!)
  (title            masto-instance-title             masto-instance-title-set!)
  (shortDescription masto-instance-short-description masto-instance-short-description-set!)
  (description      masto-instance-description       masto-instance-description-set!)
  (email            masto-instance-email             masto-instance-email-set!)
  (version          masto-instance-version           masto-instance-version-set!)
  (thumbnail        masto-instance-thumbnail         masto-instance-thumbnail-set!)
  (urls             masto-instance-urls              masto-instance-urls-set!)
  (stats            masto-instance-stats             masto-instance-stats-set!)
  (languages        masto-instance-languages         masto-instance-languages-set!)
  (contactAccount   masto-instance-contact-account   masto-instance-contact-account-set!))

(define (generate-masto-instance instance)
  (generate-masto-object make-masto-instance instance
    ["uri"]
    ["title"]
    ["short_description"]
    ["description"]
    ["email"]
    ["version"]
    ["thumbnail"         string->uri]
    ["urls"              generate-masto-instance-urls]
    ["stats"             generate-masto-instance-stats]
    ["languages"         vector->list]
    ["contact_account"   generate-masto-account]))



(define-record-type <mastodon-list>
  (make-masto-list id title)
  masto-list?
  (id    masto-list-id    masto-list-id-set!)
  (title masto-list-title masto-list-title-set!))

(define (generate-masto-list list)
  (generate-masto-object make-masto-list list
    ["id"] ["title"]))

(define (generate-masto-list-array lists)
  (generate-masto-object-array lists generate-masto-list))



(define-record-type <mastodon-notification>
  (make-masto-notification id type createdAt account status)
  masto-notification?
  (id        masto-notification-id        masto-notification-id-set!)
  (type      masto-notification-type      masto-notification-type-set!)
  (createdAt masto-notification-create-at masto-notification-created-at-set!)
  (account   masto-notification-account   masto-notification-account-set!)
  (status    masto-notification-status    masto-notification-status-set!))

(define (generate-masto-notification notification)
  (generate-masto-object make-masto-notification notification
    ["id"]
    ["type"      (cut enum-value-of <> NOTIFICATION_TYPE_ENUM)]
    ["create_at" masto-string->date]
    ["account"   generate-masto-account]
    ["status"    generate-masto-status]))

(define (generate-masto-notification-array notifications)
  (generate-masto-object-array notifications generate-masto-notification))



(define-record-type <mastodon-web-push-subscription-alerts>
  (make-masto-web-push-subscription-alerts poll mention reblog favorite follow)
  masto-web-push-subscription-alerts?
  (poll     masto-web-push-subscription-alerts-poll     masto-web-push-subscription-alerts-poll-set!)
  (mention  masto-web-push-subscription-alerts-mention  masto-web-push-subscription-alerts-mention-set!)
  (reblog   masto-web-push-subscription-alerts-reblog   masto-web-push-subscription-alerts-reblog-set!)
  (favorite masto-web-push-subscription-alerts-favorite masto-web-push-subscription-alerts-favorite-set!)
  (follow   masto-web-push-subscription-alerts-follow   masto-web-push-subscription-alerts-follow-set!))

(define (generate-masto-web-push-subscription-alerts web-push-subscription-alerts)
  (generate-masto-object make-masto-web-push-subscription-alerts web-push-subscription-alerts
    ["poll"] ["mention"] ["reblog"] ["favourite"] ["follow"]))



(define-record-type <mastodon-web-push-subscription>
  (make-masto-web-push-subscription id endpoint serverKey alerts)
  masto-web-push-subscription?
  (id        masto-web-push-subscription-id         masto-web-push-subscription-id-set!)
  (endpoint  masto-web-push-subscription-endpoint   masto-web-push-subscription-endpoint-set!)
  (serverKey masto-web-push-subscription-server-key masto-web-push-subscription-server-key-set!)
  (alerts    masto-web-push-subscription-alerts     masto-web-push-subscription-alerts-set!))

(define (generate-masto-web-push-subscription web-push-subscription)
  (generate-masto-object make-masto-web-push-subscription web-push-subscription
    ["id"]         ["endpoint" string->uri]
    ["server_key"] ["alerts"   generate-masto-web-push-subscription-alerts]))



(define-record-type <mastodon-scheduled-status-params>
  (make-masto-scheduled-status-params text        inReplyToID
                                      mediaIDs    sensitive
                                      spoilerText visibility
                                      scheduledAt applicationID)
  masto-scheduled-status-params?
  (text          masto-scheduled-status-params-text           masto-scheduled-status-params-text-set!)
  (inReplyToID   masto-scheduled-status-params-in-reply-to-id masto-scheduled-status-params-in-reply-to-id-set!)
  (mediaIDs      masto-scheduled-status-params-media-ids      masto-scheduled-status-params-media-ids-set!)
  (sensitive     masto-scheduled-status-params-sensitive      masto-scheduled-status-params-sensitive-set!)
  (spoilerText   masto-scheduled-status-params-spoiler-text   masto-scheduled-status-params-spoiler-text-set!)
  (visibility    masto-scheduled-status-params-visibility     masto-scheduled-status-params-visibility-set!)
  (scheduledAt   masto-scheduled-status-params-scheduled-at   masto-scheduled-status-params-scheduled-at-set!)
  (applicationID masto-scheduled-status-params-application-id masto-scheduled-status-params-application-id-set!))

(define (generate-masto-scheduled-status-params scheduled-status-params)
  (generate-masto-object make-masto-scheduled-status-params scheduled-status-params
    ["text"]
    ["in_reply_to_id"]
    ["media_ids"      vector->list]
    ["sensitive"]
    ["spoiler_text"]
    ["visibility"     (cut enum-value-of <> STATUS_VISIBILITY_ENUM)]
    ["scheduled_at"   masto-string->date]
    ["application_id"]))



(define-record-type <mastodon-scheduled-status>
  (make-masto-scheduled-status id scheduledAt params mediaAttachments)
  masto-scheduled-status?
  (id               masto-scheduled-status-id                masto-scheduled-status-id-set!)
  (scheduledAt      masto-scheduled-status-scheduled-at      masto-scheduled-status-scheduled-at-set!)
  (params           masto-scheduled-status-params            masto-scheduled-status-params-set!)
  (mediaAttachments masto-scheduled-status-media-attachments masto-scheduled-status-media-attachments-set!))

(define (generate-masto-scheduled-status scheduled-status)
  (generate-masto-object make-masto-scheduled-status scheduled-status
    ["id"]
    ["scheduled_at"      masto-string->date]
    ["params"            generate-masto-scheduled-status-params]
    ["media_attachments" generate-masto-attachment-array]))

(define (generate-masto-scheduled-status-array scheduled-statuses)
  (generate-masto-object-array scheduled-statuses generate-masto-scheduled-status))



(define-record-type <mastodon-results>
  (make-masto-results accounts statuses hashtags)
  masto-results?
  (accounts masto-results-accounts masto-results-accounts-set!)
  (statuses masto-results-statuses masto-results-statuses-set!)
  (hashtags masto-results-hashtags masto-results-hashtags-set!))

(define (generate-masto-results results)
  (generate-masto-object make-masto-results results
    ["accounts" generate-masto-account-array]
    ["statuses" generate-masto-status-array]
    ["hashtags" generate-masto-tag-array]))



(define-record-type <mastodon-context>
  (make-masto-context ancestors descendants)
  masto-context?
  (ancestors   masto-context-ancestors   masto-context-ancestors-set!)
  (descendants masto-context-descendants masto-context-descendants-set!))

(define (generate-masto-context context)
  (generate-masto-object make-masto-context context
    ["ancestors" generate-masto-status] ["descendants" generate-masto-status]))



(define-record-type <mastodon-conversation>
  (make-masto-convo id accounts lastStatus unread)
  masto-convo?
  (id         masto-convo-id          masto-convo-id-set!)
  (accounts   masto-convo-accounts    masto-convo-accounts-set!)
  (lastStatus masto-convo-last-status masto-convo-last-status-set!)
  (unread     masto-convo-unread      masto-convo-unread-set!))

(define (generate-masto-convo convo)
  (generate-masto-object make-masto-convo convo
    ["id"]                               ["accounts" generate-masto-account-array]
    ["lastStatus" generate-masto-status] ["unread"]))

(define (generate-masto-convo-array convos)
  (generate-masto-object-array convos generate-masto-convo))
