class role::vaultserver {
  include profile::vault
  include profile::consul::client
}

