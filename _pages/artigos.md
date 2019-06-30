---
title:  "Artigos"
layout: archive
permalink: artigos
author_profile: true
classes:
    - landing
excerpt: "Fique atualizado, os últimos artigos atualizados estão aqui!"
header:
    overlay_image: /assets/images/splash/articles_bg.jpg
    overlay_filter: 0.5
    caption: "Photo by Matthew Guay [**Unsplash**](https://unsplash.com/photos/Q7wDdmgCBFg)"
    image_description: Photo by Matthew Guay on Unsplash
    cta_label: "Assine nosso feed"
    cta_url: "/feed.xml"
    
---
{% assign postsByYear = site.posts | group_by_exp:"post", "post.date | date: '%Y'"  %}
{% for year in postsByYear %}
  <h2 id="{{ year.name | slugify }}" class="archive__subtitle">{{ year.name }}</h2>
  {% for post in year.items %}
    {% include archive-single.html %}
  {% endfor %}
{% endfor %}
