# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Define the OS: Ubuntu 24.04 (Noble Numbat)
  config.vm.box = "bento/ubuntu-24.04"
  config.vm.hostname = "tsubu22"

  # 1. Bridged Networking
  config.vm.network "public_network", bridge: "enp6s0"

  # 2. VMware Provider Settings
  config.vm.provider "vmware_desktop" do |v|
    v.gui = true
    v.cpus = 2
    v.memory = 4096
    # Ensure VMware guest tools are synced
    v.whitelist_verified = true
  end

  # 3. Provision the 'michael' user
  # We create the user, set up passwordless sudo, and sync SSH keys.
  config.vm.provision "shell", inline: <<-SHELL
    if ! id "michael" &>/dev/null; then
      useradd -m -s /bin/bash michael
      echo "michael ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/michael
      
      # Sync keys so 'vagrant ssh' or standard SSH works for michael
      mkdir -p /home/michael/.ssh
      cp /home/vagrant/.ssh/authorized_keys /home/michael/.ssh/
      chown -R michael:michael /home/michael/.ssh
      echo "User 'michael' successfully provisioned."
    fi
  SHELL

  # 4. Run the Tailscale Installation Script
  config.vm.provision "shell", path: "tailscale_setup.sh"
end