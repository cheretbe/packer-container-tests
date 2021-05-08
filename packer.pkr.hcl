
source "vagrant" "container-tests" {
  communicator       = "ssh"
  output_dir         = "output"
  output_vagrantfile = "vagrantfile.template"
  provider           = "virtualbox"
  source_path        = "ubuntu/focal64"
  package_include    = ["./provision/init_btrfs_storage.yml"]
}

build {
  sources = ["source.vagrant.container-tests"]

  provisioner "shell" {
    script = "./provision/provision.sh"
  }
}
