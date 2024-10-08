ui = true
cluster_addr  = "http://0.0.0.0:8201"
api_addr = "http://0.0.0.0:8200"

default_lease_ttl = "168h"
max_lease_ttl = "0h"

listener "tcp" {
  address = "0.0.0.0:8200"
  tls_disable = "true"
  tls_cert_file = ""
}
backend "file" {
  path = "/vault/file"
}

storage "file" {
  path = "/vault/data"
}