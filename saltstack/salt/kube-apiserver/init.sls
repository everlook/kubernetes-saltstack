{%- set k8sVersion = pillar['kubernetes']['version'] -%}

/usr/bin/kube-apiserver:
  file.managed:
    - source: https://storage.googleapis.com/kubernetes-release/release/{{ k8sVersion }}/bin/linux/amd64/kube-apiserver
    - skip_verify: true
    - group: root
    - mode: 755

/etc/systemd/system/kube-apiserver.service:
    file.managed:
    - source: salt://{{ slspath }}/kube-apiserver.service
    - user: root
    - template: jinja
    - group: root
    - mode: 644

kube-apiserver:
  service.running:
    - enable: True
    - restart: True
    - watch:
      - /etc/systemd/system/kube-apiserver.service
      - /usr/bin/kube-apiserver