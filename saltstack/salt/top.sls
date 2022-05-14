base:
  '*':
    - common
  {% if "apiserver" in grains.get('roles', []) %}
    - etcd
    - kube-apiserver
    - kube-controller-manager
    - kube-scheduler
    - kubectl
    - certs
  {% endif %}
  {% if "node" in grains.get('roles', []) %}
    - containerd
    - kubelet
    - kube-proxy
    - certs
  {% endif %}
