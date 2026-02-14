output "ip" {
  value = chomp(data.http.my_ip.response_body)
}