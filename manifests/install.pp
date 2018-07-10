class vault::install {

      $vault_bin  = "${::vault::bin_dir}/vault"

    
    
  
    archive { "${::vault::download_dir}/vault.zip":
          ensure       => present,
          extract      => true,
          extract_path => $::vault::bin_dir,
          source       => $::vault::download_url,
          cleanup      => true,
          creates      => $vault_bin,
          before       => File['vault_bin'],
      }

    file { $vault_bin:
    	owner => 'root',
    	group => 'root',
    	mode  => '0555',
      }


      file { '/etc/systemd/system/vault.service':
          ensure  => file,
          owner   => 'root',
          group   => 'root',
          mode    => '0644',
          content => template('vault/vault.systemd.erb'),
          notify  => Exec['systemd-reload'],
        } 
      exec {'systemd-reload':
            command     => 'systemctl daemon-reload',
            path        => '/bin:/usr/bin:/sbin:/usr/sbin',
            user        => 'root',
            refreshonly => true,
          }

}
