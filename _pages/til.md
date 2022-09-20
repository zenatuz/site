---
title: Today I Learned (TIL)
layout: single
permalink: /til/
# collection: til
# entries_layout: grid
classes: wide
author_profile: true
excerpt: "Little learning pills over here!"
header:
    overlay_image: /assets/images/splash/aaron-burden-6jYoil2GhVk-unsplash.jpg
    # overlay_filter: 0.5
    caption: "Photo by Aaron Burden [**Unsplash**](https://unsplash.com/photos/6jYoil2GhVk)"
    image_description: Photo by Aaron Burden on Unsplash
---
# Little learning pills!

> Every post with a single pill of learning!

I don’t write too much on this site, so I decided to create this series to put something that I learned and I think it’s interesting to share.

I called it: Today I Learned (TIL).

You can see the post here:
<ul class="posts">
{% for post in site.posts %}
    {%  if post.tags contains 'today-i-learned' %}
        <li> 
          <a class="post-link" href="{{ post.url | relative_url }}">{{ post.title }}</a>
        </li>
      {% endif %}
{% endfor %}
</ul>