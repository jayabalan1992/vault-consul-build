class profile::consul::client {
  class { '::consul':
  config_hash => {
    'data_dir'   => '/opt/consul',
    'datacenter' => 'dc1',
    'log_level'  => 'DEBUG',
    'node_name'  => 'agent',
    'retry_join' => ['10.0.2.15'],
    }
  }
}
