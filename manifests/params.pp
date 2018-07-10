

class vault::params {

	$user		=  'vault'
	$manage_user    =  true
        $group		=  'vault'
        $manage_group   =  true
 	$download_url   =  'https://releases.hashicorp.com/vault/0.10.3/vault_0.10.3_linux_amd64.zip'
        $bin_dir        =  '/usr/local/bin'
	$listener	= {
	  'tcp' => { 
          'address'     => '127.0.0.1:8200',
	  'tls_disable' => 'true',
           }
         }



}
