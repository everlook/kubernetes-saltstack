#!/bin/bash

#curl -L https://bootstrap.saltstack.com -o bootstrap_salt.sh

sudo sh /tmp/saltstack/bootstrap-salt.sh -M -N stable

sudo mkdir -p /etc/salt
sudo mkdir -p /etc/salt/pki/master/minions

sudo cp /tmp/saltstack/config/master/etc/* /etc/salt/
sudo cp /tmp/saltstack/keys/minion.pub /etc/salt/pki/master/minions/node1
sudo cp /tmp/saltstack/keys/master_minion.pub /etc/salt/pki/master/master.pub
sudo cp /tmp/saltstack/keys/master_minion.pem /etc/salt/pki/master/master.pem

sudo systemctl restart salt-master.service

sudo sh -c 'salt-call --local state.apply'
