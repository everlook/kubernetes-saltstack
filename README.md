### Vagrant plugins

```bash
vagrant plugin install vagrant-vbguest
vagrant plugin install vagrant-sshfs
```

### Use packer to build vagrant box
* see the packer [README](packer/README.md)


### Generate certs

```bash
$ make
```

### Start the cluster

```bash
$ vagrant up
```

### Create a pod
```bash
$ vagrant ssh apiserver
$ sudo su -
$ kubectl --kubeconfig=/var/lib/kubernetes/kubeconfig get componentstatuses
$ kubectl --kubeconfig=/var/lib/kubernetes/kubeconfig run nginx --image=nginx
$ kubectl --kubeconfig=/var/lib/kubernetes/kubeconfig get pods nginx -owide
$ kubectl --kubeconfig=/var/lib/kubernetes/kubeconfig describe pods nginx
```

### Salt usage

```bash
$ # test the minion
$ sudo salt '*' test.ping
$ # update the apiserver
$ sudo salt-call --local state.apply
$ # update the minion
$ sudo salt node1 state.apply
```

### TODO
- Review all certificates
- Generate salt keys
- Allow for more than one node
- Forward kube-apiserver port so the apiserver can be accessed on the host
- Create kubeconfig on host so kubectl can be used on the host
- Get working with libvirt