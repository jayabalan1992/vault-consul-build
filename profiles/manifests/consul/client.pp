class profiles::consul::client {
  class { '::consul':
    version       => '1.2.0',
    config_hash   => {
      'data_dir'    => '/opt/consul',
      'datacenter'  => 'dc1',
      'log_level'   => 'DEBUG',
      'node_name'   => $facts['hostname'],
      'retry_join'  => [consul1_ip, consul2_ip, consul3_ip],
      'bind_addr'   => $facts['ipaddress'],
      'client_addr' => '127.0.0.1',
    },
  }
}
