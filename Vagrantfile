# -*- mode: ruby -*-
# vi: set ft=ruby :

# Make sure all required plugins are installed
# Taken from: https://michaelheap.com/vagrant-require-installed-plugins/
[
  { :name => "vagrant-hostmanager", :version => ">= 1.8.2" },
  { :name => "vagrant-librarian-puppet", :version => ">= 0.9.2" },
  { :name => "vagrant-puppet-install", :version => ">= 4.1.0" },
  { :name => "vagrant-vbguest", :version => ">= 0.12.0"}
].each do |plugin|
  if not Vagrant.has_plugin?(plugin[:name], plugin[:version])
    raise "#{plugin[:name]} #{plugin[:version]} is required. Please run `vagrant plugin install #{plugin[:name]}`"
  end
end

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

nodes = [
  {
    name: 'node01',
    fqdn: 'node01.int.yo61.net',
    box: 'centos/7',
    ip: '192.168.51.11',
    aliases: %w(puppet.int.yo61.net),
    cpu: 2,
    mem: 2048
  },
  {
    name: 'node02',
    fqdn: 'node02.int.yo61.net',
    box: 'centos/7',
    ip: '192.168.51.12',
    aliases: %w(zookeeper.int.yo61.net),
    cpu: 2,
    mem: 512
  },
  {
    name: 'node03',
    fqdn: 'node03.int.yo61.net',
    box: 'centos/7',
    ip: '192.168.51.13',
    aliases: %w(kafka.int.yo61.net),
    cpu: 2,
    mem: 1024
  },
  {
    name: 'node04',
    fqdn: 'node04.int.yo61.net',
    box: 'centos/7',
    ip: '192.168.51.14',
    aliases: %w(elastic.int.yo61.net),
    cpu: 2,
    mem: 2048
  },
  {
    name: 'node05',
    fqdn: 'node05.int.yo61.net',
    box: 'centos/7',
    ip: '192.168.51.15',
    aliases: %w(logstash.int.yo61.net kibana.int.yo61.net),
    cpu: 2,
    mem: 1024
  }
]

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # config.librarian_puppet.puppetfile_dir = "provisioning"
  # placeholder_filename defaults to .PLACEHOLDER
  # config.librarian_puppet.placeholder_filename = '.PLACEHOLDER'

  # define some global defaults for the virtualbox provider
  config.vm.provider :virtualbox do |vb|
    vb.memory = 1024
  end

  # use shell to install puppet
#  config.vm.provision "shell" do |shell|
#    shell.path = 'centos_6_x.sh'
#  end

  # use puppet standalone to provision
#  config.vm.provision "puppet" do |puppet|
#    puppet.manifests_path = "provisioning/manifests"
#    puppet.module_path = "provisioning/modules"
#    puppet.hiera_config_path = "provisioning/hiera.yml"
#    puppet.working_directory = "/vagrant/provisioning"
#    puppet.manifest_file  = "site.pp"
#  end

  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = true

  config.puppet_install.puppet_version = '4.5.2'

  config.vm.provision "puppet" do |puppet|
    puppet.environment_path = "puppet/environments"
    puppet.environment = "default"
  end

  # define the machines
  nodes.each do |node|
    config.vm.define node[:name] do |node_config|
      node_config.hostmanager.aliases = node[:aliases]
      node_config.vm.box = node[:box]
      node_config.vm.hostname = node[:fqdn]
      node_config.vm.network "private_network", ip: node[:ip]
      node_config.vm.provider :virtualbox do |vb|
        vb.memory = node[:mem]
      end
    end
  end

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  # config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Don't boot with headless mode
  #   vb.gui = true
  #
  #   # Use VBoxManage to customize the VM. For example to change memory:
  #   vb.customize ["modifyvm", :id, "--memory", "1024"]
  # end
  #
  # View the documentation for the provider you're using for more
  # information on available options.

  # Enable provisioning with CFEngine. CFEngine Community packages are
  # automatically installed. For example, configure the host as a
  # policy server and optionally a policy file to run:
  #
  # config.vm.provision "cfengine" do |cf|
  #   cf.am_policy_hub = true
  #   # cf.run_file = "motd.cf"
  # end
  #
  # You can also configure and bootstrap a client to an existing
  # policy server:
  #
  # config.vm.provision "cfengine" do |cf|
  #   cf.policy_server_address = "10.0.2.15"
  # end

  # Enable provisioning with Puppet stand alone.  Puppet manifests
  # are contained in a directory path relative to this Vagrantfile.
  # You will need to create the manifests directory and a manifest in
  # the file default.pp in the manifests_path directory.
  #
  # config.vm.provision "puppet" do |puppet|
  #   puppet.manifests_path = "manifests"
  #   puppet.manifest_file  = "site.pp"
  # end

  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding
  # some recipes and/or roles.
  #
  # config.vm.provision "chef_solo" do |chef|
  #   chef.cookbooks_path = "../my-recipes/cookbooks"
  #   chef.roles_path = "../my-recipes/roles"
  #   chef.data_bags_path = "../my-recipes/data_bags"
  #   chef.add_recipe "mysql"
  #   chef.add_role "web"
  #
  #   # You may also specify custom JSON attributes:
  #   chef.json = { mysql_password: "foo" }
  # end

  # Enable provisioning with chef server, specifying the chef server URL,
  # and the path to the validation key (relative to this Vagrantfile).
  #
  # The Opscode Platform uses HTTPS. Substitute your organization for
  # ORGNAME in the URL and validation key.
  #
  # If you have your own Chef Server, use the appropriate URL, which may be
  # HTTP instead of HTTPS depending on your configuration. Also change the
  # validation key to validation.pem.
  #
  # config.vm.provision "chef_client" do |chef|
  #   chef.chef_server_url = "https://api.opscode.com/organizations/ORGNAME"
  #   chef.validation_key_path = "ORGNAME-validator.pem"
  # end
  #
  # If you're using the Opscode platform, your validator client is
  # ORGNAME-validator, replacing ORGNAME with your organization name.
  #
  # If you have your own Chef Server, the default validation client name is
  # chef-validator, unless you changed the configuration.
  #
  #   chef.validation_client_name = "ORGNAME-validator"
end
