class profiles::vault {
  class { '::vault':
    listener => {
      'tcp' => {
        'address'       => '0.0.0.0:8200',
        'tls_disable'   => false,
        'tls_cert_file' => '/etc/vault.d/keys/localhost.crt',
        'tls_key_file'  => '/etc/vault.d/keys/localhost.key'
      },
    }, 
    storage   => {
      'consul'  => {
        'address' => '127.0.0.1:8500',
        'path'    => 'vault/',
        'token'   => <token>,
      },
    }
  }
  Class['profiles::vault']
  ~> Class['vault::service']
}

