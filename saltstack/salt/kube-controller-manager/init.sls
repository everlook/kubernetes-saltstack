{%- set k8sVersion = pillar['kubernetes']['version'] -%}

/usr/bin/kube-controller-manager:
  file.managed:
    - source: https://storage.googleapis.com/kubernetes-release/release/{{ k8sVersion }}/bin/linux/amd64/kube-controller-manager
    - skip_verify: true
    - group: root
    - mode: 755

/etc/systemd/system/kube-controller-manager.service:
    file.managed:
    - source: salt://{{ slspath }}/kube-controller-manager.service
    - user: root
    - template: jinja
    - group: root
    - mode: 644

kube-controller-manager:
  service.running:
    - enable: True
    - restart: True
    - watch:
      - /etc/systemd/system/kube-controller-manager.service
      - /usr/bin/kube-controller-manager