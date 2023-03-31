output "nginx_ingress" {
    value = helm_release.nginx.status
}