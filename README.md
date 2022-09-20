# Jekyll based personal blog
This blog is created in Jekyll based on the theme [Minimal Mistakes](https://mmistakes.github.io/minimal-mistakes/).

## Requirements

### Ruby
- To install Ruby on Linux Subsystem on Windows, follow the instructions on the link: https://gorails.com/setup/windows/10#subsystem
- For other systems, see the official documentation : https://jekyllrb.com/docs/installation/

### Gems
Jekyll is developed in ruby (v2 or higher), these gems are required. 

- Gems:
  - bundler
  - jekyll

```gem install bundler jekyll```

## Starting Jekyll
### Using with WSL

- Clone the project 
- Enter the project directory : ```cd renatobatista.com.br```
- Install the gems : ```bundle install```
- Start the service :
- ```bundle exec jekyll serve --host 0.0.0.0 --force-polling --watch --incremental --livereload```
- Open the browser on: [http://localhost:4000](http://localhost:4000)
- To interrupt type: ```CTRL + C```

### Using with Docker

- Clone the project 
- Enter the project directory : ```cd renatobatista.com.br```
- Start the container: ```docker-compose up -d```
- Open the browser on: [http://localhost:4000](http://localhost:4000)
- To interrupt type: ```docker-compose down```
> **Logs**: To follow the logs, type ```docker-compose logs -f```

## Live
This website is automatically published using Netlify in [renatobatista.com.br](https://renatobatista.com.br).

If you are interested in doing something similar on your own, check this link: https://www.netlify.com/blog/2020/04/02/a-step-by-step-guide-jekyll-4.0-on-netlify/

## Status and License
[![Netlify Status](https://api.netlify.com/api/v1/badges/501815b2-6d41-4287-9b4b-feb7ccfb3b8b/deploy-status)](https://app.netlify.com/sites/renatobatista/deploys)
[![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/mmistakes/minimal-mistakes/master/LICENSE.txt)