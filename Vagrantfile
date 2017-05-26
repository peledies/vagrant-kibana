# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/xenial64"
  
  #config.vm.network :forwarded_port, host: 8006, guest: 80
  #config.vm.network :forwarded_port, host: 33066, guest: 3306
  config.vm.network :forwarded_port, host: 56011, guest: 5601

  config.vm.define :kibana do |kibana|
  end

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 2048
    vb.cpus = 2
  end

  config.vm.synced_folder "./kibana", "/home/ubuntu/kibana", owner: "ubuntu", group: "ubuntu", mount_options: ["dmode=777", "fmode=777"]
  config.vm.synced_folder "./elasticsearch", "/home/ubuntu/elasticsearch", owner: "ubuntu", group: "ubuntu", mount_options: ["dmode=777", "fmode=777"]

  config.vm.provision "shell" do |s|
    s.path = ".devl/etc/scripts/bootstrap_kibana.sh"
  end

  config.vm.provision "shell" do |s|
    s.path = ".devl/etc/scripts/bootstrap_elasticsearch.sh"
  end

end
