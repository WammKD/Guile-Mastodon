# scheduled-statuses Module


<br />

## Table of Contents
1. [\<mastodon-attachment\>](#mastodon-attachment)
2. [\<mastodon-meta-focus\>](#mastodon-meta-focus)
3. [\<mastodon-meta-subtree\>](#mastodon-meta-subtree)
4. [\<mastodon-meta\>](#mastodon-meta)
5. [\<mastodon-scheduled-status-params\>](#mastodon-scheduled-status-params)
6. [\<mastodon-scheduled-status\>](#mastodon-scheduled-status)
7. [masto-attachment-blurhash](#masto-attachment-blurhash)
8. [masto-attachment-description](#masto-attachment-description)
9. [masto-attachment-id](#masto-attachment-id)
10. [masto-attachment-meta](#masto-attachment-meta)
11. [masto-attachment-preview-url](#masto-attachment-preview-url)
12. [masto-attachment-remote-url](#masto-attachment-remote-url)
13. [masto-attachment-text-url](#masto-attachment-text-url)
14. [masto-attachment-type](#masto-attachment-type)
15. [masto-attachment-url](#masto-attachment-url)
16. [masto-attachment?](#masto-attachment?)
17. [masto-meta-focus](#masto-meta-focus)
18. [masto-meta-focus-x](#masto-meta-focus-x)
19. [masto-meta-focus-y](#masto-meta-focus-y)
20. [masto-meta-focus?](#masto-meta-focus?)
21. [masto-meta-original](#masto-meta-original)
22. [masto-meta-small](#masto-meta-small)
23. [masto-meta-subtree-aspect](#masto-meta-subtree-aspect)
24. [masto-meta-subtree-bitrate](#masto-meta-subtree-bitrate)
25. [masto-meta-subtree-duration](#masto-meta-subtree-duration)
26. [masto-meta-subtree-frame-rate](#masto-meta-subtree-frame-rate)
27. [masto-meta-subtree-height](#masto-meta-subtree-height)
28. [masto-meta-subtree-size](#masto-meta-subtree-size)
29. [masto-meta-subtree-width](#masto-meta-subtree-width)
30. [masto-meta-subtree?](#masto-meta-subtree?)
31. [masto-meta?](#masto-meta?)
32. [masto-scheduled-status-id](#masto-scheduled-status-id)
33. [masto-scheduled-status-media-attachments](#masto-scheduled-status-media-attachments)
34. [masto-scheduled-status-params](#masto-scheduled-status-params)
35. [masto-scheduled-status-params-application-id](#masto-scheduled-status-params-application-id)
36. [masto-scheduled-status-params-in-reply-to-id](#masto-scheduled-status-params-in-reply-to-id)
37. [masto-scheduled-status-params-media-ids](#masto-scheduled-status-params-media-ids)
38. [masto-scheduled-status-params-scheduled-at](#masto-scheduled-status-params-scheduled-at)
39. [masto-scheduled-status-params-sensitive](#masto-scheduled-status-params-sensitive)
40. [masto-scheduled-status-params-spoiler-text](#masto-scheduled-status-params-spoiler-text)
41. [masto-scheduled-status-params-text](#masto-scheduled-status-params-text)
42. [masto-scheduled-status-params-visibility](#masto-scheduled-status-params-visibility)
43. [masto-scheduled-status-params?](#masto-scheduled-status-params?)
44. [masto-scheduled-status-scheduled-at](#masto-scheduled-status-scheduled-at)
45. [masto-scheduled-status-scheduled-at-set!](#masto-scheduled-status-scheduled-at-set!)
46. [masto-scheduled-status?](#masto-scheduled-status?)
47. [masto-scheduled-status-delete](#masto-scheduled-status-delete)
48. [masto-scheduled-status-get](#masto-scheduled-status-get)
49. [masto-scheduled-status-update](#masto-scheduled-status-update)
50. [masto-scheduled-statuses-all](#masto-scheduled-statuses-all)


<br />

### \<mastodon-attachment\>
##### Summary
A record object that can be returned by an API call.
##### Record Fields
> `id` <br />
> `type` <br />
> `url` <br />
> `remoteURL` <br />
> `previewURL` <br />
> `textURL` <br />
> `meta` <br />
> `description` <br />
> `blurhash` <br />

<br />

### \<mastodon-meta-focus\>
##### Summary
A record object that can be returned by an API call.
##### Record Fields
> `x` <br />
> `y` <br />

<br />

### \<mastodon-meta-subtree\>
##### Summary
A record object that can be returned by an API call.
##### Record Fields
> `width` <br />
> `height` <br />
> `size` <br />
> `aspect` <br />
> `frameRate` <br />
> `duration` <br />
> `bitrate` <br />

<br />

### \<mastodon-meta\>
##### Summary
A record object that can be returned by an API call.
##### Record Fields
> `small` <br />
> `original` <br />
> `focus` <br />

<br />

### \<mastodon-scheduled-status-params\>
##### Summary
A record object that can be returned by an API call.
##### Record Fields
> `text` <br />
> `inReplyToID` <br />
> `mediaIDs` <br />
> `sensitive` <br />
> `spoilerText` <br />
> `visibility` <br />
> `scheduledAt` <br />
> `applicationID` <br />

<br />

### \<mastodon-scheduled-status\>
##### Summary
A record object that can be returned by an API call.
##### Record Fields
> `id` <br />
> `scheduledAt` <br />
> `params` <br />
> `mediaAttachments` <br />

<br />

### masto-attachment-blurhash
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-attachment-description
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-attachment-id
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-attachment-meta
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-attachment-preview-url
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-attachment-remote-url
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-attachment-text-url
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-attachment-type
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-attachment-url
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-attachment?
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `obj` <br />

<br />

### masto-meta-focus
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-meta-focus-x
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-meta-focus-y
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-meta-focus?
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `obj` <br />

<br />

### masto-meta-original
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-meta-small
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-meta-subtree-aspect
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-meta-subtree-bitrate
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-meta-subtree-duration
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-meta-subtree-frame-rate
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-meta-subtree-height
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-meta-subtree-size
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-meta-subtree-width
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-meta-subtree?
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `obj` <br />

<br />

### masto-meta?
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `obj` <br />

<br />

### masto-scheduled-status-id
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-scheduled-status-media-attachments
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-scheduled-status-params
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-scheduled-status-params-application-id
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-scheduled-status-params-in-reply-to-id
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-scheduled-status-params-media-ids
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-scheduled-status-params-scheduled-at
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-scheduled-status-params-sensitive
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-scheduled-status-params-spoiler-text
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-scheduled-status-params-text
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-scheduled-status-params-visibility
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-scheduled-status-params?
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `obj` <br />

<br />

### masto-scheduled-status-scheduled-at
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-scheduled-status-scheduled-at-set!
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `val` <br />

<br />

### masto-scheduled-status?
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `obj` <br />

<br />

### masto-scheduled-status-delete
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `mastoApp` <br />
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `scheduledStatusID` <br />

<br />

### masto-scheduled-status-get
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `mastoApp` <br />
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `scheduledStatusID` <br />

<br />

### masto-scheduled-status-update
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `mastoApp` <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:scheduledStatus` (argument position 2) <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:scheduledStatusID` (argument position 3) <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:scheduledAt` (argument position 4) <br />

<br />

### masto-scheduled-statuses-all
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `mastoApp` <br />

<br />

