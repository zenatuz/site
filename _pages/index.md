---
permalink: index
layout: splash
title: "Um curioso"
classes:
    - landing
    - grid
# Texto que vai na home, sobre a foto (splash)
excerpt: "O espaço, a fronteira final. Estas são as anotações de um curioso, audaciosamente indo, onde nenhum homem jamais esteve."
header:
    overlay_image: /assets/images/splash/index_bg.jpg
    overlay_filter: 0.5
    caption: "Photo by Blake Connally [**Unsplash**](https://unsplash.com/photos/B3l0g6HLxr8)"
    image_description: Photo by Blake Connally on Unsplash
    cta_label: "Conheça o autor"
    cta_url: "/sobre"
---
<div class="grid__wrapper">  
{% for post in site.posts %}
    {% include archive-single.html type="grid" %}
{% endfor %}
</div>
