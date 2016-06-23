#!/bin/bash

echo 'nameserver 10.1.1.2' > /etc/resolv.conf
echo 'search kvm.lan' >> /etc/resolv.conf
sudo systemctl restart salt-minion
