class roles::vault::vaultserver {
  include ::profiles::vault
  include ::profiles::consul::client
}

