resource "null_resource" "example" {
  # On success, this will attempt to execute the true command in the
  # shell environment running terraform.
  # On failure, this will attempt to execute the false command in the
  # shell environment running terraform.
  provisioner "local-exec" {
    command = contains([200, 204], data.http.example.status_code)
  }
}

data "http" "example" {
  url = "https://checkpoint-api.hashicorp.com/v1/check/terraform"

  # Optional request headers
  request_headers = {
    Accept = "application/json"
  }
}

output "status_code" {
  value       = data.http.example.status_code
}

output "response" {
  value       = data.http.example.response_body
}
