update_apt:
  cmd.run:
    - name: apt-get update

install_bind:
  pkg.installed:
    - pkgs:
      - bind9
      - bind9utils

configure_options:
  file.managed:
    - source: salt://files/apps/bind/named.conf.options
    - name: /etc/bind/named.conf.options
    - force: True
    - makedirs: True

configure_local:
  file.managed:
    - source: salt://files/apps/bind/named.conf.local
    - name: /etc/bind/named.conf.local
    - makedirs: True

configure_zone:
  file.managed:
    - source: salt://files/apps/bind/db.local.lan
    - name: /etc/bind/zones/db.local.lan
    - force: True
    - makedirs: True

enable_bind:
  service.running:
    - name: bind9
    - reload: True
    - watch:
      - file: /etc/bind/named.conf.local
      - file: /etc/bind/named.conf.options
      - file: /etc/bind/zones/db.local.lan
