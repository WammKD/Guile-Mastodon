# polls Module


<br />

## Table of Contents
1. [\<mastodon-poll-option\>](#mastodon-poll-option)
2. [\<mastodon-poll\>](#mastodon-poll)
3. [masto-poll-expired](#masto-poll-expired)
4. [masto-poll-expires-at](#masto-poll-expires-at)
5. [masto-poll-id](#masto-poll-id)
6. [masto-poll-multiple](#masto-poll-multiple)
7. [masto-poll-option-title](#masto-poll-option-title)
8. [masto-poll-option-votes-count](#masto-poll-option-votes-count)
9. [masto-poll-option?](#masto-poll-option?)
10. [masto-poll-options](#masto-poll-options)
11. [masto-poll-voted](#masto-poll-voted)
12. [masto-poll-votes-count](#masto-poll-votes-count)
13. [masto-poll?](#masto-poll?)
14. [masto-poll-get](#masto-poll-get)
15. [masto-poll-send-vote](#masto-poll-send-vote)


<br />

### \<mastodon-poll-option\>
##### Summary
A record object that can be returned by an API call.
##### Record Fields
> `title` <br />
> `votesCount` <br />

<br />

### \<mastodon-poll\>
##### Summary
A record object that can be returned by an API call.
##### Record Fields
> `id` <br />
> `expiresAt` <br />
> `expired` <br />
> `multiple` <br />
> `votesCount` <br />
> `options` <br />
> `voted` <br />

<br />

### masto-poll-expired
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-poll-expires-at
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-poll-id
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-poll-multiple
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-poll-option-title
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-poll-option-votes-count
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-poll-option?
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `obj` <br />

<br />

### masto-poll-options
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-poll-voted
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-poll-votes-count
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-poll?
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `obj` <br />

<br />

### masto-poll-get
##### Summary
View a a poll with the ID `pollID`.

`domainOrApp` can be the instance domain as a String or a
[`<mastodon-instance-application>`](auth.md#mastodon-instance-application), whose associated `domain` will be used instead.

If the parent status of the poll in question is private, you will need to use a
[`<mastodon-instance-application>`](auth.md#mastodon-instance-application) for `domainOrApp` in order to determine if the
user has permission to view the poll.

A [`<mastodon-poll>`](#mastodon-poll) is returned.

Find the original documentation [here](https://docs.joinmastodon.org/methods/statuses/polls/).
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `domainOrApp` <br />
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `pollID` <br />

<br />

### masto-poll-send-vote
##### Summary
Vote in a pole with the ID `pollID` for the user tied to `mastoApp`.

`choices` are a list of integers containing the index of each poll option you
wish to vote for.

A [`<mastodon-poll>`](#mastodon-poll) is returned.

Find the original documentation [here](https://docs.joinmastodon.org/methods/statuses/polls/).
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `mastoApp` <br />
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `pollID` <br />
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `choices` <br />

<br />

