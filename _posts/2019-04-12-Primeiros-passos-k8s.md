---
title: 'Primeiros Passos no K8S'
layout: single
date: 2019-04-12
permalink: /blog/k8s-primeiros-passos
tags: 
    - artigo
    - devops
    - kubernetes
    - k8s
classes: 
    - wide
author: Renato Batista
excerpt: "Primeiros passos: Preparando o ambiente de forma automatizada com Ansible"
header:
    overlay_image: /assets/images/splash/dan-kb-FNTEEZpNI5E-unsplash.jpg
    teaser: /assets/images/splash/dan-kb-FNTEEZpNI5E-unsplash.jpg
    overlay_filter: 0.5
    caption: "Photo by Dan Kb [**Unsplash**](https://unsplash.com/photos/FNTEEZpNI5E)"
    image_description: Photo by Dan Kb on Unsplash

render_with_liquid: false
---

# Primeiros passos com Kubernetes
Se você chegou aqui de para-quedas, saiba que esta é uma série de artigos com uma abordagem simples para quem quer entrar no mundo do Kubernetes (k8s), irei cobrir desde instalação básica a componentes internos, deploys, etc.

> Nota: **Conhecimento em Sistemas Operacionais, Redes, ferramentas como Ansible são requisitos, portanto não explicarei esses conceitos.**

## O que é Kubernetes
A documentação oficial diz que:  *Kubernetes (K8s) é um produto Open Source utilizado para automatizar a implantação, o dimensionamento e o gerenciamento de aplicativos em contêiner.* 

Na minha visão e tentando explicar para quem não conhece, digo isso: **É um orquestador de containers. Como orquestrador, ele é a camada que provê os recursos operacionais para o ambiente como rede, storage, load balancer, deploys, etc.**

Para maiores detalhes, consulte [kubernetes.io/pt](https://kubernetes.io/pt/).

> **Update** - O pessoal do hispsters.tech fez um podcast recente sobre kubernetes, bom proveito. [Kubernetes – Hipsters #177](https://hipsters.tech/kubernetes-hipsters-177/)

<iframe width="320" height="30" src="https://hipsters.tech/?powerpress_embed=2799-podcast&amp;powerpress_player=mediaelement-audio" frameborder="0" scrolling="no"></iframe>

## Preparando o ambiente
Recentemente, precisei subir alguns clusteres de k8s, e para tanto, criei alguns playbooks ansible para me auxiliar no processo de instalar e configurar os hosts. Depois de instalado, criei um template da VM, e utilizei esse template para criar novas VMs.

> *Alguns requisitos de infra são necessários, como a resolução de nome (DNS).* 

> *Para o ambiente de laboratório, podemos utilizar o arquivo /etc/hosts. Em produção, é requisito um serviço DNS com todas as entradas necessárias.*

### Ambiente do Laboratório

Neste cenário utilizei o seguinte ambiente: 
- **Centos 8** como SO base;
- **Hyper-V** como hypervisor;
- **Ansible** como método de instalação/configuração;
- **Kubernetes 1.16**.

### Playbooks para instalação automatizada
#### Pre requisitos

A fim de facilitar o processo, criei 2 playbooks para ansible que podem ser vistos abaixo, ou baixados de: [https://github.com/zenatuz/k8s-playbooks-conf](https://github.com/zenatuz/k8s-playbooks-conf).

> ~~Por algum motivo que desconheço, o Jekyll não está exibindo as variáveis do Ansible, portanto, baixe o código do github ao invés de copiar daqui.~~ *UPDATE*, resolvi o problema da formatação, usando ``highlith yaml`` e ``raw``. 

O primeiro playbook instala alguns requisitos e prepara o ambiente para a instalação do Kubernetes, dentre os requisitos, estão a **container-engine** (nesse exemplo: *Docker*)

Playbook: **```pre-req.yml```**
{% highlight yaml %}
{% raw %}
# Ansible Playbook: pre-req.yml
---
- hosts: all
  tasks:

    - name: Enable EPEL
      yum: 
        name: epel-release
        state: latest
    
    - name: Ensure packages are installed
      yum: 
        name: '{{ packages }}'
        update_cache: yes 
        state: latest
      vars:
        packages:
        - wget
        - git
        - net-tools
        - vim
        - curl
        - htop
        - tmux
        - yum-utils
        - device-mapper-persistent-data
        - lvm2
        - pigz
        - nfs-utils
        - drpm
        - chrony

    - name: Enable Chrony
      service:
          name: chronyd
          enabled: true
          state: started

    - name: Enable Docker Repo
      get_url:
        url: https://download.docker.com/linux/centos/docker-ce.repo
        dest: /etc/yum.repos.d/docker-ce.repo

    - name: Install Docker packages
      yum: 
        name: docker-ce-18.06.2.ce 
        update_cache: yes 
        state: present

    - name: Creating /etc/docker directory
      file:
        path: /etc/docker
        state: directory

    - name: Set daemon.json (/etc/docker)
      blockinfile:
        path: /etc/docker/daemon.json
        create: yes
        marker: ""
        block: |
          {
            "exec-opts": ["native.cgroupdriver=systemd"],
            "log-driver": "json-file",
            "log-opts": {
              "max-size": "100m"
            },
            "storage-driver": "overlay2",
            "storage-opts": [
              "overlay2.override_kernel_check=true"
            ]
          }

    - name: Remove blank lines blockinfile put in
      lineinfile :
        path: /etc/docker/daemon.json
        state: absent
        regexp: '^$'

    - name: Creating /etc/systemd/system/docker.service.d
      file:
        path: /etc/systemd/system/docker.service.d
        state: directory

    - name: Force systemd to re-execute itself
      systemd:
        daemon_reexec: yes

    - name: Start and Enable Docker-Service on boot
      service:
        name: docker
        enabled: yes
        state: started
{% endraw %}
{% endhighlight %}

#### Instalação

O segundo playbook instala o Kubernetes em si.

Playbook: **```install.yml```**

{% highlight yaml %}
{% raw %}
# Ansible Playbook: install.yml
---
- hosts: all
  tasks:
    - name: Creating kubernetes repository file
      file:
        path: "/etc/yum.repos.d/kubernetes.repo"
        state: touch

    - name: Enable K8S Repository
      blockinfile:
        path: /etc/yum.repos.d/kubernetes.repo
        marker: ""
        block: |
          [kubernetes]
          name=Kubernetes
          baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
          enabled=1
          gpgcheck=1
          repo_gpgcheck=1
          gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg

    - name: Remove blank lines blockinfile put in
      lineinfile :
        path: /etc/yum.repos.d/kubernetes.repo
        state: absent
        regexp: '^$'

    - name: Set SELinux in permissive mode (effectively disabling it)
      selinux:
        policy: targeted
        state: permissive

    - name: Install Kubernetes packages
      yum: 
        name: "{{ packages }}" 
        update_cache: yes 
        state: present
      vars:
        packages:
        - kubelet-1.16.0-0
        - kubeadm-1.16.0-0
        - kubectl-1.16.0-0

    - name: Disable Firewalld
      service:
        name: firewalld
        state: stopped
        enabled: no
        masked: yes

    - name: Disable SWAP since kubernetes can't work with swap enabled
      command: swapoff -a

    - name: Remove SWAP - Remove from /etc/fstab
      mount:
        name: swap
        fstype: swap
        state: absent   

    - name: Enable routing (net.ipv4.ip_forward)
      sysctl:
        name: net.ipv4.ip_forward
        value: "1"
        sysctl_set: yes
        state: present
        reload: yes

    - name: Set bridge-nf-call-{iptables,ip6tables} to 1
      sysctl:
        name: "{{ item }}"
        value: "1"
        sysctl_set: yes
        state: present
        reload: yes
      with_items:
        - net.bridge.bridge-nf-call-ip6tables
        - net.bridge.bridge-nf-call-iptables
  
    - name: just force systemd to re-execute itself
      systemd:
        daemon_reexec: yes
        daemon_reload: yes

    - name: Add docker and kubernetes packages to YUM Blacklist
      lineinfile:
        path: /etc/yum.conf
        line: exclude=kubeadm kubelet kubectl kubernetes-cni docker-ce
        create: yes

    - name: Enable Kubelet service
      service:
          name: kubelet
          enabled: true

{% endraw %}
{% endhighlight %}

Para executar os playbooks, crie um arquivo de inventário apontando os hosts onde fará a instalação.

Arquivo de inventário utilizado no exemplo: **(hosts.ini)**

{% highlight ini %}
{% raw %}
[k8s_template]
192.168.45.216 ansible_user=root
{% endraw %}
{% endhighlight %}

Em seguida, execute os playbooks:

{% highlight bash %}
{% raw %}
ansible-playbook -i hosts.ini pre-req.yml
ansible-playbook -i hosts.ini install.yml
{% endraw %}
{% endhighlight %}

Ao final, depois de executar os 2 playbooks, você terá um ambiente pronto para instalar o K8S utilizando o *kubeadm*.

> Written with [StackEdit](https://stackedit.io/).