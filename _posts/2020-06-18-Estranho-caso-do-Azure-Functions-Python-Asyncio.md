---
title: 'O estranho caso do Azure Functions: Python com async'
layout: single
date: 2020-06-18
permalink: /blog/:year-:month-:day-:title
tags:
    - artigo
    - azure
    - functions
    - devops
classes: 
    - wide
author: Renato Batista
excerpt: "Como sofrer para realizar deploys no Azure Functions utilizando Python"
header:
    overlay_image: assets/images/splash/kevin-horvat-Pyjp2zmxuLk-unsplash.jpg
    teaser: assets/images/splash/kevin-horvat-Pyjp2zmxuLk-unsplash.jpg
    overlay_filter: 0.5
    caption: "Photo by Kevin Horvat on [**Unsplash**](https://unsplash.com/photos/Pyjp2zmxuLk)"
    image_description: Photo by Kevin Horvat on Unsplash

---
# Um pouco de contexto
Estamos migrando aqui na empresa nosso ambiente de nuvem, saindo da AWS, indo para a Azure, com isso, várias adaptações são necessárias pra deixar tudo redondo. 
Um dos recursos que utilizamos na AWS são as Lambdas, que precisamos portar para Azure, essas lambdas irão para o serviço Functions.

Dentro do functions existem alguns tipos de Tiers, devido a necessidade de conectar a recursos internos como APIs e DB, o que melhor nos atendeu foi o [Premium Plan](https://docs.microsoft.com/en-us/azure/azure-functions/functions-premium-plan){:target="_blank"}.

Seguindo a documentação do [Quickstart](https://docs.microsoft.com/en-us/azure/azure-functions/functions-create-first-function-vs-code?pivots=programming-language-python){:target="_blank"}, tudo correu bem.
O problema começou quando portamos nosso código, que funciona perfeitamenta localmente, mas quando enviamos para deploy um erro genérico acontecia.

O código não é nada de outro mundo, veja:
## Trecho de código python utilizado

```python
def main(req: func.HttpRequest) -> func.HttpResponse:
    event = req.get_json()
    logging.info(f'createRequestItem: {event}')
    # parametros obrigatorios
    test = testObrigatorios(event)
    if (test["sucesso"]):
        stopwatch = Stopwatch()
        loop = asyncio.new_event_loop()
        asyncio.set_event_loop(loop)
        retFunc = loop.run_until_complete(servicenow.createRequest(event))
        # retFunc = servicenow.createRequest(event)
        tempo = str(stopwatch)
        retFunc["duracao"] = tempo
        ret = retFunc
        return func.HttpResponse(json.dumps(ret), mimetype="application/json")
    else:
        return func.HttpResponse(json.dumps(test), mimetype="application/json")
```

Este é o **requirements** gerado para este e outros códigos que fazem parte do pacote:

```python
azure-functions==1.2.1
PyMySQL==0.9.3
azure-storage-blob==12.3.2
stopwatch.py==1.0.1
xmltodict==0.12.0
yattag==1.13.2
requests==2.23.0
asyncio==3.4.3
```

# O erro no deploy

Depois de muito bater cabeça, precisei abrir um ticket no suporte, pra entender o porquê do deploy não se completar. Papo vai, papo vem com a engenheira, e nada.

Até que analisando melhor logs do deploy, consegui encontrar o log da criação da imagem docker, que o functions cria no momento do deploy.

O erro acontecia quando ele instalava a lib **asyncio** via PIP, como pode ser visto:.
## Log de erro
```shell
...
2020-06-16T18:35:17.087234270Z           import asyncio
2020-06-16T18:35:17.088550722Z [40m[32minfo[39m[22m[49m: Host.Function.Console[0]
2020-06-16T18:35:17.088567423Z         File "/home/site/wwwroot/.python_packages/lib/site-packages/asyncio/__init__.py", line 21, in <module>
2020-06-16T18:35:17.090280992Z [40m[32minfo[39m[22m[49m: Host.Function.Console[0]
2020-06-16T18:35:17.090298593Z           from .base_events import *
2020-06-16T18:35:17.092192769Z [40m[32minfo[39m[22m[49m: Host.Function.Console[0]
2020-06-16T18:35:17.092209669Z         File "/home/site/wwwroot/.python_packages/lib/site-packages/asyncio/base_events.py", line 296
2020-06-16T18:35:17.097654888Z [40m[32minfo[39m[22m[49m: Host.Function.Console[0]
2020-06-16T18:35:17.097747992Z           future = tasks.async(future, loop=self)
2020-06-16T18:35:17.099827375Z [40m[32minfo[39m[22m[49m: Host.Function.Console[0]
2020-06-16T18:35:17.099844476Z                          ^
2020-06-16T18:35:17.101305835Z [40m[32minfo[39m[22m[49m: Host.Function.Console[0]
2020-06-16T18:35:17.101323036Z       SyntaxError: invalid syntax
...
```

Veja que a mensagem de erro é genérica e não diz muita coisa, **SyntaxError: invalid syntax**, porém a sintaxe do código está ok, tanto é que rodava localmente.

Pra ficar ainda mais estranho, criamos um novo Function, com o **Tier Standard**, e o mesmo código funcionou normalmente.

# A resolução

Ficamos mais algum tempo debugando e testando, até que um dos Devs resolveu remover o asyncio dos requisitos no *requirements.txt*, **et voilà**. Tudo passou a funcionar perfeitamente no deploy.

Informamos e demonstramos a estranha descoberta ao time da Microsoft, que está trabalhando no caso. 