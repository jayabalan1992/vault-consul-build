class role::vault::server {
  include profile::vault
  include profile::consul::client
}

