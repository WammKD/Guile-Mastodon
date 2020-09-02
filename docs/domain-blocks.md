# domain-blocks Module


<br />

# Table of Contents
1. [\<mastodon-pagination-object\>](#mastodon-pagination-object)
2. [masto-block-domain](#masto-block-domain)
3. [masto-page-next](#masto-page-next)
4. [masto-page-objects](#masto-page-objects)
5. [masto-page-prev](#masto-page-prev)
6. [masto-page?](#masto-page?)
7. [masto-unblock-domain](#masto-unblock-domain)
8. [masto-domain-blocks-all](#masto-domain-blocks-all)

## \<mastodon-pagination-object\>
#### Summary
A record object that can be returned by an API call.
#### Record Fields
> `objectCollection` <br />
> `prevURL` <br />
> `prevPage` <br />
> `nextURL` <br />
> `nextPage` <br />
> `http-call` <br />
> `generate-fn` <br />

<br />

## masto-block-domain
#### Summary
Block an existing Fediverse instance for the user tied to `mastoApp`.

`domain` refers to the domain of the instance that you wish to block.

If successful, this function will return `#t`.

Find the original documentation [here](https://docs.joinmastodon.org/methods/accounts/domain_blocks/).
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `mastoApp` <br />
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `domain` <br />

<br />

## masto-page-next
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `mastoApp` <br />
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `page` <br />

<br />

## masto-page-objects
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-page-prev
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `mastoApp` <br />
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `page` <br />

<br />

## masto-page?
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `obj` <br />

<br />

## masto-unblock-domain
#### Summary
Unblock an existing Fediverse instance for the user tied to `mastoApp`.

`domain` refers to the domain of the instance that you wish to unblock.

If successful, this function will return `#t`.

Find the original documentation [here](https://docs.joinmastodon.org/methods/accounts/domain_blocks/).
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `mastoApp` <br />
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `domain` <br />

<br />

## masto-domain-blocks-all
#### Summary
Retrieve all domain blocks associated with the user tied to `mastoApp`.

If no `limit` value is provided, the value 40 is used.

A [`<mastodon-pagination-object>`](#mastodon-pagination-object) is returned,
consisting of the domains that the user has blocked, as Strings.

Find the original documentation [here](https://docs.joinmastodon.org/methods/accounts/domain_blocks/).
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `mastoApp` <br />
> ![#c5f015](https://placehold.it/15/c5f015/000000?text=+) `[limit]` <br />

<br />

