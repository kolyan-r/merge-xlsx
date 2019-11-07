# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

current_dir = File.dirname(File.expand_path(__FILE__))
vagrant_config = YAML.load_file("#{current_dir}/vagrant.d/config.yml")['config']

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  project_name = 'merge-xlsx'

  $memory = vagrant_config['memory']
  $cpus = vagrant_config['cpus']

  config.vm.box = vagrant_config['box']

  if vagrant_config['provider'] == 'virtualbox'
    config.vm.provider :virtualbox do |vb|
      vb.memory = $memory
      vb.cpus = $cpus
    end
  end

  if vagrant_config['provider'] == 'vmware_fusion'
      config.vm.provider :vmware_fusion do |vmf|
        vmf.memory = $memory
        vmf.cpus = $cpus
      end
  end

  if vagrant_config['provider'] == 'vmware_workstation'
      config.vm.provider :vmware_workstation do |vmw|
        vmw.memory = $memory
        vmw.cpus = $cpus
      end
  end

  if vagrant_config['provider'] == 'lxc'
    config.vm.provider :lxc do |lxc|
      #lxc.customize 'aa_profile', 'unconfined'
      #lxc.customize 'cgroup.devices.allow', 'a'
      #lxc.customize 'mount.auto', 'proc:rw sys:ro cgroup:ro'
    end
  end

  if vagrant_config['provider'] == 'parallels'
      config.vm.provider :parallels do |prl|
        prl.memory = $memory
        prl.cpus = $cpus
        prl.update_guest_tools = false
      end
  end

  config.vm.hostname = project_name

  config.vm.synced_folder ".", "/home/vagrant/#{project_name}", id: "#{project_name}"

  config.vm.provision "shell", path: "vagrant.d/install_packages.sh", :args => "#{project_name}"
end