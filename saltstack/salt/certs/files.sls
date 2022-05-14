/var/lib/kubernetes:
  file.directory:
    - user: root
    - group: root
    - dir_mode: 750

/var/lib/kubernetes/ca.crt:
  file.managed:
    - source:  salt://{{ slspath }}/ca.crt
    - group: root
    - mode: 644

/var/lib/kubernetes/kube-admin.key:
  file.managed:
    - source:  salt://{{ slspath }}/kube-admin.key
    - group: root
    - mode: 600

/var/lib/kubernetes/kube-admin.crt:
  file.managed:
    - source:  salt://{{ slspath }}/kube-admin.crt
    - group: root
    - mode: 600

/var/lib/kubernetes/kubeconfig:
    file.managed:
    - source: salt://{{ slspath }}/kubeconfig
    - user: root
    - template: jinja
    - group: root
    - mode: 644

{% if "apiserver" in grains.get('roles', []) %}
/var/lib/kubernetes/kube-apiserver.crt:
  file.managed:
    - source:  salt://{{ slspath }}/kube-apiserver.crt
    - group: root
    - mode: 600

/var/lib/kubernetes/kube-apiserver.key:
  file.managed:
    - source:  salt://{{ slspath }}/kube-apiserver.key
    - group: root
    - mode: 600

/var/lib/kubernetes/kube-apiserver-kubelet-client.crt:
  file.managed:
    - source:  salt://{{ slspath }}/kube-apiserver-kubelet-client.crt
    - group: root
    - mode: 600

/var/lib/kubernetes/kube-apiserver-kubelet-client.key:
  file.managed:
    - source:  salt://{{ slspath }}/kube-apiserver-kubelet-client.key
    - group: root
    - mode: 600

/var/lib/kubernetes/etcd-server.key:
  file.managed:
    - source:  salt://{{ slspath }}/etcd-server.key
    - group: root
    - mode: 600

/var/lib/kubernetes/etcd-server.crt:
  file.managed:
    - source:  salt://{{ slspath }}/etcd-server.crt
    - group: root
    - mode: 600

/var/lib/kubernetes/kube-controller-manager.key:
  file.managed:
    - source:  salt://{{ slspath }}/kube-controller-manager.key
    - group: root
    - mode: 600

/var/lib/kubernetes/kube-controller-manager.crt:
  file.managed:
    - source:  salt://{{ slspath }}/kube-controller-manager.crt
    - group: root
    - mode: 600

/var/lib/kubernetes/kube-scheduler.key:
  file.managed:
    - source:  salt://{{ slspath }}/kube-scheduler.key
    - group: root
    - mode: 600

/var/lib/kubernetes/kube-scheduler.crt:
  file.managed:
    - source:  salt://{{ slspath }}/kube-scheduler.crt
    - group: root
    - mode: 600

/var/lib/kubernetes/kube-apiserver-serviceaccount.key:
  file.managed:
    - source:  salt://{{ slspath }}/kube-apiserver-serviceaccount.key
    - group: root
    - mode: 600

/var/lib/kubernetes/kube-apiserver-serviceaccount.crt:
  file.managed:
    - source:  salt://{{ slspath }}/kube-apiserver-serviceaccount.crt
    - group: root
    - mode: 600
{% endif %}

{% if "node" in grains.get('roles', []) %}
/var/lib/kubernetes/kubelet-node.crt:
  file.managed:
    - source:  salt://{{ slspath }}/kubelet-node.crt
    - group: root
    - mode: 600

/var/lib/kubernetes/kubelet-node.key:
  file.managed:
    - source:  salt://{{ slspath }}/kubelet-node.key
    - group: root
    - mode: 600

/var/lib/kubernetes/kubelet-client-node.crt:
  file.managed:
    - source:  salt://{{ slspath }}/kubelet-client-node.crt
    - group: root
    - mode: 600

/var/lib/kubernetes/kubelet-client-node.key:
  file.managed:
    - source:  salt://{{ slspath }}/kubelet-client-node.key
    - group: root
    - mode: 600

/var/lib/kubernetes/kube-proxy.key:
  file.managed:
    - source:  salt://{{ slspath }}/kube-proxy.key
    - group: root
    - mode: 600

/var/lib/kubernetes/kube-proxy.crt:
  file.managed:
    - source:  salt://{{ slspath }}/kube-proxy.crt
    - group: root
    - mode: 600
{% endif %}