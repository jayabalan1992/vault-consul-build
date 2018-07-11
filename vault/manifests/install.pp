class vault::install {
  $vault_bin  = "${::vault::bin_dir}/vault"
  package {'unzip':
    provider =>  'yum',
    ensure   =>  installed,    
  }
  file { $::vault::download_dir:
    ensure   =>  directory,
  }  
  archive { "${::vault::download_dir}/vault.zip":
    ensure       => present,
    extract      => true,
    extract_path => $::vault::bin_dir,
    source       => $::vault::download_url,
    cleanup      => true,
    creates      => $vault_bin,
    before       => File['vault_binary'],
  }
  file { 'vault_binary':
    path  =>  $vault_bin,
    owner => 'root',
    group => 'root',
    mode  => '0755',
  }
  user { $::vault::user:
    ensure => present,   
  }
  Group[$vault::group] -> User[$vault::user]
  group { $::vault::group:
    ensure => present,
  }  
}

