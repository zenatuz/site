---
title: 'Usando um notebook antigo como segundo monitor no Windows'
layout: single
date: 2021-12-30
permalink: /blog/monitor-sem-fio
tags:
    - artigo
    - tecnologia
    - miracast
    - monitor
    - windows10
    - wireless-display

classes: 
    - wide
author: Renato Batista
excerpt: "Por que eu preciso de um Monitor sem Fio?"
header:
    overlay_image: assets/images/splash/miracast.jpg
    teaser: assets/images/splash/miracast.jpg
    overlay_filter: 0.5
    caption: "Miracast"
    image_description: Miracast

---
Recentemente eu me mudei para [Portugal](/blog/portugal-o-inicio){:target="_blank"}, e naturalmente uma mudança dessa envolve muitos custos, por conta disso to me segurando pra só comprar um monitor daqui uns meses. Assim para não ficar sem 1 tela adicional nesse período, resolvi fazer alguns testes para utilizar o laptop pessoal como segunda tela. Acabei descobrindo um recurso nativo no windows 10, que eu não conhecia. O **Wireless Display ou Vídeo sem fio**.

# Wireless Display / Vídeo sem fio
A tecnologia de vídeo sem fio não é nova, e existem vários projetos proprietários como [Airplay](https://www.apple.com/airplay/){:target="_blank"} da Apple ou o [GoogleCast](https://developers.google.com/cast){:target="_blank"} do Google, e também existe um protocolo mantido pela **Wi-fi Alliance** desde 2012 que é o [Miracast](https://en.wikipedia.org/wiki/Miracast){:target="_blank"}, que a premissa é funcionar como um cabo HDMI, mas sem Fio, usando [Wifi direct](https://www.wi-fi.org/discover-wi-fi/wi-fi-direct){:target="_blank"}, que nada mais é uma forma de um equipamento se conectar diretamente a outro , sem passar pelo roteador, uma conexão ad-hoc. 

Estes não são os únicos protocolos existentes, aqui pode ver uma lista com mais competidores, [https://www.howtogeek.com/](https://www.howtogeek.com/177145/wireless-display-standards-explained-airplay-miracast-widi-chromecast-and-dlna/){:target="_blank"}.

# Por que escolhi o Miracast?
Escolhi o Miracast simplesmente por ser um protocolo já implementado no Windows 10, e por não precisar comprar nada, seja hardware ou licença pra software.

Esta é uma feature do windows 10/11, que não vem instalado por padrão, porém sua instalação é bem simples. Para instalar, veja este link: https://www.thewindowsclub.com/add-and-remove-wireless-display-feature-in-windows-10

Depois de instalado, o computador 2 vai funcionar como host, que receberá a conexão do computador 1, podendo assim duplicar a tela 1 para a 2, ou mesmo estender, de forma que terei 2 monitores, da mesma forma que acontece quando uso um cabo.

# Como utilizar?

## No computador destino, que será a segunda tela (PC 02)
Clique no Iniciar > Configurações > Sistema > Projetando neste computador **(1)**

Habilite as configurações necessárias para que o serviço possa ser iniciado, **(2 a 5)**, por fim clique na opção **Inicie o aplicativo Conectar para projetar neste computador (6)** .

![image](/assets/images/posts/miracast_01.png){: width="650" }

Depois de iniciar o aplicativo, será exibido essa tela no **PC 02**:

![image](/assets/images/posts/miracast_02.png){: width="450" }


## No computador principal (PC 01)
Depois que já tiver o aplicativo iniciado no **PC 02**, volte ao **PC 01**, pressione **CTRL + K**, será aberto então uma busca por dispositivos disponíveis para conexão na rede.

Será exibido 1 ou mais dispositivos aqui, escolha o nome que aparece na tela do **PC 02**.

![image](/assets/images/posts/miracast_03.png)

Ao clicar, se tiver com o PIN ativado, será solicitado. O Pin será exibido no **PC 02**.

![image](/assets/images/posts/miracast_04.png)

Se tudo correu bem, você verá essa barra no **PC 01**.

![image](/assets/images/posts/miracast_05.png)

O segundo monitor será exibido como um monitor normal, como se estivesse conectado por cabo nas opções de Vídeo do Windows.

![image](/assets/images/posts/miracast_06.png)

Agora, basta fazer o arranjo que quiser, entre as opções disponíveis como **Duplicar** ou **Estender**. No meu caso, eu sempre uso como **Estender**, para que tenha uma tela adicional para trabalho.

![image](/assets/images/posts/miracast_07.png)

Após finalizar, desconecte-se do monitor usando 1 das formas a seguir:

  1 - Clicar na opção no topo da tela no **PC 01**,
  
  ![image](/assets/images/posts/miracast_05.png)

  2 - Clicar em **CTRL + K** e desconectar do monitor sem fio.

  ![image](/assets/images/posts/miracast_08.png)

Pronto, agora pode dar uma sobrevida a um computador antigo e ter uma segunda tela, gastar uma grana extra com isso.

> NOTA: Esta funcionalidade também existe em várias TVs mais recentes, se for o seu caso, também pode utilizar sua TV como segunda tela.