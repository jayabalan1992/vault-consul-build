class vault::config {

  $config_hash = delete_undef_values({
  'storage'           => $::vault::storage,
  'listener'          => $::vault::listener,
  'disable_mlock'     => $::vault::disable_mlock,
  'ui'                => $::vault::enable_ui,
  'api_addr' 	      => "http://${::vault::agent_ip}:8200",
  'cluster_addr'      => "http://${::vault::agent_ip}:8201",
  })

  file { $::vault::config_dir:
    ensure  => directory,
    purge   => $::vault::purge_config_dir,
    recurse => $::vault::purge_config_dir,
    owner   => $::vault::user,
    group   => $::vault::group,
  }

  file { "${::vault::config_dir}/config.json":
    content => to_json_pretty($config_hash),
    owner   => $::vault::user,
    group   => $::vault::group,
  }  

  file { '/etc/systemd/system/vault.service':
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template('vault/vault.service.erb'),
  }~>

  exec { 'vaultservice-systemd-reload':
    command     => 'systemctl daemon-reload',
    path        => [ '/usr/bin', '/bin', '/usr/sbin' ],
    refreshonly => true,
  }  
}
