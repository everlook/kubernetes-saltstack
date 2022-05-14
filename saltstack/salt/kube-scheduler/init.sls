{%- set k8sVersion = pillar['kubernetes']['version'] -%}

/usr/bin/kube-scheduler:
  file.managed:
    - source: https://storage.googleapis.com/kubernetes-release/release/{{ k8sVersion }}/bin/linux/amd64/kube-scheduler
    - skip_verify: true
    - group: root
    - mode: 755

/etc/systemd/system/kube-scheduler.service:
    file.managed:
    - source: salt://{{ slspath }}/kube-scheduler.service
    - user: root
    - template: jinja
    - group: root
    - mode: 644

kube-scheduler:
  service.running:
    - enable: True
    - restart: True
    - watch:
      - /etc/systemd/system/kube-scheduler.service
      - /usr/bin/kube-scheduler