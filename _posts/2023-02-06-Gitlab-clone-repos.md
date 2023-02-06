---
title: How to clone a bunch of repositories from any Gitlab server
layout: single
permalink: /blog/gitlab-clone-repos
date: '2023-02-06'
tags:
  - shell
  - gitlab
  - api
classes: wide
author_profile: true

excerpt: "How to clone a bunch of repositories from any Gitlab server"

header:
    overlay_image: /assets/images/splash/pankaj-patel-ZV_64LdGoao-unsplash.jpg
    teaser: /assets/images/splash/pankaj-patel-ZV_64LdGoao-unsplash.jpg
    # overlay_filter: 0.5
    caption: "Photo by Aaron Burden [**Unsplash**](https://unsplash.com/photos/ZV_64LdGoao)"
    image_description: Photo by Pankaj Patel on Unsplash
  
--- 

# Starting from the beginning

Recently I broke my work computer by accident, unfortunelly it neeed to be sent to an apple store to replace the screen. 😱

In the meanwhile I received a temporary computer with no information at all.
As I should keep working as expected, I needed to clone a bunch of repository from gitlab to my new temp machine.

In order to keep things easy to do in the future, I created this script to do the hard work.

Feel free to use it. ;)

## Explaining how it works

It will be necessary 3 things:

- 1 - The `gitlab url server`
- 2 - The `gitlab personal access token`
- 3 - The `gitlab group ID`

### Gitlab URL server

It could be any public/private server, if you use the <https://gitlab.com>, no change is necessary.
For any other gitlab server, the value should be provided to the script in this variable: `GITLAB_URL`.

### Gitlab Personal Token

Gitlab provides a `personal access token` to use with its API.
The official documentation can be followed to configure your token. <https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html>.

> Pay attention to never share this token anywhewe, if possible keep it in a sabe and use it as a `ENV_VARIABLE` in your own machine only.

Once you have a valid token, it should be provided to the script in this variable: `GITLAB_TOKEN`

### Gitlab Group ID

In Gitlab each group receives an ID, the idea behind this script is to use this ID to clone all the child repositories in this given group.

To get the group ID, open any group in the gitlab dashboard. The `Group ID` will be displayed bellow the group name, as in this example.

![image](/assets/images/posts/gitlab-group.jpg)


Once you have the Group ID it should be provided to script in this parameter `-g ID`

## Running the script

### Script

The script is available and updated at this repo: <https://github.com/zenatuz/utils>. Feel free to submit some improvement.

Once you have all the information needed, you should run the script like this:

```bash
GITLAB_TOKEN="glpat-rWszQS6t9PWX-bWAg25x" ./gitlab-clone-repos.sh -g 63473124
```

This is how the script should run:

<script id="asciicast-TafguHQpLQRFRLwzdYiYSMAx5" src="https://asciinema.org/a/TafguHQpLQRFRLwzdYiYSMAx5.js" async></script>

What do you think? It's much better than clone one-by-one right? ;) 
