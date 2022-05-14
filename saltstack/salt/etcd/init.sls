{%- set etcdVersion = pillar['kubernetes']['master']['etcd']['version'] -%}

/etc/etcd:
  file.directory:
    - user: root
    - group: root
    - dir_mode: 750

etcd-latest-archive:
  archive.extracted:
    - name: /opt/
    - source: https://github.com/etcd-io/etcd/releases/download/{{ etcdVersion }}/etcd-{{ etcdVersion }}-linux-amd64.tar.gz
    - skip_verify: true
    - archive_format: tar

/usr/bin/etcd:
  file.symlink:
    - target: /opt/etcd-{{ etcdVersion }}-linux-amd64/etcd
/usr/bin/etcdctl:
  file.symlink:
    - target: /opt/etcd-{{ etcdVersion }}-linux-amd64/etcdctl

/etc/systemd/system/etcd.service:
  file.managed:
    - source: salt://{{ slspath }}/etcd.service
    - user: root
    - template: jinja
    - group: root
    - mode: 644

etcd:
  service.running:
    - enable: True
    - reload: True
    - watch:
      - /etc/systemd/system/etcd.service
      - /usr/bin/etcd
