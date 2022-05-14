#!/bin/bash

set -euo pipefail

key_size=2048
key_days=365
key_dir="./saltstack/salt/certs"
apiserver_conf="./saltstack/salt/certs/apiserver.cnf"
etcdserver_conf="./saltstack/salt/certs/etcdserver.cnf"

# CA keys
ca_key="${key_dir}/ca.key"
ca_req="${key_dir}/ca.csr"
ca_crt="${key_dir}/ca.crt"

generate_ca() {
    echo "Generate CA key"
    openssl genrsa -out ${ca_key} ${key_size}
    echo "Generate CA signing request"
    openssl req -new -key ${ca_key} -subj "/CN=kubernetes" -out ${ca_req}
    echo "Generate CA certificate"
    openssl x509 -req -in ${ca_req} -signkey ${ca_key} -out ${ca_crt} -days ${key_days}
}

generate_cert_with_conf() {
    echo "Generate ${1} key"
    openssl genrsa -out ${key_dir}/${1}.key ${key_size}
    echo "Generate ${1} signing request"
    openssl req -new -key ${key_dir}/${1}.key -out ${key_dir}/${1}.req -config ${2}
    echo "Generate certificate"
    openssl x509 -CAcreateserial -req -in ${key_dir}/${1}.req -CA ${ca_crt} -CAkey ${ca_key} \
        -out ${key_dir}/${1}.crt -extensions v3_ext -extfile ${2} -days ${key_days}
}

generate_cert() {
    echo "Generate ${1} key"
    openssl genrsa -out ${key_dir}/${1}.key ${key_size}
    echo "Generate ${1} signing request"
    openssl req -new -key ${key_dir}/${1}.key -subj ${2} -out ${key_dir}/${1}.req
    echo "Generate certificate"
    openssl x509 -CAcreateserial -req -in ${key_dir}/${1}.req -CA ${ca_crt} -CAkey ${ca_key} \
        -out ${key_dir}/${1}.crt -days ${key_days}
}

# CA cert
generate_ca
# kubernetes certs
generate_cert "kube-admin" "/CN=kube-admin/O=system:masters"
generate_cert "kube-scheduler" "/CN=system:kube-scheduler"
generate_cert "kube-controller-manager" "/CN=system:kube-controller-manager"
generate_cert "kube-proxy" "/CN=system:kube-proxy"
generate_cert_with_conf "kube-apiserver" ${apiserver_conf}
generate_cert "kube-apiserver-kubelet-client" "/CN=kube-apiserver-kubelet-client"
generate_cert "kube-apiserver-serviceaccount" "/CN=kube-apiserver-serviceaccount"
generate_cert_with_conf "etcd-server" ${etcdserver_conf}
# node certs
generate_cert "kubelet-node" "/CN=node1"
generate_cert "kubelet-client-node" "/CN=system:node:node1/O=system:nodes"