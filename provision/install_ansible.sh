#!/bin/bash

set -euo pipefail

if [ "$UID" != "0" ]; then
  echo "Re-running the script with sudo"
  sudo $0 $*
  exit
fi

echo "Installing Ansible"
add-apt-repository ppa:ansible/ansible -y
apt-get update -y -qq
DEBIAN_FRONTEND=noninteractive apt-get install -y -qq ansible