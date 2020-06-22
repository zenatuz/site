---
title: 'Docker Stats'
layout: single
date: 2020-02-26
permalink: /blog/:year-:month-:day-:title
tags: 
    - artigo
    - docker
    - containers
    - devops
classes: 
    - wide
author: Renato Batista
excerpt: "Docker Ps e Docker Stats em detalhes"
header:
    overlay_image: /assets/images/splash/frank-mckenna-tjX_sniNzgQ-unsplash.jpg
    teaser: /assets/images/splash/frank-mckenna-tjX_sniNzgQ-unsplash.jpg
    overlay_filter: 0.5
    caption: "Photo by Frank Mckenna [**Unsplash**](https://unsplash.com/collections/4839205/docker-illustrations)"
    image_description: Photo by Frank Mckenna
comments: true
---
# Docker Containers
Parte da administração de TI, envolve saber como obter métricas de utilização dos recursos.

Com docker não seria diferente, tanto que a própria CLI já disponibiliza comandos interessantes como ``docker info, docker ps, docker stats``. 

## Docker Info
O ``docker info``  exibe informações gerais do sistema, como detalhes do host, Containers (criados, em execução, em pausa, parados), imagens, versão do cliente e servidor, storage, plugins, kernel, SO, arquitetura, registries, etc.

Detalhes podem ser visto na documentação oficial: [https://docs.docker.com/engine/reference/commandline/info/](https://docs.docker.com/engine/reference/commandline/info/)

{% highlight bash %}
{% raw %}
$ docker info
Client:
 Debug Mode: false

Server:
 Containers: 14
  Running: 3
  Paused: 1
  Stopped: 10
 Images: 52
 Server Version: 1.10.3
 Storage Driver: devicemapper
  Pool Name: docker-202:2-25583803-pool
  Pool Blocksize: 65.54 kB
  Base Device Size: 10.74 GB
  Backing Filesystem: xfs
  Data file: /dev/loop0
  Metadata file: /dev/loop1
  Data Space Used: 1.68 GB
  Data Space Total: 107.4 GB
  Data Space Available: 7.548 GB
  Metadata Space Used: 2.322 MB
  Metadata Space Total: 2.147 GB
  Metadata Space Available: 2.145 GB
  Udev Sync Supported: true
  Deferred Removal Enabled: false
  Deferred Deletion Enabled: false
  Deferred Deleted Device Count: 0
  Data loop file: /var/lib/docker/devicemapper/devicemapper/data
  Metadata loop file: /var/lib/docker/devicemapper/devicemapper/metadata
  Library Version: 1.02.107-RHEL7 (2015-12-01)
 Execution Driver: native-0.2
 Logging Driver: json-file
 Plugins:
  Volume: local
  Network: null host bridge
 Kernel Version: 3.10.0-327.el7.x86_64
 Operating System: Red Hat Enterprise Linux Server 7.2 (Maipo)
 OSType: linux
 Architecture: x86_64
 CPUs: 1
 Total Memory: 991.7 MiB
 Name: ip-172-30-0-91.ec2.internal
 ID: I54V:OLXT:HVMM:TPKO:JPHQ:CQCD:JNLC:O3BZ:4ZVJ:43XJ:PFHZ:6N2S
 Docker Root Dir: /var/lib/docker
 Debug Mode: false
 Username: gordontheturtle
 Registry: https://index.docker.io/v1/
 Insecure registries:
  myinsecurehost:5000
  127.0.0.0/8
{% endraw %}
{% endhighlight %}

## Docker PS
O ``docker ps`` exibe os containers que foram executados ou estão em execução, alguns filtros comuns são ``docker ps`` e ``docker ps -a``.

### Containers em execução

{% highlight bash %}
{% raw %}
$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                    NAMES
c5a675bae310        dotnetapp:latest    "/bin/sh -c 'set ASP…"   44 minutes ago      Up 44 minutes       0.0.0.0:85->80/tcp       goofy_ptolemy
43e87fb642cd        dotnetapp:latest    "/bin/sh -c 'set ASP…"   44 minutes ago      Up 44 minutes       0.0.0.0:84->80/tcp       quirky_kare
20c9d631a656        dotnetapp:latest    "/bin/sh -c 'set ASP…"   44 minutes ago      Up 44 minutes       0.0.0.0:83->80/tcp       compassionate_elbakyan
9780a8fbe01a        dotnetapp:latest    "/bin/sh -c 'set ASP…"   44 minutes ago      Up 44 minutes       0.0.0.0:82->80/tcp       fervent_bardeen
c4c270bd00ec        dotnetapp:latest    "/bin/sh -c 'set ASP…"   44 minutes ago      Up 44 minutes       0.0.0.0:81->80/tcp       stoic_spence
6db1edb539c8        mlcanhoto:latest    "/bin/sh -c 'python …"   2 weeks ago         Up 2 weeks          0.0.0.0:8443->8443/tcp   suspicious_lovelace
{% endraw %}
{% endhighlight %}

### Todos os containers, inclusive os parados

{% highlight bash %}
{% raw %}
$ docker ps -a
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                                PORTS                    NAMES
65a263e3ec8a        dotnetapp:latest    "/bin/sh -c 'set ASP…"   4 seconds ago       Up 3 seconds                          0.0.0.0:84->80/tcp       hopeful_ardinghelli
c5a675bae310        dotnetapp:latest    "/bin/sh -c 'set ASP…"   45 minutes ago      Exited (134) Less than a second ago                            goofy_ptolemy
43e87fb642cd        dotnetapp:latest    "/bin/sh -c 'set ASP…"   45 minutes ago      Exited (134) 4 seconds ago                                     quirky_kare
20c9d631a656        dotnetapp:latest    "/bin/sh -c 'set ASP…"   45 minutes ago      Exited (134) 1 second ago                                      compassionate_elbakyan
9780a8fbe01a        dotnetapp:latest    "/bin/sh -c 'set ASP…"   45 minutes ago      Up 45 minutes                         0.0.0.0:82->80/tcp       fervent_bardeen
c4c270bd00ec        dotnetapp:latest    "/bin/sh -c 'set ASP…"   45 minutes ago      Exited (134) 2 seconds ago                                     stoic_spence
6db1edb539c8        mlcanhoto:latest    "/bin/sh -c 'python …"   2 weeks ago         Up 2 weeks                            0.0.0.0:8443->8443/tcp   suspicious_lovelace
{% endraw %}
{% endhighlight %}

### Filtros
Existem situações que filtros nos ajudam muito para identificar informações chaves referentes aos containers, para tanto, o comando possui uma flag ``--format`` que te permite adaptar e filtrar a saída de acordo com a sua necessidade.

No exemplo abaixo, eu utilizei a opção ``--format`` para me exibir o Container ID, a Imagem e o tempo de execução dos containers:

{% highlight bash %}
{% raw %}
$ docker ps --format "table {{.ID}}\t{{.Image}}\t{{.RunningFor}}"
CONTAINER ID        IMAGE               CREATED
c5a675bae310        dotnetapp:latest    11 minutes ago
43e87fb642cd        dotnetapp:latest    11 minutes ago
20c9d631a656        dotnetapp:latest    11 minutes ago
9780a8fbe01a        dotnetapp:latest    11 minutes ago
c4c270bd00ec        dotnetapp:latest    11 minutes ago
6db1edb539c8        mlcanhoto:latest    2 weeks ago
{% endraw %}
{% endhighlight %}

### Documentação oficial:
[https://docs.docker.com/engine/reference/commandline/ps/#formatting](https://docs.docker.com/engine/reference/commandline/ps/#formatting)

## Docker Stats
O ``docker stats`` por sua vez, mostra consumo de recurso de cada container. 

> **Nota**: *Um parâmetro interessante é o ``--no-stream`` que exibe o consumo atual no momento da execução, se o parâmetro não for fornecido, ele é atulizado em tempo real.*

{% highlight bash %}
{% raw %}
$ docker stats --no-stream
CONTAINER ID        NAME                     CPU %               MEM USAGE / LIMIT     MEM %               NET I/O             BLOCK I/O           PIDS
c5a675bae310        goofy_ptolemy            0.27%               240.3MiB / 7.503GiB   3.13%               63.1MB / 1.07MB     0B / 0B             0
43e87fb642cd        quirky_kare              0.03%               251.8MiB / 7.503GiB   3.28%               89.1MB / 1.18MB     0B / 0B             0
20c9d631a656        compassionate_elbakyan   0.02%               189.1MiB / 7.503GiB   2.46%               52.3MB / 1.06MB     0B / 0B             0
9780a8fbe01a        fervent_bardeen          0.03%               172.1MiB / 7.503GiB   2.24%               22.1MB / 981kB      0B / 0B             0
c4c270bd00ec        stoic_spence             1.18%               180.2MiB / 7.503GiB   2.35%               42.4MB / 974kB      0B / 0B             0
6db1edb539c8        suspicious_lovelace      0.60%               2.107GiB / 7.503GiB   28.08%              151MB / 191MB       11.3MB / 0B         0
{% endraw %}
{% endhighlight %}

Neste exemplo, eu consigo observar alguns valores e remover outros. Utilizando alguns parâmetros.

{% highlight bash %}
{% raw %}
$ docker stats --no-stream --format "table {{.Container}}\t{{.CPUPerc}}\t{{.MemPerc}}\t{{.NetIO}}\t{{.BlockIO}}"
CONTAINER           CPU %               MEM %               NET I/O             BLOCK I/O
c5a675bae310        0.02%               1.94%               16.8MB / 195kB      0B / 0B
43e87fb642cd        0.02%               2.11%               30.5MB / 214kB      0B / 0B
20c9d631a656        0.02%               1.90%               15.3MB / 192kB      0B / 0B
9780a8fbe01a        0.02%               1.64%               8.45MB / 195kB      0B / 0B
c4c270bd00ec        0.02%               1.79%               15.2MB / 102kB      0B / 0B
6db1edb539c8        0.61%               28.08%              151MB / 191MB       11.3MB / 0B
{% endraw %}
{% endhighlight %}

### Documentação oficial:
[https://docs.docker.com/engine/reference/commandline/stats/#formatting](https://docs.docker.com/engine/reference/commandline/stats/#formatting)