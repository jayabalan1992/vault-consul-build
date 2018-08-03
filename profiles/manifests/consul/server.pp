class profiles::consul::server {
  class { '::consul':
    version            => '1.2.0',
    config_hash        => {
      'bootstrap_expect' => 3,
      'data_dir'         => '/opt/consul',
      'datacenter'       => 'dc1',
      'log_level'        => 'DEBUG',
      'node_name'        => $facts['hostname'],
      'server'           => true,
      'ui'               => true,
      'retry_join'       => [consul1_ip, consul2_ip, consul3_ip],
      'advertise_addr'   => $facts['ipaddress'],
      'client_addr'      => '0.0.0.0',
    },
  }
}
