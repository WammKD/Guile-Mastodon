# filters Module


<br />

# Table of Contents
1. [\<mastodon-filter\>](#mastodon-filter)
2. [masto-filter-context](#masto-filter-context)
3. [masto-filter-expires-at](#masto-filter-expires-at)
4. [masto-filter-id](#masto-filter-id)
5. [masto-filter-irreversible](#masto-filter-irreversible)
6. [masto-filter-phrase](#masto-filter-phrase)
7. [masto-filter-whole-word](#masto-filter-whole-word)
8. [masto-filter?](#masto-filter?)
9. [masto-filter-create](#masto-filter-create)
10. [masto-filter-delete](#masto-filter-delete)
11. [masto-filter-get](#masto-filter-get)
12. [masto-filter-update](#masto-filter-update)
13. [masto-filters-all](#masto-filters-all)

## \<mastodon-filter\>
#### Summary
A record object that can be returned by an API call.
#### Record Fields
> `id` <br />
> `phrase` <br />
> `context` <br />
> `expiresAt` <br />
> `irreversible` <br />
> `wholeWord` <br />

<br />

## masto-filter-context
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-filter-expires-at
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-filter-id
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-filter-irreversible
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-filter-phrase
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-filter-whole-word
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-filter?
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `obj` <br />

<br />

## masto-filter-create
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `mastoApp` <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:filter` (argument position 2) <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:phrase` (argument position 3) <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:context` (argument position 4) <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:expiresIn` (argument position 5) <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:irreversible` (argument position 6) <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:wholeWord` (argument position 7) <br />

<br />

## masto-filter-delete
#### Summary
Delete a particular filter that'd been created by the user tied to `mastoApp`.

`filterID` refers to the ID of the filter that you wish to delete.

If successful, this function will return `#t`.

Find the original documentation [here](https://docs.joinmastodon.org/methods/accounts/filters/).
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `mastoApp` <br />
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `filterID` <br />

<br />

## masto-filter-get
#### Summary
Retrieve a particular filter created by the user tied to `mastoApp`.

`filterID` refers to the ID of the filter that you wish to retrieve.

This function will return a [`<mastodon-filter>`](#mastodon-filter).

Find the original documentation [here](https://docs.joinmastodon.org/methods/accounts/filters/).
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `mastoApp` <br />
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `filterID` <br />

<br />

## masto-filter-update
#### Summary
Update a particular filter created by the user tied to `mastoApp`.

[`masto-filter-update`](#masto-filter-update) allows you to pass a
[`<mastodon-filter>`](#mastodon-filter) with `#:filter` or to provide the
details of the filter with the other remaining keywords.

if `filter` is provided, it will be used as a representation of the details of
the filter you with to update and the remaining keywords will be ignored.

`context` must be a valid filter context.

Both `phrase` and `context`, if not using `filter`, are required; all other
keyword arguments are optional.

`expiresIn` must be a SRFI-19 [date](https://www.gnu.org/software/guile/manual/html_node/SRFI_002d19-Date.html)
or [time](https://www.gnu.org/software/guile/manual/html_node/SRFI_002d19-Time.html)
object or a number representing the number of seconds until expiry; if a date
object is provided, the number of seconds from the current time will be
calculated and used.

This function will return a [`<mastodon-filter>`](#mastodon-filter)
containing the updated details.

Find the original documentation [here](https://docs.joinmastodon.org/methods/accounts/filters/).
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `mastoApp` <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:filter` (argument position 2) <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:id` (argument position 3) <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:phrase` (argument position 4) <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:context` (argument position 5) <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:expiresIn` (argument position 6) <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:irreversible` (argument position 7) <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:wholeWord` (argument position 8) <br />

<br />

## masto-filters-all
#### Summary
Retrieve all filters created by the user tied to `mastoApp`.

This function will return a list of [`<mastodon-filter>`](#mastodon-filter)s.

Find the original documentation [here](https://docs.joinmastodon.org/methods/accounts/filters/).
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `mastoApp` <br />

<br />

