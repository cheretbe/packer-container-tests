#!/bin/bash

set -euo pipefail

if [ "$UID" != "0" ]; then
  echo "Re-running the script with sudo"
  echo sudo su - root $0 $*
  sudo su - root $0 $*
  exit
fi

echo "Installing Ansible"
# add-apt-repository ppa:ansible/ansible -y
echo "Updating package cache"
apt-get update -y -qq
echo "Installing python3-pip package"
DEBIAN_FRONTEND=noninteractive apt-get install -y -qq python3-pip

echo "Upgrading pip3"
# Temporary solution to suppress messages like this:
# WARNING: Value for scheme.scripts does not match ...
# https://github.com/pypa/pip/issues/9617
# https://stackoverflow.com/questions/67244301/warning-messages-when-i-update-pip-or-install-packages/67250419#67250419
python3 -m pip install pip==21.0.1

echo "Installing Ansible using pip3"
pip3 --disable-pip-version-check install ansible