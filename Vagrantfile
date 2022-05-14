# -*- mode: ruby -*-
# vi: set ft=ruby :
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  os = "custom/ubuntu-20.04.1"
  net_ip = "192.168.56"
  
  config.vm.box_download_insecure = true
  if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.auto_update = false
  end

  config.vm.provision "shell", inline: <<-SHELL
    echo "#{net_ip}.10 apiserver" >> /etc/hosts
    echo "#{net_ip}.10 kubemaster" >> /etc/hosts
    echo "#{net_ip}.11 node1" >> /etc/hosts
  SHELL
  
  config.vm.provision "file", source: "saltstack/config", destination: "/tmp/saltstack/config"
  config.vm.provision "file", source: "saltstack/keys", destination: "/tmp/saltstack/keys"
  config.vm.provision "file", source: "scripts/bootstrap-salt.sh", destination: "/tmp/saltstack/bootstrap-salt.sh"

  config.vm.define :apiserver, primary: true do |apiserver_config|
    apiserver_config.vm.synced_folder ".", "/vagrant", disabled: true
    apiserver_config.vm.provider "virtualbox" do |vb|
        vb.memory = "8192"
        vb.cpus = 2
        vb.name = "kube-apiserver"
        vb.check_guest_additions = false
    end

    apiserver_config.vm.box = "#{os}"
    apiserver_config.vm.host_name = 'apiserver'
    apiserver_config.vm.network "private_network", ip: "#{net_ip}.10"
    apiserver_config.vm.network "forwarded_port", guest: 6443, host: 6443
    apiserver_config.vm.synced_folder "saltstack/salt/", "/srv/salt", type: "sshfs"
    apiserver_config.vm.synced_folder "saltstack/pillar/", "/srv/pillar", type: "sshfs"
  
    apiserver_config.vm.provision "shell", path: "scripts/saltmaster.sh"
  end
  
  config.vm.define :node do |node_config|
    node_config.vm.synced_folder ".", "/vagrant", disabled: true
    node_config.vm.provider "virtualbox" do |vb|
        vb.memory = "8192"
        vb.cpus = 2
        vb.name = "kube-node1"
        vb.check_guest_additions = false
    end

    node_config.vm.box = "#{os}"
    node_config.vm.hostname = 'node1'
    node_config.vm.network "private_network", ip: "#{net_ip}.11"
    
    node_config.vm.provision "shell", path: "scripts/saltminion.sh"
  end
end
