#!/bin/bash

############### Consul Client Installation ####################
localip=$(hostname -I)
cd /usr/local/bin
yum install -y wget unzip
wget https://releases.hashicorp.com/consul/1.2.0/consul_1.2.0_linux_amd64.zip
unzip *.zip
rm -rf *.zip
adduser consul
mkdir -p /etc/consul.d/{bootstrap,server,client}
mkdir /var/consul
mkdir /usr/local/etc/consul
chown consul:consul /var/consul
touch /etc/systemd/system/consul.service
touch /usr/local/etc/consul/client_agent.json
cat << EOF > /usr/local/etc/consul/client_agent.json
{
  "server": false,
  "datacenter": "dc1",
  "node_name": "consul_c1",
  "data_dir": "/var/consul/data",
  "bind_addr": "${localip}",
  "client_addr": "127.0.0.1",
  "retry_join": ["server-1-ip", "server-2-ip","server-3-ip"],    
  "log_level": "DEBUG",
  "enable_syslog": true,
  "acl_enforce_version_8": false
}
EOF

cat <<EOF > /etc/systemd/system/consul.service
[Unit]
Description=Consul client agent
Requires=network-online.target
After=network-online.target
[Service]
User=consul
Group=consul
PIDFile=/var/run/consul/consul.pid
PermissionsStartOnly=true
ExecStartPre=-/bin/mkdir -p /var/run/consul
ExecStartPre=/bin/chown -R consul:consul /var/run/consul
ExecStart=/etc/consul.d/startconsul.sh
ExecReload=/bin/kill -HUP $MAINPID
KillMode=process
KillSignal=SIGTERM
Restart=on-failure
RestartSec=42s
[Install]
WantedBy=multi-user.target
EOF

touch /etc/consul.d/startconsul.sh
cat <<EOF > /etc/consul.d/startconsul.sh
#!/bin/sh
/usr/local/bin/consul agent -config-file=/usr/local/etc/consul/client_agent.json
EOF

chmod +x /etc/consul.d/startconsul.sh

systemctl daemon-reload
systemctl start consul.service

#####################  Vault Installation  #####################
cd /usr/local/bin
wget https://releases.hashicorp.com/vault/0.10.3/vault_0.10.3_linux_amd64.zip
unzip *.zip
rm -rf *.zip
mkdir -p /etc/vault.d/
touch /etc/vault.d/config.hcl
touch /etc/systemd/system/vault.service
adduser vault
cd /etc/vault.d/
openssl req -newkey rsa:2048 -nodes -keyout domain.key -x509 -days 365 -out domain.crt
cat <<EOF > /etc/vault.d/config.hcl
listener "tcp" {
  address          = "0.0.0.0:8200"
  cluster_address  = "${localip}:8201"
  tls_disable      = "false"
  tls_cert_file="/etc/vault.d/domain.crt"
  tls_key_file="/etc/vault.d/domain.key"
}

storage "consul" {
  address = "127.0.0.1:8500"
  path    = "vault/"
}

api_addr = "http://${localip}:8200"
cluster_addr = "http://${localip}:8201"
EOF

cat <<EOF > /etc/systemd/system/vault.service
[Unit]
Description=Vault secret management tool
Requires=network-online.target
After=network-online.target

[Service]
User=vault
Group=vault
PIDFile=/var/run/vault/vault.pid
ExecStart=/usr/local/bin/vault server -config=/etc/vault.d/config.hcl -log-level=debug
ExecReload=/bin/kill -HUP $MAINPID
KillMode=process
KillSignal=SIGTERM
Restart=on-failure
RestartSec=42s
LimitMEMLOCK=infinity

[Install]
WantedBy=multi-user.target
EOF
export VAULT_ADDR='http://127.0.0.1:8200'
systemctl daemon-reload
systemctl start vault.service
