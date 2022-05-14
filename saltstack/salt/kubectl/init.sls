{%- set k8sVersion = pillar['kubernetes']['version'] -%}

/usr/bin/kubectl:
  file.managed:
    - source: https://storage.googleapis.com/kubernetes-release/release/{{ k8sVersion }}/bin/linux/amd64/kubectl
    - skip_verify: true
    - group: root
    - mode: 755