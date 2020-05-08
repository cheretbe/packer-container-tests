# packer-docker-tests
Ubuntu 18.04 with Docker CE and testing tools installed

```shell
packer build -force -on-error=ask packer.json
```

Debug (:warning: make sure to run `vagrant destroy` afterwards, so that "source"
VM is not left hanging)
```shell
packer build -force -on-error=ask \
  -var "skip_package=true" -var "teardown_method=suspend" \
  packer.json
cd output-docker-tests/
vagrant resume source
vagrant ssh source
# Make sure to destroy the temporary Vagrant environment
vagrant destroy -f
cd 
```

```shell
vagrant box add -f docker-tests-2del ./output/package.box
```

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "docker-tests-2del"
  # config.vm.box = "cheretbe/docker-tests"
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--groups", "/__vagrant"]
  end
end
```

```shell
cat ~/.vagrant.d/boxes/docker-tests-2del/0/virtualbox/Vagrantfile
cat ~/.vagrant.d/boxes/docker-tests-2del/0/virtualbox/include/_Vagrantfile
```