class vault (
  $user                                = $::vault::params::user,
  $manage_user                         = $::vault::params::manage_user,
  $group                               = $::vault::params::group,
  $manage_group                        = $::vault::params::manage_group,
  $download_url                        = $::vault::params::download_url,

) inherits ::vault::params {

  contain ::vault::install


}


