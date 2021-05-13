# packer-container-tests
Ubuntu 20.04 with Docker CE, LXD and testing tools installed

```shell
packer build -force -on-error=ask packer.pkr.hcl

vagrant-tools # Select "Publish a box to Vagrant Cloud"

rm -rf output/
```
```bat
:: Windows

RMDIR output /S /Q
```

Debug
```shell
vagrant box add -f packer-container-tests-2del ./output/package.box
```

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "packer-container-tests-2del"
  # config.vm.box = "cheretbe/container-tests"
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--groups", "/__vagrant"]
  end
end
```

```shell
cat ~/.vagrant.d/boxes/packer-container-tests-2del/0/virtualbox/Vagrantfile
cat ~/.vagrant.d/boxes/packer-container-tests-2del/0/virtualbox/include/_Vagrantfile
```
