# timelines Module


<br />

## Table of Contents
1. [\<mastodon-account\>](#mastodon-account)
2. [\<mastodon-application\>](#mastodon-application)
3. [\<mastodon-attachment\>](#mastodon-attachment)
4. [\<mastodon-card\>](#mastodon-card)
5. [\<mastodon-conversation\>](#mastodon-conversation)
6. [\<mastodon-emoji\>](#mastodon-emoji)
7. [\<mastodon-field\>](#mastodon-field)
8. [\<mastodon-history\>](#mastodon-history)
9. [\<mastodon-mention\>](#mastodon-mention)
10. [\<mastodon-meta-focus\>](#mastodon-meta-focus)
11. [\<mastodon-meta-subtree\>](#mastodon-meta-subtree)
12. [\<mastodon-meta\>](#mastodon-meta)
13. [\<mastodon-pagination-object\>](#mastodon-pagination-object)
14. [\<mastodon-poll\>](#mastodon-poll)
15. [\<mastodon-status\>](#mastodon-status)
16. [\<mastodon-tag\>](#mastodon-tag)
17. [masto-account-acct](#masto-account-acct)
18. [masto-account-avatar](#masto-account-avatar)
19. [masto-account-avatar-static](#masto-account-avatar-static)
20. [masto-account-bot](#masto-account-bot)
21. [masto-account-created-at](#masto-account-created-at)
22. [masto-account-display-name](#masto-account-display-name)
23. [masto-account-emojis](#masto-account-emojis)
24. [masto-account-fields](#masto-account-fields)
25. [masto-account-followers-count](#masto-account-followers-count)
26. [masto-account-following-count](#masto-account-following-count)
27. [masto-account-header](#masto-account-header)
28. [masto-account-header-static](#masto-account-header-static)
29. [masto-account-id](#masto-account-id)
30. [masto-account-locked](#masto-account-locked)
31. [masto-account-moved](#masto-account-moved)
32. [masto-account-note](#masto-account-note)
33. [masto-account-statuses-count](#masto-account-statuses-count)
34. [masto-account-url](#masto-account-url)
35. [masto-account-username](#masto-account-username)
36. [masto-account?](#masto-account?)
37. [masto-application-name](#masto-application-name)
38. [masto-application-website](#masto-application-website)
39. [masto-application?](#masto-application?)
40. [masto-attachment-blurhash](#masto-attachment-blurhash)
41. [masto-attachment-description](#masto-attachment-description)
42. [masto-attachment-id](#masto-attachment-id)
43. [masto-attachment-meta](#masto-attachment-meta)
44. [masto-attachment-preview-url](#masto-attachment-preview-url)
45. [masto-attachment-remote-url](#masto-attachment-remote-url)
46. [masto-attachment-text-url](#masto-attachment-text-url)
47. [masto-attachment-type](#masto-attachment-type)
48. [masto-attachment-url](#masto-attachment-url)
49. [masto-attachment?](#masto-attachment?)
50. [masto-card-author-name](#masto-card-author-name)
51. [masto-card-author-url](#masto-card-author-url)
52. [masto-card-description](#masto-card-description)
53. [masto-card-height](#masto-card-height)
54. [masto-card-html](#masto-card-html)
55. [masto-card-image](#masto-card-image)
56. [masto-card-provider-name](#masto-card-provider-name)
57. [masto-card-provider-url](#masto-card-provider-url)
58. [masto-card-title](#masto-card-title)
59. [masto-card-type](#masto-card-type)
60. [masto-card-url](#masto-card-url)
61. [masto-card-width](#masto-card-width)
62. [masto-card?](#masto-card?)
63. [masto-conversations-all](#masto-conversations-all)
64. [masto-convo-accounts](#masto-convo-accounts)
65. [masto-convo-id](#masto-convo-id)
66. [masto-convo-last-status](#masto-convo-last-status)
67. [masto-convo-unread](#masto-convo-unread)
68. [masto-convo?](#masto-convo?)
69. [masto-emoji-shortcode](#masto-emoji-shortcode)
70. [masto-emoji-static-url](#masto-emoji-static-url)
71. [masto-emoji-url](#masto-emoji-url)
72. [masto-emoji-visible-in-picker](#masto-emoji-visible-in-picker)
73. [masto-emoji?](#masto-emoji?)
74. [masto-field-name](#masto-field-name)
75. [masto-field-value](#masto-field-value)
76. [masto-field-verified-at](#masto-field-verified-at)
77. [masto-field?](#masto-field?)
78. [masto-history-accounts](#masto-history-accounts)
79. [masto-history-day](#masto-history-day)
80. [masto-history-uses](#masto-history-uses)
81. [masto-history?](#masto-history?)
82. [masto-mention-acct](#masto-mention-acct)
83. [masto-mention-id](#masto-mention-id)
84. [masto-mention-url](#masto-mention-url)
85. [masto-mention-username](#masto-mention-username)
86. [masto-mention?](#masto-mention?)
87. [masto-meta-focus](#masto-meta-focus)
88. [masto-meta-focus-x](#masto-meta-focus-x)
89. [masto-meta-focus-y](#masto-meta-focus-y)
90. [masto-meta-focus?](#masto-meta-focus?)
91. [masto-meta-original](#masto-meta-original)
92. [masto-meta-small](#masto-meta-small)
93. [masto-meta-subtree-aspect](#masto-meta-subtree-aspect)
94. [masto-meta-subtree-bitrate](#masto-meta-subtree-bitrate)
95. [masto-meta-subtree-duration](#masto-meta-subtree-duration)
96. [masto-meta-subtree-frame-rate](#masto-meta-subtree-frame-rate)
97. [masto-meta-subtree-height](#masto-meta-subtree-height)
98. [masto-meta-subtree-size](#masto-meta-subtree-size)
99. [masto-meta-subtree-width](#masto-meta-subtree-width)
100. [masto-meta-subtree?](#masto-meta-subtree?)
101. [masto-meta?](#masto-meta?)
102. [masto-page-next](#masto-page-next)
103. [masto-page-objects](#masto-page-objects)
104. [masto-page-prev](#masto-page-prev)
105. [masto-page?](#masto-page?)
106. [masto-poll-expired](#masto-poll-expired)
107. [masto-poll-expires-at](#masto-poll-expires-at)
108. [masto-poll-id](#masto-poll-id)
109. [masto-poll-multiple](#masto-poll-multiple)
110. [masto-poll-options](#masto-poll-options)
111. [masto-poll-voted](#masto-poll-voted)
112. [masto-poll-votes-count](#masto-poll-votes-count)
113. [masto-poll?](#masto-poll?)
114. [masto-status-account](#masto-status-account)
115. [masto-status-application](#masto-status-application)
116. [masto-status-card](#masto-status-card)
117. [masto-status-content](#masto-status-content)
118. [masto-status-created-at](#masto-status-created-at)
119. [masto-status-emojis](#masto-status-emojis)
120. [masto-status-favorited](#masto-status-favorited)
121. [masto-status-favorites-count](#masto-status-favorites-count)
122. [masto-status-id](#masto-status-id)
123. [masto-status-in-reply-to-account-id](#masto-status-in-reply-to-account-id)
124. [masto-status-in-reply-to-id](#masto-status-in-reply-to-id)
125. [masto-status-language](#masto-status-language)
126. [masto-status-media-attachments](#masto-status-media-attachments)
127. [masto-status-mentions](#masto-status-mentions)
128. [masto-status-muted](#masto-status-muted)
129. [masto-status-pinned](#masto-status-pinned)
130. [masto-status-poll](#masto-status-poll)
131. [masto-status-reblog-status](#masto-status-reblog-status)
132. [masto-status-reblogged](#masto-status-reblogged)
133. [masto-status-reblogs-count](#masto-status-reblogs-count)
134. [masto-status-replies-count](#masto-status-replies-count)
135. [masto-status-sensitive](#masto-status-sensitive)
136. [masto-status-spoiler-text](#masto-status-spoiler-text)
137. [masto-status-tags](#masto-status-tags)
138. [masto-status-uri](#masto-status-uri)
139. [masto-status-url](#masto-status-url)
140. [masto-status-visibility](#masto-status-visibility)
141. [masto-status?](#masto-status?)
142. [masto-tag-history](#masto-tag-history)
143. [masto-tag-name](#masto-tag-name)
144. [masto-tag-url](#masto-tag-url)
145. [masto-tag?](#masto-tag?)
146. [masto-timelines-home](#masto-timelines-home)
147. [masto-timelines-list](#masto-timelines-list)
148. [masto-timelines-public](#masto-timelines-public)
149. [masto-timelines-tag](#masto-timelines-tag)


<br />

### \<mastodon-account\>
##### Summary
A record object that can be returned by an API call.
##### Record Fields
> `id` <br />
> `username` <br />
> `acct` <br />
> `displayName` <br />
> `locked` <br />
> `createdAt` <br />
> `followersCount` <br />
> `followingCount` <br />
> `statusesCount` <br />
> `note` <br />
> `url` <br />
> `avatar` <br />
> `avatarStatic` <br />
> `header` <br />
> `headerStatic` <br />
> `emojis` <br />
> `moved` <br />
> `fields` <br />
> `bot` <br />

<br />

### \<mastodon-application\>
##### Summary
A record object that can be returned by an API call.
##### Record Fields
> `name` <br />
> `website` <br />

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

### \<mastodon-card\>
##### Summary
A record object that can be returned by an API call.
##### Record Fields
> `url` <br />
> `title` <br />
> `description` <br />
> `image` <br />
> `type` <br />
> `authorName` <br />
> `authorURL` <br />
> `providerName` <br />
> `providerURL` <br />
> `html` <br />
> `width` <br />
> `height` <br />

<br />

### \<mastodon-conversation\>
##### Summary
A record object that can be returned by an API call.
##### Record Fields
> `id` <br />
> `accounts` <br />
> `lastStatus` <br />
> `unread` <br />

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

### \<mastodon-field\>
##### Summary
A record object that can be returned by an API call.
##### Record Fields
> `name` <br />
> `value` <br />
> `verifiedAt` <br />

<br />

### \<mastodon-history\>
##### Summary
A record object that can be returned by an API call.
##### Record Fields
> `day` <br />
> `uses` <br />
> `accounts` <br />

<br />

### \<mastodon-mention\>
##### Summary
A record object that can be returned by an API call.
##### Record Fields
> `url` <br />
> `username` <br />
> `acct` <br />
> `id` <br />

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

### \<mastodon-pagination-object\>
##### Summary
A record object that can be returned by an API call.
##### Record Fields
> `objectCollection` <br />
> `prevURL` <br />
> `prevPage` <br />
> `nextURL` <br />
> `nextPage` <br />
> `http-call` <br />
> `generate-fn` <br />

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

### \<mastodon-status\>
##### Summary
A record object that can be returned by an API call.
##### Record Fields
> `id` <br />
> `uri` <br />
> `url` <br />
> `account` <br />
> `inReplyToID` <br />
> `inReplyToAccountID` <br />
> `reblogStatus` <br />
> `content` <br />
> `createdAt` <br />
> `emojis` <br />
> `repliesCount` <br />
> `reblogsCount` <br />
> `favoritesCount` <br />
> `reblogged` <br />
> `favorited` <br />
> `muted` <br />
> `bookmarked` <br />
> `sensitive` <br />
> `spoilerText` <br />
> `visibility` <br />
> `mediaAttachments` <br />
> `mentions` <br />
> `tags` <br />
> `card` <br />
> `poll` <br />
> `application` <br />
> `language` <br />
> `pinned` <br />

<br />

### \<mastodon-tag\>
##### Summary
A record object that can be returned by an API call.
##### Record Fields
> `name` <br />
> `url` <br />
> `history` <br />

<br />

### masto-account-acct
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-account-avatar
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-account-avatar-static
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-account-bot
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-account-created-at
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-account-display-name
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-account-emojis
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-account-fields
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-account-followers-count
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-account-following-count
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-account-header
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-account-header-static
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-account-id
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-account-locked
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-account-moved
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-account-note
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-account-statuses-count
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-account-url
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-account-username
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-account?
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `obj` <br />

<br />

### masto-application-name
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-application-website
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-application?
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `obj` <br />

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

### masto-card-author-name
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-card-author-url
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-card-description
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-card-height
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-card-html
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-card-image
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-card-provider-name
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-card-provider-url
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-card-title
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-card-type
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-card-url
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-card-width
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-card?
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `obj` <br />

<br />

### masto-conversations-all
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `mastoApp` <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:maxID` (argument position 2) <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:sinceID` (argument position 3) <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:minID` (argument position 4) <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:limit` (argument position 5) <br />

<br />

### masto-convo-accounts
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-convo-id
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-convo-last-status
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-convo-unread
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-convo?
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `obj` <br />

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

### masto-field-name
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-field-value
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-field-verified-at
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-field?
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `obj` <br />

<br />

### masto-history-accounts
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-history-day
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-history-uses
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-history?
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `obj` <br />

<br />

### masto-mention-acct
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-mention-id
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-mention-url
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-mention-username
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-mention?
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

### masto-page-next
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `mastoApp` <br />
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `page` <br />

<br />

### masto-page-objects
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-page-prev
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `mastoApp` <br />
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `page` <br />

<br />

### masto-page?
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `obj` <br />

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

### masto-status-account
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-status-application
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-status-card
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-status-content
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-status-created-at
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-status-emojis
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-status-favorited
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-status-favorites-count
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-status-id
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-status-in-reply-to-account-id
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-status-in-reply-to-id
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-status-language
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-status-media-attachments
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-status-mentions
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-status-muted
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-status-pinned
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-status-poll
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-status-reblog-status
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-status-reblogged
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-status-reblogs-count
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-status-replies-count
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-status-sensitive
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-status-spoiler-text
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-status-tags
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-status-uri
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-status-url
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-status-visibility
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-status?
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `obj` <br />

<br />

### masto-tag-history
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-tag-name
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-tag-url
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

### masto-tag?
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `obj` <br />

<br />

### masto-timelines-home
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `mastoApp` <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:maxID` (argument position 2) <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:sinceID` (argument position 3) <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:minID` (argument position 4) <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:limit` (argument position 5) <br />

<br />

### masto-timelines-list
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `mastoApp` <br />
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `listID` <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:maxID` (argument position 3) <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:sinceID` (argument position 4) <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:minID` (argument position 5) <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:limit` (argument position 6) <br />

<br />

### masto-timelines-public
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `domainOrApp` <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:local` (argument position 2) <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:onlyMedia` (argument position 3) <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:maxID` (argument position 4) <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:sinceID` (argument position 5) <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:minID` (argument position 6) <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:limit` (argument position 7) <br />

<br />

### masto-timelines-tag
##### Summary
#f
##### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `domainOrApp` <br />
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `hashtag` <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:local` (argument position 3) <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:onlyMedia` (argument position 4) <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:maxID` (argument position 5) <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:sinceID` (argument position 6) <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:minID` (argument position 7) <br />
> ![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `#:limit` (argument position 8) <br />

<br />

