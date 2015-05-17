# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

variables = %w{POSTGRES_PWORD}
missing = variables.find_all { |v| ENV[v] == nil }
unless missing.empty?
  puts "FATAL: The following variables are missing and are needed to run this script: #{missing.join(', ')}."
  exit
end

# Script to setup vagrant user
$script = <<SCRIPT

echo 'setup .gemrc file'
cat > /home/vagrant/.gemrc << 'EOF'
gem: --no-ri --no-rdoc
EOF
chown vagrant:vagrant /home/vagrant/.gemrc

echo 'append rbenv setup to .profile'
cat << 'EOF' >> /home/vagrant/.profile
export RBENV_ROOT="/home/vagrant/.rbenv"

if [ -d "${RBENV_ROOT}" ]; then
  export PATH="${RBENV_ROOT}/bin:${PATH}"
  eval "$(rbenv init -)"
fi

alias be="bundle exec"
EOF

SCRIPT

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Use Ubuntu 14.04 Trusty Tahr 64-bit as our operating system
  config.vm.box = "ubuntu/trusty64"

  # Configurate the virtual machine to use 2GB of RAM
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end

  # Forward the Rails server default port to the host
  config.vm.network :forwarded_port, guest: 3000, host: 3000
  # config.vm.network :public_network, bridge: "wlan0", ip: "192.168.10.25"

  config.vm.network "public_network", :bridge => "en0: Wi-Fi (AirPort)"
  # use `ifconfig` to find ip after `vagrant ssh` or use:

  config.ssh.forward_agent = true

  # Run the script to setup vagrant user
  config.vm.provision :shell, inline: $script

  # Use Chef Solo to provision our virtual machine
  config.vm.provision :chef_solo do |chef|

    chef.cookbooks_path = ["cookbooks", "site-cookbooks"]

    chef.add_recipe "apt"
    chef.add_recipe "nodejs"
    chef.add_recipe "ruby_build"
    chef.add_recipe "rbenv::user"
    chef.add_recipe "rbenv::vagrant"
    chef.add_recipe "vim"
    chef.add_recipe "postgresql::server"
    chef.add_recipe "postgresql::client"

    chef.json = {
      rbenv: {
        user_installs: [{
          # Target global ruby setup when not setting a user
          user: "vagrant",
          rubies: ["2.2.1"],
          global: "2.2.1",
          gems: {
            "2.2.1" => [
              { "name" => "bundler" },
              { "name" => "rake" }
            ]
          }
        }]
      },
      postgresql: {
        password: {
          postgres: ENV['POSTGRES_PWORD']
        },
        pg_hba: [
          { type: 'local', db: 'all', user: 'all', addr: nil, method: 'trust' },
          { type: 'local', db: 'all', user: 'postgres', addr: nil, method: 'trust' },
          { type: 'host', db: 'all', user: 'all', addr: '127.0.0.1/32', method: 'trust' }
        ]
      }
    }
  end
end
