# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.provider "virtualbox" do |v|
    v.memory = 512
    v.cpus = 1
  end

  config.vm.box = "ubuntu/trusty64"

  config.vm.network "private_network", ip: "192.168.150.150"

  config.vm.synced_folder ".", "/app"

  config.vm.provision "docker" do |d|
    d.build_image "/app", args: "-t cult/hydra-dev"
    d.run "cult/hydra-dev"
  end
  # config.vm.provision "shell",
  #   :path => "config/startup.sh",
  #   run: "always"

end
