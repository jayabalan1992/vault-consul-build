class profiles::haproxyvault
  {  
  include ::haproxy
  haproxy::listen { 'vault':
    collect_exported => false,
    ipaddress        => '0.0.0.0',
    ports            => '443',
    mode             => 'tcp',
    options			 => {
      'balance'      => ['roundrobin'],
      'option'       => ['httpchk GET /v1/sys/health','tcplog'],
      'http-check'   => ['expect status 200'],   
    },
  }
  haproxy::balancermember { 'vault':
    listening_service => 'vault',
    server_names      => ['web1','web2'],
    ipaddresses       => [$vault_nodes_ips],
    ports             => '8200',
    options           => 'check check-ssl verify none',
  }
}
