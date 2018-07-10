listener "tcp" {
  address          = "0.0.0.0:8200"
  cluster_address  = "172.20.128.159:8201"
  tls_disable      = "true"
#  tls_cert_file="/etc/vault.d/domain.crt"
#  tls_key_file="/etc/vault.d/domain.key"

}
storage "consul" {
  address = "127.0.0.1:8500"
  path    = "vault/"
  token = "5b5e7638-7f3a-495e-8635-7765e58fcd62" 
}
ui = true
api_addr = "http://172.20.128.159:8200"
cluster_addr = "http://172.20.128.159:8201"
