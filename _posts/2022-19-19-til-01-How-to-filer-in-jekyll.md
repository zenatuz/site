---
title: TIL 01 - How to filter in Jekyll
layout: single
permalink: /til/01
date: '2022-09-19'
tags:
  - til
  - today-i-learned
  - jekyll
  - liquid
classes: wide
author_profile: true

excerpt: "Today I Learned - How to filter in Jekyll"

header:
    overlay_image: /assets/images/splash/aaron-burden-6jYoil2GhVk-unsplash.jpg
    teaser: /assets/images/splash/aaron-burden-6jYoil2GhVk-unsplash.jpg
    # overlay_filter: 0.5
    caption: "Photo by Aaron Burden [**Unsplash**](https://unsplash.com/photos/6jYoil2GhVk)"
    image_description: Photo by Aaron Burden on Unsplash
--- 

# Today I Learned #01

Starting this series, I'll share a simple way to filter posts in `Jekyll`, which is the tool that I use to build this site.  

## **Today I learned** - How to filter in Jekyll

Jekyll uses `liquid` as a template language, so we can easily add some logic to our pages. This is an interesting way to share something on a specific subject, like this **Today I Learned** series.

The below example filter post by this tag `today-i-learned` and lists all the posts.

<script src="https://gist.github.com/zenatuz/fe677d010a3973d0103664bcaa0c26e0.js"></script>

### References

- [https://nobal.in/technology/how-to-filter-post-by-tags-in-jekyll/](https://nobal.in/technology/how-to-filter-post-by-tags-in-jekyll/)
- [https://jekyllrb.com/docs/plugins/tags/](https://jekyllrb.com/docs/plugins/tags/)
- [https://shopify.github.io/liquid/](https://shopify.github.io/liquid/)