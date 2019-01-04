---
permalink: index2.html
layout: splash
classes:
    - landing
    - grid
# Texto que vai na home, sobre a foto (splash)
excerpt: "Página de teste, não tem nenhum link apontando para a mesma."
header:
    overlay_image: /assets/images/splash/index_bg.jpg
    overlay_filter: 0.5
    caption: "Photo by Blake Connally [**Unsplash**](https://unsplash.com/photos/B3l0g6HLxr8)"
    image_description: Photo by Blake Connally on Unsplash
    cta_label: "Conheça os autores"
    cta_url: "/sobre"
---
<div class="grid__wrapper">  
{% for post in site.posts %}
    {% include archive-single.html type="grid" %}
{% endfor %}

</div>