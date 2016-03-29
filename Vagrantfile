# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = 'bento/centos-7.2'

  # Makes nginx available on port 8080 from host
  config.vm.network 'forwarded_port', guest: 80, host: 8080

  # Make sure that vagrant-berkshelf is installed
  # If it is not installed, notify the user
  unless Vagrant.has_plugin?('vagrant-berkshelf')
    raise 'vagrant-berkshelf is not installed!  Install with `vagrant plugin install vagrant-berkshelf`'
  end

  config.berkshelf.enabled = true

  config.vm.provision 'chef_solo' do |chef|
    chef.add_recipe 'app-monolog-web'
    chef.environments_path = 'cookbooks/app-monolog-web/environments'
    if ENV['CHEF_ENVIRONMENT']
      chef.environment = ENV['CHEF_ENVIRONMENT']
    end
  end

end
