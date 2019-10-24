#!/bin/bash

# Disable SELINUX
sudo setenforce 0

# Install Pre-req
sudo yum install -y gcc-c++ patch readline readline-devel zlib zlib-devel \
   libyaml-devel libffi-devel openssl-devel make \
   bzip2 autoconf automake libtool bison iconv-devel sqlite-devel git

# Install RVM
curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
curl -sSL https://rvm.io/pkuczynski.asc | gpg2 --import -
curl -L get.rvm.io | bash -s stable

source /home/vagrant/.rvm/scripts/rvm
rvm reload

# Install Ruby
rvm install 2.6
rvm use 2.6 --default

# Install Jekyll
gem install bundler jekyll

# Preparando o Jekyll
cd /vagrant
bundle install

# Executando o Jekyll
bundle exec jekyll build --incremental
bundle exec jekyll serve --incremental --host=0.0.0.0 --watch