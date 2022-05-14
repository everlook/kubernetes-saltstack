kubernetes:
  version: v1.18.20
  domain: cluster.local

  master:
    count: 1
    hostname: master.domain.tld
    ipaddr: 192.168.56.10

    etcd:
      version: v3.3.25
    encryption-key: '0Wh+uekJUj3SzaKt+BcHUEJX/9Vo2PLGiCoIsND9GyY='

  worker:
    runtime:
      provider: containerd
      containerd:
        version: 1.4.4

  global:
    clusterIP-range: 192.168.56.0/16
    admin-token: veepulieD2Go3nie
    kubelet-token: iZ1ech8phuodu4oo
