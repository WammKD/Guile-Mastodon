# reports Module


<br />

## Table of Contents
1. [masto-report-account](#masto-report-account)


<br />

### masto-report-account
##### Summary
File a report against an account with ID `accountID` for the user tied to
`mastoApp`.

`statusIDs` are a list of status IDs to attach to the report, for context.

`comment` are any comments you wish to attach to the report, with a max of 1,000
characters.

`forward` is a boolean determining, if the account is remote, whether the report
should be forwarded to the remote admin.

This function, if successful, returns `#t`.

Find the original documentation [here](https://docs.joinmastodon.org/methods/accounts/reports/).
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `mastoApp` <br />
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `accountID` <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:statusIDs` (argument position 3) <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:comment` (argument position 4) <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:forward` (argument position 5) <br />

<br />

