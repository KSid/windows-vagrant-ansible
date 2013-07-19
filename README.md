windows-vagrant-ansible
=======================

Windows is not currently supported by [Ansible][1] which means the standard Ansible plugin provided with
[Vagrant][2] cannot be used with this platform. The provision.sh script allows the use of Ansible from within
a VM via the [shell provisioning][3] facilities provided by Vagrant.

Usage
-----

Place provision.sh in the same directory as your Vagrantfile. You should then configure Vagrant to use
shell provisioning where sh.path refers to provision.sh script. Three options are required and must be
supplied using sh.args in the following order:

1. The directory the Ansible git repository should be cloned into
2. The Ansible playbook to run
3. The Ansible hosts inventory file to use

An example Vagrantfile is below:

```ruby
Vagrant.configure("2") do |config|

  # ...

  config.vm.provision :shell do |sh|
    sh.path = "provision.sh"
    sh.args = "./ansible provisioning/setup.yml provisioning/hosts/dev_hosts"
  end
end
```

[1]: http://www.ansibleworks.com "Ansible"
[2]: http://www.vagrantup.com/ "Vagrant"
[3]: http://docs.vagrantup.com/v2/provisioning/shell.html "Shell Provisioning"
