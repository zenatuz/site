#!/usr/bin/env bash
sudo yum -y install git
sudo systemctl stop firewalld
ip=`hostname -I`

gem install jekyll

cd /vagrant 

if [ ! -f _config.yml ]; then
	bundle exec jekyll new jekyll
fi

# Serving with Jekyll
bundle install
bundle exec jekyll build
bundle exec jekyll serve --incremental --h $ip --detach

# Serving with nginx
# sudo yum install -y nginx
# sudo setenforce permissive
# sudo mv /usr/share/nginx/html /usr/share/nginx/html.orig 
# sudo ln -s /vagrant/_site/ /usr/share/nginx/html
# sudo systemctl restart nginx
# sudo systemctl status nginx