# filters Module


<br />

## masto-filter-delete
#### Summary
#f
#### Parameters
> `mastoApp` _required_ <br />
> `filterID` _required_ <br />

<br />

## masto-filter-phrase
#### Summary
#f
#### Parameters
> `s` _required_ <br />

<br />

## masto-filter-context
#### Summary
#f
#### Parameters
> `s` _required_ <br />

<br />

## masto-filter-expires-at
#### Summary
#f
#### Parameters
> `s` _required_ <br />

<br />

## masto-filter-id
#### Summary
#f
#### Parameters
> `s` _required_ <br />

<br />

## masto-filter-create
#### Summary
#f
#### Parameters
> `mastoApp` _required_ <br />
> `#:filter` _keyword_ (argument position 2) <br />
> `#:phrase` _keyword_ (argument position 3) <br />
> `#:context` _keyword_ (argument position 4) <br />
> `#:expiresIn` _keyword_ (argument position 5) <br />
> `#:irreversible` _keyword_ (argument position 6) <br />
> `#:wholeWord` _keyword_ (argument position 7) <br />

<br />

## masto-filters-all
#### Summary
#f
#### Parameters
> `mastoApp` _required_ <br />

<br />

## masto-filter-whole-word
#### Summary
#f
#### Parameters
> `s` _required_ <br />

<br />

## masto-filter-irreversible
#### Summary
#f
#### Parameters
> `s` _required_ <br />

<br />

## <mastodon-filter>
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

## masto-filter?
#### Summary
#f
#### Parameters
> `obj` _required_ <br />

<br />

## masto-filter-update
#### Summary
#f
#### Parameters
> `mastoApp` _required_ <br />
> `#:filter` _keyword_ (argument position 2) <br />
> `#:id` _keyword_ (argument position 3) <br />
> `#:phrase` _keyword_ (argument position 4) <br />
> `#:context` _keyword_ (argument position 5) <br />
> `#:expiresIn` _keyword_ (argument position 6) <br />
> `#:irreversible` _keyword_ (argument position 7) <br />
> `#:wholeWord` _keyword_ (argument position 8) <br />

<br />

## masto-filter-get
#### Summary
#f
#### Parameters
> `mastoApp` _required_ <br />
> `filterID` _required_ <br />

<br />

