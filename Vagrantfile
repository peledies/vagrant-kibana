# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/xenial64"
  
  # Prevent "Inappropriate ioctl for device" message
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
  
  # Set up Port Forwarding
  config.vm.network :forwarded_port, host: 8100, guest: 80
  config.vm.network :forwarded_port, host: 8101, guest: 81
  config.vm.network :forwarded_port, host: 5600, guest: 5601

  # Give vagrant box a static IP Address
  config.vm.network "private_network", ip: "192.168.33.3"

  # Give the Vagrant box a name
  config.vm.define :kibana do |kibana|
  end

  # Configure box memory and CPU
  config.vm.provider "virtualbox" do |vb|
    vb.memory = 4096
    vb.cpus = 2
  end

  # Mount host folders in guest box
  config.vm.synced_folder "./", "/home/ubuntu/kibana", owner: "ubuntu", group: "ubuntu", mount_options: ["dmode=777", "fmode=777"]
  #config.vm.synced_folder "./elasticsearch", "/home/ubuntu/elasticsearch", owner: "ubuntu", group: "ubuntu", mount_options: ["dmode=777", "fmode=777"]

  config.vm.provision "shell" do |s|
    s.path = ".devl/etc/scripts/install_java.sh"
  end

  config.vm.provision "shell" do |s|
    s.path = ".devl/etc/scripts/bootstrap_elasticsearch.sh"
  end

  config.vm.provision "shell" do |s|
    s.path = ".devl/etc/scripts/bootstrap_kibana.sh"
  end

  config.vm.provision "shell" do |s|
    s.path = ".devl/etc/scripts/bootstrap_nginx.sh"
  end

  config.vm.provision "shell" do |s|
    s.path = ".devl/etc/scripts/bootstrap_logstash.sh"
  end

  config.vm.provision "shell" do |s|
    s.path = ".devl/etc/scripts/provision_sample_data.sh"
  end
end
