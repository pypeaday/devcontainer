#!/bin/bash
set -e
export ANSIBLE_CONFIG=./ansible/ansible.cfg

env

sudo touch /etc/apt/apt.conf

echo "Updating apt packages..."
sudo apt update -y

echo "Installing Ansible..."
sudo apt install ansible -y

echo "Running Ansible playbook for setup..."
ansible-playbook -e ansible_user=$(whoami) ./ansible/playbooks/setup.yaml -vvv

echo "Backing up ~/.zshrc..."
mv ~/.zshrc ~/.zshrc.bak || echo "Failed to backup ~/.zshrc"

echo "Stowing stowme..."
stow stowme -t $HOME

echo "Setting permissions..."
sudo chown -R $(whoami):$(whoami) $HOME

