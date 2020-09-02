# favorites Module


<br />

# Table of Contents
1. [\<mastodon-account\>](#mastodon-account)
2. [\<mastodon-application\>](#mastodon-application)
3. [\<mastodon-attachment\>](#mastodon-attachment)
4. [\<mastodon-card\>](#mastodon-card)
5. [\<mastodon-emoji\>](#mastodon-emoji)
6. [\<mastodon-field\>](#mastodon-field)
7. [\<mastodon-history\>](#mastodon-history)
8. [\<mastodon-mention\>](#mastodon-mention)
9. [\<mastodon-meta-focus\>](#mastodon-meta-focus)
10. [\<mastodon-meta-subtree\>](#mastodon-meta-subtree)
11. [\<mastodon-meta\>](#mastodon-meta)
12. [\<mastodon-pagination-object\>](#mastodon-pagination-object)
13. [\<mastodon-poll\>](#mastodon-poll)
14. [\<mastodon-status\>](#mastodon-status)
15. [\<mastodon-tag\>](#mastodon-tag)
16. [masto-account-acct](#masto-account-acct)
17. [masto-account-avatar](#masto-account-avatar)
18. [masto-account-avatar-static](#masto-account-avatar-static)
19. [masto-account-bot](#masto-account-bot)
20. [masto-account-created-at](#masto-account-created-at)
21. [masto-account-display-name](#masto-account-display-name)
22. [masto-account-emojis](#masto-account-emojis)
23. [masto-account-fields](#masto-account-fields)
24. [masto-account-followers-count](#masto-account-followers-count)
25. [masto-account-following-count](#masto-account-following-count)
26. [masto-account-header](#masto-account-header)
27. [masto-account-header-static](#masto-account-header-static)
28. [masto-account-id](#masto-account-id)
29. [masto-account-locked](#masto-account-locked)
30. [masto-account-moved](#masto-account-moved)
31. [masto-account-note](#masto-account-note)
32. [masto-account-statuses-count](#masto-account-statuses-count)
33. [masto-account-url](#masto-account-url)
34. [masto-account-username](#masto-account-username)
35. [masto-account?](#masto-account?)
36. [masto-application-name](#masto-application-name)
37. [masto-application-website](#masto-application-website)
38. [masto-application?](#masto-application?)
39. [masto-attachment-blurhash](#masto-attachment-blurhash)
40. [masto-attachment-description](#masto-attachment-description)
41. [masto-attachment-id](#masto-attachment-id)
42. [masto-attachment-meta](#masto-attachment-meta)
43. [masto-attachment-preview-url](#masto-attachment-preview-url)
44. [masto-attachment-remote-url](#masto-attachment-remote-url)
45. [masto-attachment-text-url](#masto-attachment-text-url)
46. [masto-attachment-type](#masto-attachment-type)
47. [masto-attachment-url](#masto-attachment-url)
48. [masto-attachment?](#masto-attachment?)
49. [masto-card-author-name](#masto-card-author-name)
50. [masto-card-author-url](#masto-card-author-url)
51. [masto-card-description](#masto-card-description)
52. [masto-card-height](#masto-card-height)
53. [masto-card-html](#masto-card-html)
54. [masto-card-image](#masto-card-image)
55. [masto-card-provider-name](#masto-card-provider-name)
56. [masto-card-provider-url](#masto-card-provider-url)
57. [masto-card-title](#masto-card-title)
58. [masto-card-type](#masto-card-type)
59. [masto-card-url](#masto-card-url)
60. [masto-card-width](#masto-card-width)
61. [masto-card?](#masto-card?)
62. [masto-emoji-shortcode](#masto-emoji-shortcode)
63. [masto-emoji-static-url](#masto-emoji-static-url)
64. [masto-emoji-url](#masto-emoji-url)
65. [masto-emoji-visible-in-picker](#masto-emoji-visible-in-picker)
66. [masto-emoji?](#masto-emoji?)
67. [masto-field-name](#masto-field-name)
68. [masto-field-value](#masto-field-value)
69. [masto-field-verified-at](#masto-field-verified-at)
70. [masto-field?](#masto-field?)
71. [masto-history-accounts](#masto-history-accounts)
72. [masto-history-day](#masto-history-day)
73. [masto-history-uses](#masto-history-uses)
74. [masto-history?](#masto-history?)
75. [masto-mention-acct](#masto-mention-acct)
76. [masto-mention-id](#masto-mention-id)
77. [masto-mention-url](#masto-mention-url)
78. [masto-mention-username](#masto-mention-username)
79. [masto-mention?](#masto-mention?)
80. [masto-meta-focus](#masto-meta-focus)
81. [masto-meta-focus-x](#masto-meta-focus-x)
82. [masto-meta-focus-y](#masto-meta-focus-y)
83. [masto-meta-focus?](#masto-meta-focus?)
84. [masto-meta-original](#masto-meta-original)
85. [masto-meta-small](#masto-meta-small)
86. [masto-meta-subtree-aspect](#masto-meta-subtree-aspect)
87. [masto-meta-subtree-bitrate](#masto-meta-subtree-bitrate)
88. [masto-meta-subtree-duration](#masto-meta-subtree-duration)
89. [masto-meta-subtree-frame-rate](#masto-meta-subtree-frame-rate)
90. [masto-meta-subtree-height](#masto-meta-subtree-height)
91. [masto-meta-subtree-size](#masto-meta-subtree-size)
92. [masto-meta-subtree-width](#masto-meta-subtree-width)
93. [masto-meta-subtree?](#masto-meta-subtree?)
94. [masto-meta?](#masto-meta?)
95. [masto-page-next](#masto-page-next)
96. [masto-page-objects](#masto-page-objects)
97. [masto-page-prev](#masto-page-prev)
98. [masto-page?](#masto-page?)
99. [masto-poll-expired](#masto-poll-expired)
100. [masto-poll-expires-at](#masto-poll-expires-at)
101. [masto-poll-id](#masto-poll-id)
102. [masto-poll-multiple](#masto-poll-multiple)
103. [masto-poll-options](#masto-poll-options)
104. [masto-poll-voted](#masto-poll-voted)
105. [masto-poll-votes-count](#masto-poll-votes-count)
106. [masto-poll?](#masto-poll?)
107. [masto-status-account](#masto-status-account)
108. [masto-status-application](#masto-status-application)
109. [masto-status-card](#masto-status-card)
110. [masto-status-content](#masto-status-content)
111. [masto-status-created-at](#masto-status-created-at)
112. [masto-status-emojis](#masto-status-emojis)
113. [masto-status-favorited](#masto-status-favorited)
114. [masto-status-favorites-count](#masto-status-favorites-count)
115. [masto-status-id](#masto-status-id)
116. [masto-status-in-reply-to-account-id](#masto-status-in-reply-to-account-id)
117. [masto-status-in-reply-to-id](#masto-status-in-reply-to-id)
118. [masto-status-language](#masto-status-language)
119. [masto-status-media-attachments](#masto-status-media-attachments)
120. [masto-status-mentions](#masto-status-mentions)
121. [masto-status-muted](#masto-status-muted)
122. [masto-status-pinned](#masto-status-pinned)
123. [masto-status-poll](#masto-status-poll)
124. [masto-status-reblog-status](#masto-status-reblog-status)
125. [masto-status-reblogged](#masto-status-reblogged)
126. [masto-status-reblogs-count](#masto-status-reblogs-count)
127. [masto-status-replies-count](#masto-status-replies-count)
128. [masto-status-sensitive](#masto-status-sensitive)
129. [masto-status-spoiler-text](#masto-status-spoiler-text)
130. [masto-status-tags](#masto-status-tags)
131. [masto-status-uri](#masto-status-uri)
132. [masto-status-url](#masto-status-url)
133. [masto-status-visibility](#masto-status-visibility)
134. [masto-status?](#masto-status?)
135. [masto-tag-history](#masto-tag-history)
136. [masto-tag-name](#masto-tag-name)
137. [masto-tag-url](#masto-tag-url)
138. [masto-tag?](#masto-tag?)
139. [masto-favorite-status](#masto-favorite-status)
140. [masto-favorites-all](#masto-favorites-all)
141. [masto-unfavorite-status](#masto-unfavorite-status)

## \<mastodon-account\>
#### Summary
A record object that can be returned by an API call.
#### Record Fields
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

## \<mastodon-application\>
#### Summary
A record object that can be returned by an API call.
#### Record Fields
> `name` <br />
> `website` <br />

<br />

## \<mastodon-attachment\>
#### Summary
A record object that can be returned by an API call.
#### Record Fields
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

## \<mastodon-card\>
#### Summary
A record object that can be returned by an API call.
#### Record Fields
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

## \<mastodon-emoji\>
#### Summary
A record object that can be returned by an API call.
#### Record Fields
> `shortcode` <br />
> `staticURL` <br />
> `url` <br />
> `visibleInPicker` <br />

<br />

## \<mastodon-field\>
#### Summary
A record object that can be returned by an API call.
#### Record Fields
> `name` <br />
> `value` <br />
> `verifiedAt` <br />

<br />

## \<mastodon-history\>
#### Summary
A record object that can be returned by an API call.
#### Record Fields
> `day` <br />
> `uses` <br />
> `accounts` <br />

<br />

## \<mastodon-mention\>
#### Summary
A record object that can be returned by an API call.
#### Record Fields
> `url` <br />
> `username` <br />
> `acct` <br />
> `id` <br />

<br />

## \<mastodon-meta-focus\>
#### Summary
A record object that can be returned by an API call.
#### Record Fields
> `x` <br />
> `y` <br />

<br />

## \<mastodon-meta-subtree\>
#### Summary
A record object that can be returned by an API call.
#### Record Fields
> `width` <br />
> `height` <br />
> `size` <br />
> `aspect` <br />
> `frameRate` <br />
> `duration` <br />
> `bitrate` <br />

<br />

## \<mastodon-meta\>
#### Summary
A record object that can be returned by an API call.
#### Record Fields
> `small` <br />
> `original` <br />
> `focus` <br />

<br />

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

## \<mastodon-poll\>
#### Summary
A record object that can be returned by an API call.
#### Record Fields
> `id` <br />
> `expiresAt` <br />
> `expired` <br />
> `multiple` <br />
> `votesCount` <br />
> `options` <br />
> `voted` <br />

<br />

## \<mastodon-status\>
#### Summary
A record object that can be returned by an API call.
#### Record Fields
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

## \<mastodon-tag\>
#### Summary
A record object that can be returned by an API call.
#### Record Fields
> `name` <br />
> `url` <br />
> `history` <br />

<br />

## masto-account-acct
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-account-avatar
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-account-avatar-static
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-account-bot
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-account-created-at
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-account-display-name
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-account-emojis
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-account-fields
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-account-followers-count
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-account-following-count
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-account-header
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-account-header-static
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-account-id
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-account-locked
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-account-moved
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-account-note
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-account-statuses-count
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-account-url
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-account-username
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-account?
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `obj` <br />

<br />

## masto-application-name
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-application-website
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-application?
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `obj` <br />

<br />

## masto-attachment-blurhash
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-attachment-description
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-attachment-id
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-attachment-meta
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-attachment-preview-url
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-attachment-remote-url
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-attachment-text-url
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-attachment-type
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-attachment-url
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-attachment?
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `obj` <br />

<br />

## masto-card-author-name
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-card-author-url
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-card-description
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-card-height
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-card-html
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-card-image
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-card-provider-name
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-card-provider-url
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-card-title
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-card-type
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-card-url
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-card-width
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-card?
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `obj` <br />

<br />

## masto-emoji-shortcode
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-emoji-static-url
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-emoji-url
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-emoji-visible-in-picker
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-emoji?
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `obj` <br />

<br />

## masto-field-name
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-field-value
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-field-verified-at
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-field?
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `obj` <br />

<br />

## masto-history-accounts
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-history-day
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-history-uses
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-history?
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `obj` <br />

<br />

## masto-mention-acct
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-mention-id
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-mention-url
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-mention-username
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-mention?
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `obj` <br />

<br />

## masto-meta-focus
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-meta-focus-x
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-meta-focus-y
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-meta-focus?
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `obj` <br />

<br />

## masto-meta-original
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-meta-small
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-meta-subtree-aspect
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-meta-subtree-bitrate
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-meta-subtree-duration
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-meta-subtree-frame-rate
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-meta-subtree-height
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-meta-subtree-size
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-meta-subtree-width
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-meta-subtree?
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `obj` <br />

<br />

## masto-meta?
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `obj` <br />

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

## masto-poll-expired
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-poll-expires-at
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-poll-id
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-poll-multiple
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-poll-options
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-poll-voted
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-poll-votes-count
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-poll?
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `obj` <br />

<br />

## masto-status-account
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-status-application
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-status-card
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-status-content
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-status-created-at
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-status-emojis
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-status-favorited
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-status-favorites-count
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-status-id
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-status-in-reply-to-account-id
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-status-in-reply-to-id
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-status-language
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-status-media-attachments
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-status-mentions
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-status-muted
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-status-pinned
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-status-poll
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-status-reblog-status
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-status-reblogged
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-status-reblogs-count
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-status-replies-count
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-status-sensitive
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-status-spoiler-text
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-status-tags
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-status-uri
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-status-url
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-status-visibility
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-status?
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `obj` <br />

<br />

## masto-tag-history
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-tag-name
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-tag-url
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `s` <br />

<br />

## masto-tag?
#### Summary
#f
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `obj` <br />

<br />

## masto-favorite-status
#### Summary
Favorite an existing Fediverse status for the user tied to `mastoApp`.

`statusID` refers to the ID of the status that you wish to favorite.

A [`<mastodon-status>`](#mastodon-status) is returned.

Find the original documentation within [this page](https://docs.joinmastodon.org/methods/accounts/).
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `mastoApp` <br />
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `statusID` <br />

<br />

## masto-favorites-all
#### Summary
Retrieve all favorites associated with the user tied to `mastoApp`.

If no `limit` value is provided, the value 20 is used.

A [`<mastodon-pagination-object>`](#mastodon-pagination-object) is returned,
consisting of the [`<mastodon-account>`](#mastodon-account)s that the user
has endorsed.

Find the original documentation [here](https://docs.joinmastodon.org/methods/accounts/favourites/).
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `mastoApp` <br />
> ![#c5f015](https://placehold.it/15/c5f015/000000?text=+) `[limit]` <br />

<br />

## masto-unfavorite-status
#### Summary
Unfavorite an existing Fediverse status for the user tied to `mastoApp`.

`statusID` refers to the ID of the status that you wish to unfavorite.

A [`<mastodon-status>`](#mastodon-status) is returned.

Find the original documentation within [this page](https://docs.joinmastodon.org/methods/accounts/).
#### Parameters
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `mastoApp` <br />
> ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `statusID` <br />

<br />

