

class vault::params {

  $user		  =  'vault'
  $manage_user    =  true
  $group          =  'vault'
  $manage_group   =  true
  $download_url   =  'https://releases.hashicorp.com/vault/0.10.3/vault_0.10.3_linux_amd64.zip'
  $bin_dir        =  '/usr/local/bin'
  $config_dir     =  '/etc/vault.d'
  $download_dir   = '/tmp'
  $enable_ui	  =  true
  $disable_mlock  =  false
  $agent_ip	  =  $facts['networking']['ip']
  $listener	= {
    'tcp' => { 
      'address'     => '127.0.0.1:8200',
      'tls_disable' => true,
      },
  }
  $storage  =  {
    'consul'  => {
    'address' => '127.0.0.1:8500',
    'path'    => 'vault/',
    'token'   => '5b5e7638-7f3a-495e-8635-7765e58fcd62',
     },
  }

}
