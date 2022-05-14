#!/bin/bash

#curl -L https://bootstrap.saltstack.com -o bootstrap_salt.sh

sudo swapoff -a
sudo modprobe overlay
sudo modprobe br_netfilter

sudo sh /tmp/saltstack/bootstrap-salt.sh stable

sudo mkdir -p /etc/salt
sudo mkdir -p /etc/salt/pki/minion

sudo cp /tmp/saltstack/config/minion/etc/* /etc/salt/
sudo cp /tmp/saltstack/keys/minion.pem /etc/salt/pki/minion/minion.pem
sudo cp /tmp/saltstack/keys/minion.pub /etc/salt/pki/minion/minion.pub

sudo sh -c 'salt-call state.apply'
sudo systemctl restart salt-minion