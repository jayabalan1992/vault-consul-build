class profile::consul::server {
  class { '::consul':
  config_hash          => {
    'bootstrap_expect' => 1,
    'data_dir'         => '/opt/consul',
    'datacenter'       => 'dc1',
    'log_level'        => 'DEBUG',
    'node_name'        => 'server',
    'server'           => true,
    'ui'	       => true, 
    'advertise_addr'   => $facts['networking']['ip']
    }
  }
}
