#!/bin/bash

set -euo pipefail

if [ "$UID" != "0" ]; then
  echo "Re-running the script with sudo"
  echo sudo su - root $0 $*
  sudo su - root $0 $*
  exit
fi

# echo "Installing Ansible"
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
python3 -m pip install --disable-pip-version-check pip==21.0.1

echo "Installing packages using pip3"
pip3 --disable-pip-version-check install ansible packaging requests invoke \
  pytest "molecule[docker]" docker ansible-lint flake8 pytest-testinfra

echo "Checking out shared playbooks repo"
if [ -d ansible-playbooks ]; then rm -rf ansible-playbooks; fi
git clone -q https://github.com/cheretbe/ansible-playbooks.git

ansible-playbook -c local -i 127.0.0.1, ansible-playbooks/run_role.yml \
  --extra-vars "role_name=linux-utils"

ansible-playbook -c local -i 127.0.0.1, ansible-playbooks/run_role.yml \
  --extra-vars "role_name=docker-ce"

echo "Adding user 'vagrant' to 'docker' group"
usermod -a -G docker vagrant

echo "Removing shared playbooks repo"
rm -rf ansible-playbooks

echo "Cleaning up apt cache"
apt-get clean
