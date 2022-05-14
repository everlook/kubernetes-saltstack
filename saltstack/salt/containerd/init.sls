{%- set runtimeVersion = pillar['kubernetes']['worker']['runtime']['containerd']['version'] -%}

extract_containerd:
  archive.extracted:
    - source: https://github.com/containerd/containerd/releases/download/v{{ runtimeVersion  }}/cri-containerd-cni-{{ runtimeVersion  }}-linux-amd64.tar.gz
    - name: /
    - enforce_toplevel: False
    - skip_verify: True
    - group: root
    - user: root
    - mode: 755

/etc/systemd/system/containerd.service:
    file.managed:
    - source: salt://{{ slspath }}/containerd.service
    - user: root
    - template: jinja
    - group: root
    - mode: 644

/etc/containerd/config.toml:
    file.managed:
    - source: salt://{{ slspath }}/config.toml
    - user: root
    - template: jinja
    - group: root
    - mode: 644
    - makedirs: True

containerd:
  service.running:
    - enable: True
    - reload: True
    - watch:
      - /etc/systemd/system/containerd.service
