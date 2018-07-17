class profile::consul::client {
  class { '::consul':
  config_hash    => {
    'data_dir'   => '/opt/consul',
    'datacenter' => 'dc1',
    'log_level'  => 'DEBUG',
    'node_name'  => $facts['hostname'],
    'retry_join' => ['192.168.33.12'],
    'bind_addr'  => $facts['networking']['interfaces']['eth1']['ip'],
    'client_addr'=> '127.0.0.1',
    }
  }
}
