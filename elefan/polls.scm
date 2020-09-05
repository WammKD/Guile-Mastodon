(define-module (elefan polls)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (elefan utils)
  #:export (masto-poll-get
            masto-poll-send-vote)
  #:re-export (<mastodon-poll-option> masto-poll-option? masto-poll-option-title
                                                         masto-poll-option-votes-count
               <mastodon-poll>        masto-poll?        masto-poll-id
                                                         masto-poll-expires-at
                                                         masto-poll-expired
                                                         masto-poll-multiple
                                                         masto-poll-votes-count
                                                         masto-poll-options
                                                         masto-poll-voted))

(define (masto-poll-get domainOrApp pollID)
  "View a a poll with the ID `pollID`.

`domainOrApp` can be the instance domain as a String or a
<mastodon-instance-application>, whose associated `domain` will be used instead.

If the parent status of the poll in question is private, you will need to use a
<mastodon-instance-application> for `domainOrApp` in order to determine if the
user has permission to view the poll.

A <mastodon-poll> is returned.

Find the original documentation [here](https://docs.joinmastodon.org/methods/statuses/polls/)."
  (generate-masto-poll
    (if (masto-instance-app? domainOrApp)
        (http 'get
          (string-append (masto-app-domain domainOrApp) "/api/v1/polls/" pollID)
          #:token (masto-app-token domainOrApp))
      (http 'get (string-append
                   (if (string-contains-ci domainOrApp "https://")
                       domainOrApp
                     (string-append/shared "https://" domainOrApp))
                   "/api/v1/polls/"
                   pollID)))))

(define (masto-poll-send-vote mastoApp pollID choices)
  "Vote in a pole with the ID `pollID` for the user tied to `mastoApp`.

`choices` are a list of integers containing the index of each poll option you
wish to vote for.

A <mastodon-poll> is returned.

Find the original documentation [here](https://docs.joinmastodon.org/methods/statuses/polls/)."
  (generate-masto-poll
    (http 'post
      (string-append (masto-app-domain mastoApp) "/api/v1/polls/"
                     pollID                      "/votes")
      #:token       (masto-app-token mastoApp)
      #:queryParams `(("choices" ,choices)))))
