#!/bin/bash

# must be run as root

apt-get update -y
apt-get install -y qemu-kvm libvirt-daemon-system libvirt-dev build-essential
# apt-get install -y linux-image-$(uname -r)
apt-get install -y curl net-tools jq

apt-get autoremove -y

curl -O https://releases.hashicorp.com/vagrant/$(curl -s https://checkpoint-api.hashicorp.com/v1/check/vagrant  | jq -r -M '.current_version')/vagrant_$(curl -s https://checkpoint-api.hashicorp.com/v1/check/vagrant  | jq -r -M '.current_version')_x86_64.deb
dpkg -i vagrant_$(curl -s https://checkpoint-api.hashicorp.com/v1/check/vagrant  | jq -r -M '.current_version')_x86_64.deb
vagrant plugin install vagrant-libvirt
vagrant box add --provider libvirt peru/windows-10-enterprise-x64-eval
vagrant init peru/windows-10-enterprise-x64-eval
chown root:kvm /dev/kvm
service libvirtd start
service virtlogd start
vagrant up
