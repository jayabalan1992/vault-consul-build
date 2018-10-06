#This script cleanup the vault and consul installation
#!/bin/bash
rm -rf /usr/local/bin/*
rm -rf /etc/systemd/system/vault.service
rm -rf /etc/systemd/system/consul.service
rm -rf /usr/local/etc/*
rm -rf /etc/vault.d/
rm -rf /etc/consul.d/
rm -rf /var/consul
