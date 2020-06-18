# packer-docker-tests
Ubuntu 18.04 with Docker CE and testing tools installed

```shell
packer build -force -on-error=ask packer.json

vagrant-tools # Select "Publish a box to Vagrant Cloud"

rm -rf output/
```

Debug
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
