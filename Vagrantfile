# vi: set ft=ruby :
# -*- mode: ruby -*-

Vagrant.configure(2) do |config|
	config.vm.box = "plus3it/spel-minimal-centos-7"
	config.vm.hostname = "jekyll"
	config.vm.network "forwarded_port", host: 4000, guest: 4000
	config.vm.provision :shell, path: "bootstrap/install-rvm.sh", args: "stable", privileged: false
	config.vm.provision :shell, path: "bootstrap/install-ruby.sh", args: "2.6.3 bundler jekyll", privileged: false
	config.vm.provision :shell, path: "bootstrap/start-jekyll.sh", privileged: false
	config.ssh.forward_agent = true
end