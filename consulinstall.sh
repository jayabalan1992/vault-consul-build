#!/bin/bash
cd /usr/local/bin
yum install -y wget unzip
wget https://releases.hashicorp.com/consul/1.2.0/consul_1.2.0_linux_amd64.zip
unzip *.zip
rm -rf *.zip 
adduser consul
mkdir -p /etc/consul.d/{bootstrap,server,client}
mkdir /var/consul
chown consul:consul /var/consul
touch /etc/systemd/system/consul.service
touch /usr/local/etc/consul/server_agent.json
cat << EOF > /usr/local/etc/consul/server_agent.json
{
  "server": true,
  "node_name": "consul_s1",
  "datacenter": "dc1",
  "data_dir": "/var/consul",
  "bind_addr": "0.0.0.0",
  "client_addr": "0.0.0.0",
  "advertise_addr": "10.142.0.2",
  "bootstrap_expect": 2,
  "retry_join": ["10.142.0.2", "10.142.0.4"],
  "ui": true,
  "log_level": "DEBUG",
  "enable_syslog": true,
  "acl_enforce_version_8": false
}
EOF

cat <<EOF > /etc/systemd/system/consul.service
[Unit]
Description=Consul server agent
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

touch /etc/consul.d/start-consul.sh
cat <<EOF > /etc/consul.d/start-consul.sh
#!/bin/sh
/usr/local/bin/consul agent -config-file=/usr/local/etc/consul/server_agent.json

EOF

chmod +x /etc/consul.d/start-consul.sh

systemctl daemon-reload
systemctl start consul.service

