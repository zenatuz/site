---
permalink: index
layout: splash
title: "Um curioso mundo a fora"
classes:
    - landing
    # - grid
# Texto que vai na home, sobre a foto (splash)
excerpt: "O espaço, a fronteira final. Estas são as anotações de um curioso, audaciosamente indo, onde nenhum homem jamais esteve. <br /> <br />

Sou amante de tecnologia, café e RPG. Curioso e pronto pra encarar qualquer desafio. Como hobbies, videogames e jogos em geral tem um espaço reservado; livros, filmes e séries de ficção científica e fantasia são meus gêneros preferidos. ☕💻⚙️☁️🎮🕹️👾🎧📷 🇧🇷🐲🧝‍♂️🧙‍♂️🎲"

header:
    overlay_image: /assets/images/splash/index_bg.jpg
    overlay_filter: 0.5
    caption: "Photo by Blake Connally [**Unsplash**](https://unsplash.com/photos/B3l0g6HLxr8)"
    image_description: Photo by Blake Connally on Unsplash
    cta_label: "Conheça o autor"
    cta_url: "/sobre"

# feature_row:
#   - image_path: /assets/images/authors/renato_batista.jpg
#     alt: "Autor"
#     title: "Autor"
#     excerpt: "Este sou eu, um cara que curte TI e trabalha com café, bebe cerveja e água abcdef, ghij, vamos ver se vai mais rápido agora."
#     url: "/sobre"
#     btn_label: "Conheça o autor"
#     btn_class: "btn--inverse"


---

---
# Veja os últimos artigos:

<div class="grid__wrapper">  
{% for post in site.posts %}
    {% include archive-single.html type="grid" %}
{% endfor %}
</div>
