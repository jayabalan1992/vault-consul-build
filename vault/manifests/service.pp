class vault::service {
    service { 'vault':
      ensure   => 'running',
      enable   => true,
      provider => 'systemd',
    }
  }


