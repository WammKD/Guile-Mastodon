# auth Module
 This module constructs the <mastodon-instance-application> record which
 serves as a representation of a Mastodon client, holding the credentials
 which are used to authenticate with an instance's API (when said
 authentication is needed, as not all endpoints require authentication).



<br />
## Table of Contents
1. [\<mastodon-instance-application\>](#mastodon-instance-application)
2. [masto-app-authorize-uri](#masto-app-authorize-uri)
3. [masto-app-domain](#masto-app-domain)
4. [masto-app-id](#masto-app-id)
5. [masto-app-instantiate](#masto-app-instantiate)
6. [masto-app-key](#masto-app-key)
7. [masto-app-name](#masto-app-name)
8. [masto-app-redirects](#masto-app-redirects)
9. [masto-app-scopes](#masto-app-scopes)
10. [masto-app-secret](#masto-app-secret)
11. [masto-app-set-token-via-client-cred!](#masto-app-set-token-via-client-cred!)
12. [masto-app-set-token-via-code!](#masto-app-set-token-via-code!)
13. [masto-app-set-token-via-user-cred!](#masto-app-set-token-via-user-cred!)
14. [masto-app-token](#masto-app-token)
15. [masto-app-verify-cred](#masto-app-verify-cred)
16. [masto-app-website](#masto-app-website)
17. [masto-instance-app?](#masto-instance-app?)


### \<mastodon-instance-application\>
##### Summary
A record object that can be returned by an API call.
##### Record Fields
> `domain` <br />
> `name` <br />
> `website` <br />
> `redirects` <br />
> `id` <br />
> `secret` <br />
> `key` <br />
> `scopes` <br />
> `token` <br />

<br />

### masto-app-authorize-uri
##### Summary
Generates the URL to supply the user in order to display an authorization
form to zem.

If no redirect URI is specified (via the `redirect` argument), the first of the
specified redirect URIs stored in the app. record (`mastoApp`) will be used.

`scopes`, likewise, will default to the values stored in the app. record if no
scopes are provided to the argument `scopes` for this function.

`force` will default to `false` if no value is specified.

Original Mastodon documentation of the HTTP call used for this process can be
found [here, under the "Authorize a user" section](https://docs.joinmastodon.org/methods/apps/oauth/).
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `mastoApp` <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:redirect` (argument position 2) <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:scopes` (argument position 3) <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:force` (argument position 4) <br />

<br />

### masto-app-domain
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-app-id
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-app-instantiate
##### Summary
Instantiate an application record for use with authentication.

Only an instance domain is required; if no client ID, secret, or key are
provided, a client is registered at the specified instance; to avoid registering
a new client and use an existing one, all three must be provided.

`name`, `redirects`, and `scopes` default to – respectively – `"Elefan"`,
`'("urn:ietf:wg:oauth:2.0:oob")`, and `'("read")`, if not provided for.

Original Mastodon documentation of the HTTP call used for this process can be
found [here, under the "Create an application" section](https://docs.joinmastodon.org/methods/apps/).

To learn more about scopes, visit [here](https://docs.joinmastodon.org/api/oauth-scopes/).
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `domain` <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:website` (argument position 2) <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:id` (argument position 3) <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:secret` (argument position 4) <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:key` (argument position 5) <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:name` (argument position 6) <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:redirects` (argument position 7) <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:scopes` (argument position 8) <br />

<br />

### masto-app-key
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-app-name
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-app-redirects
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-app-scopes
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-app-secret
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-app-set-token-via-client-cred!
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `mastoApp` <br />
> ![#c5f015](https://placehold.it/15/c5f015/000000?text=+) `[scopes]` <br />

<br />

### masto-app-set-token-via-code!
##### Summary
Obtain a token (to store in your `mastoApp` record object) via a user
authorization code, obtained via [`masto-app-authorize-uri`](#masto-app-authorize-uri).

If no redirect URI is specified (via the `redirect` argument), the first of the
specified redirect URIs stored in the app. record (`mastoApp`) will be used.

Original Mastodon documentation of the HTTP call used for this process can be
found [here, under the "Obtain a token" section](https://docs.joinmastodon.org/methods/apps/oauth/).
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `mastoApp` <br />
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `code` <br />
> ![#c5f015](https://placehold.it/15/c5f015/000000?text=+) `[redirect]` <br />

<br />

### masto-app-set-token-via-user-cred!
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `mastoApp` <br />
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `username` <br />
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `password` <br />
> ![#c5f015](https://placehold.it/15/c5f015/000000?text=+) `[scopes]` <br />

<br />

### masto-app-token
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-app-verify-cred
##### Summary
Confirm that the app's OAuth2 credentials stored in the record work.

Original Mastodon documentation of the HTTP call used for this process can be
found [here, under the "Verify your app works" section](https://docs.joinmastodon.org/methods/apps/).
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `mastoApp` <br />

<br />

### masto-app-website
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-instance-app?
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `obj` <br />

<br />

