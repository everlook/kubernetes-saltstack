#!/bin/bash

set -euo pipefail

config_dir=$HOME/.config/k8s-vagrant
key_dir="./saltstack/salt/certs"

mkdir -p ${config_dir}

cp ${key_dir}/ca.crt ${config_dir}/ca.crt
cp ${key_dir}/kube-admin.crt ${config_dir}/kube-admin.crt
cp ${key_dir}/kube-admin.key ${config_dir}/kube-admin.key
