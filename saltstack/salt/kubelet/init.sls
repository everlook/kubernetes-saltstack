{%- set k8sVersion = pillar['kubernetes']['version'] -%}

/usr/bin/kubelet:
  file.managed:
    - source: https://storage.googleapis.com/kubernetes-release/release/{{ k8sVersion }}/bin/linux/amd64/kubelet
    - skip_verify: true
    - group: root
    - mode: 755

/etc/systemd/system/kubelet.service:
    file.managed:
    - source: salt://{{ slspath }}/kubelet.service
    - user: root
    - template: jinja
    - group: root
    - mode: 644

kubelet:
  service.running:
    - enable: True
    - restart: True
    - watch:
      - /etc/systemd/system/kubelet.service
      - /usr/bin/kubelet