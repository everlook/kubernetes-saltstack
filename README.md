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

### Host kubeconfig

* copy certs to a local config directory

```bash
$ make local-config
```

* use the following to create a kubeconfig

```yaml
apiVersion: v1
kind: Config
clusters:
- cluster:
    certificate-authority: /home/<username>/.config/k8s-vagrant/ca.crt
    server: https://127.0.0.1:6443
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: kubelet
  name: kubelet
current-context: kubelet
users:
- name: kubelet
  user:
    client-certificate: /home/<username>/.config/k8s-vagrant/kube-admin.crt
    client-key: /home/<username>/.config/k8s-vagrant/kube-admin.key
```

* set an alias for **kubectl**

```bash
$ alias k='kubectl --kubeconfig=$HOME/.config/k8s-vagrant/kubeconfig'
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