# Class vault parameters 
class vault (
  $user                                = $::vault::params::user,
  $manage_user                         = $::vault::params::manage_user,
  $group                               = $::vault::params::group,
  $manage_group                        = $::vault::params::manage_group,
  $download_url                        = $::vault::params::download_url,
  $purge_config_dir		       = true,

) inherits ::vault::params {

  contain ::vault::install
  contain ::vault::config
  contain ::vault::service

  Class['vault::install'] -> Class['vault::config']
  Class['vault::config'] ~> Class['vault::service']

}


