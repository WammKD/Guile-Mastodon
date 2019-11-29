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
            generate-masto-relationship))

(define-syntax generate-masto-object-helper
  (syntax-rules ()
    [(_ generate-funct alist
        (args                     ...)
        ()                            ) (apply generate-funct (list args ...))]
    [(_ generate-funct alist
        (args                     ...)
        ([key transform-funct] . rest)) (generate-masto-object-helper generate-funct alist
                                                                      (args ... (let ([value (assoc-ref alist key)])
                                                                                  (if value (transform-funct value) #f)))
                                                                      rest)]
    [(_ generate-funct alist
        (args                     ...)
        ([key]                 . rest)) (generate-masto-object-helper generate-funct alist
                                                                      (args ... (let ([value (assoc-ref alist key)])
                                                                                  (if value value                   #f)))
                                                                      rest)]))

(define-syntax generate-masto-object
  (syntax-rules ()
    [(_ generate-funct alist args ...)  (generate-masto-object-helper generate-funct alist
                                                                      ()
                                                                      (args ...))]))



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
  (generate-masto-object make-masto-emoji emoji
    ["shortcode"]
    ["url"               string->uri]
    ["static_url"        string->uri]
    ["visible_in_picker"]))

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
  (vector-fold
    (lambda (index finalList attachment)
      (cons (generate-masto-attachment attachment) finalList))
    '()
    attachments))



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
  (vector-fold
    (lambda (index finalList mention)
      (cons (generate-masto-mention mention) finalList))
    '()
    mentions))



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
  (vector-fold
    (lambda (index finalList history)
      (cons (generate-masto-history history) finalList))
    '()
    histories))



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
  (vector-fold
    (lambda (index finalList tag)
      (cons (generate-masto-tag tag) finalList))
    '()
    tags))



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
  (vector-fold
    (lambda (index finalList poll-option)
      (cons (generate-masto-poll-option poll-option) finalList))
    '()
    pollOptions))



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
                     reblog         content          createdAt
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
  (reblog             masto-status-reblog                 masto-status-reblog-set!)
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
  (vector-fold
    (lambda (index finalList status)
      (cons (generate-masto-status status) finalList))
    '()
    statuses))
