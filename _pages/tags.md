---
title: "Posts separados por Tags"
permalink: /tags/
layout: tags
author_profile: true
classes:
    - landing
excerpt: "Encontre facilmente algum artigo baseado nas tags"
header:
    overlay_image: /assets/images/splash/kyle-glenn-kvIAk3J_A1c-unsplash.jpg
    overlay_filter: 0.5
    caption: "Photo by Kyle Glenn [**Unsplash**](https://unsplash.com/photos/kvIAk3J_A1c)"
    image_description: Photo by Kyle Glenn on Unsplash
---
<h1>{{ page.title }}</h1>
<ul class="posts">
  {% for post in page.posts %}
    <li>
      <span class="post-date">{{ post.date | date: "%b %-d, %Y" }}</span>
      <a class="post-link" href="{{ post.url | relative_url }}">{{ post.title }}</a>
    </li>
  {% endfor %}
</ul>