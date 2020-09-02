# emojis Module


<br />

## Table of Contents
1. [\<mastodon-emoji\>](#mastodon-emoji)
2. [masto-emoji-shortcode](#masto-emoji-shortcode)
3. [masto-emoji-static-url](#masto-emoji-static-url)
4. [masto-emoji-url](#masto-emoji-url)
5. [masto-emoji-visible-in-picker](#masto-emoji-visible-in-picker)
6. [masto-emoji?](#masto-emoji?)
7. [masto-emojis-on-instance](#masto-emojis-on-instance)


<br />

### \<mastodon-emoji\>
##### Summary
A record object that can be returned by an API call.
##### Record Fields
> `shortcode` <br />
> `staticURL` <br />
> `url` <br />
> `visibleInPicker` <br />

<br />

### masto-emoji-shortcode
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-emoji-static-url
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-emoji-url
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-emoji-visible-in-picker
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-emoji?
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `obj` <br />

<br />

### masto-emojis-on-instance
##### Summary
Retrieve all emojis belonging to a particular instance.

`domainOrApp` can be the instance domain as a String or a
[`<mastodon-instance-application>`](auth.md#mastodon-instance-application),
whose associated `domain` will be used instead.

Domains can include or lack the preceding "https://"; this function will add
one, if needed.

This function will return a list of [`<mastodon-emoji>`](#mastodon-emoji)s.

Documentation for this API call can be found [here](https://docs.joinmastodon.org/methods/instance/custom_emojis/).
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `domainOrApp` <br />

<br />

