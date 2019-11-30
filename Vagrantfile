Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.hostname = "jekyll-dev"
  config.vm.network "forwarded_port", guest: 4000, host: 4000, protocol: "tcp"
  config.vm.provision "shell", path: "scripts/vagrant-init.sh", privileged: false
  config.ssh.forward_agent = true
end