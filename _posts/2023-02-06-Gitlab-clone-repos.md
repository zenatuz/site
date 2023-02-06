---
title: How clone multiple repositories from any Gitlab server
layout: single
permalink: /blog/gitlab-clone-repos
date: '2023-02-06'
tags:
  - shell
  - gitlab
  - api
classes: wide
author_profile: true

excerpt: "How clone multiple repositories from any Gitlab server"

header:
    overlay_image: /assets/images/splash/pankaj-patel-ZV_64LdGoao-unsplash.jpg
    teaser: /assets/images/splash/pankaj-patel-ZV_64LdGoao-unsplash.jpg
    # overlay_filter: 0.5
    caption: "Photo by Aaron Burden [**Unsplash**](https://unsplash.com/photos/ZV_64LdGoao)"
    image_description: Photo by Pankaj Patel on Unsplash
  
--- 

# From the beginning

Recently I accidentally broke my work computer, unfortunately it had to be sent to an Apple store to replace the screen. 😱

In the meantime, I received a temporary computer without any information. As I was expected to continue working, I had to clone a number of repositories from Gitlab to my new temporary computer.

To keep things simple in the future, I created this script to do the hard work.

Feel free to use it ;)

## Explain how it works

It will be necessary 3 things:

- 1 - The `gitlab url server`
- 2 - The `gitlab personal access token`
- 3 - The `gitlab group ID`

### Gitlab URL server

It can be any public/private server, if you use the <https://gitlab.com>, no change is needed.
For any other Gitlab server, the value should be passed to the script in this variable: `GITLAB_URL`.

### Gitlab Personal Token

Gitlab provides a `personal access token` that can be used with its API. The official documentation can be consulted to configure your token. <https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html>.

> Make sure you never share this token, but keep it in a safe (bitwarden, 1password or some other kind) and use it as `ENV _VARIABLE` only in your own machine.

Once you have a valid token, you should provide it to the script in this variable: `GITLAB_TOKEN`.

### Gitlab Group ID

In Gitlab, each group is given a ID. The idea behind this script is to use this ID to clone all child repositories in that group.

To get the `Group ID`, open any group in the Gitlab Dashboard. Under the group name, you will see the `Group ID`, as in this example.

![image](/assets/images/posts/gitlab-group.jpg)

Once you have the Group ID, you should pass it to the script with the `-g ID` parameter.

## Execute the script

### Script

The script is available and updated in this repo: <https://github.com/zenatuz/utils>. Feel free to submit improvements.

Once you have all the information you need, you should run the script as follows:

```bash
GITLAB_TOKEN="glpat-rWszQS6t9PWX-bWAg25x" ./gitlab-clone-repos.sh -g 63473124
```

This is how the script should run:

<script id="asciicast-TafguHQpLQRFRLwzdYiYSMAx5" src="https://asciinema.org/a/TafguHQpLQRFRLwzdYiYSMAx5.js" async></script>

What do you think? This is much better than one clone after another, is not it? ;)
