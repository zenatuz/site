# Jekyll Personal blog
Blog criado em Jekyll baseado no tema [Minimal Mistakes](https://mmistakes.github.io/minimal-mistakes/).

## Requisitos
Jekyll é desenvolvido em ruby, logo além do ruby (v2 ou superior), estas gems são necessárias.

- Gems:
  - bundler
  - jekyll

```gem install bundler jekyll```

- Para instalar o Ruby no Subsistema Linux no Windows 10, siga as instruções no link: https://gorails.com/setup/windows/10#subsystem
- Para outros sitemas, consulte a documentação oficial: https://jekyllrb.com/docs/installation/

## Iniciando o Jekyll

### Utilizando o WSL

- Clone o projeto
- Entre no diretório do projeto: ```cd renatobatista.com.br```
- Instale as gems: ```bundle install```
- Inicie o serviço: 
  - ```bundle exec jekyll build```
  - ```bundle exec jekyll serve --watch```
- Abra o navegador em: [http://localhost:4000](http://localhost:4000)
- Para interromper digite: ```CTRL + C```

### Utilizando Docker

- Clone o projeto
- Entre no diretório do projeto: ```cd renatobatista.com.br```
- Inicie o docker: ```docker-compose up -d```
- Abra o navegador em: [http://localhost:4000](http://localhost:4000)
- Para interromper digite: ```docker-compose down```
> **Logs**: Caso queira acompanhar os logs, digite ```docker-compose logs -f```

## Autor
Renato Batista
- Site publicado em: [renatobatista.com.br](https://renatobatista.com.br)

## Status and License
[![Netlify Status](https://api.netlify.com/api/v1/badges/501815b2-6d41-4287-9b4b-feb7ccfb3b8b/deploy-status)](https://app.netlify.com/sites/stupefied-noether-79f45f/deploys)
[![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/mmistakes/minimal-mistakes/master/LICENSE.txt)