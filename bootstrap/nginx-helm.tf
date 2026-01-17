resource "helm_release" "nginx" {
  name      = "nginx"
  namespace = kubernetes_namespace.nginx.metadata[0].name

  chart   = "oci://registry-1.docker.io/bitnamicharts/nginx"
  version = "22.4.3"

  wait    = false
  timeout = 180

  force_update  = true
  recreate_pods = true

  depends_on = [
    kubernetes_namespace.nginx
  ]
}
