 #!/usr/bin/env bash
 
# Install RVM so we can run a recent version of Jekyll.
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
\curl -sSL https://get.rvm.io | bash -s stable --ruby --gems=bundler,jekyll

echo ""
echo ""
echo ""
# Carregando variáveis de ambiente
source /home/vagrant/.rvm/scripts/rvm
echo ""
echo ""
echo ""
# Create a new Jekyll site if one does not already exists
cd /vagrant 

if [ ! -f _config.yml ]; then
	bundle exec jekyll new jekyll
fi

# Run Jekyll, accessible on the host machine
bundle install
bundle exec jekyll serve --force_pooling --incremental --detach --host=0.0.0.0