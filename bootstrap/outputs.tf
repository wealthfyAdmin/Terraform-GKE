output "nginx_namespace" {
  value = kubernetes_namespace.nginx.metadata[0].name
}

output "nginx_release" {
  value = helm_release.nginx.name
}
