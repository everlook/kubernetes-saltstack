{%- set k8sVersion = pillar['kubernetes']['version'] -%}

/usr/bin/kubectl-proxy:
  file.managed:
    - source: https://storage.googleapis.com/kubernetes-release/release/{{ k8sVersion }}/bin/linux/amd64/kube-proxy
    - skip_verify: true
    - group: root
    - mode: 755