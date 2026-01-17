resource "kubernetes_namespace_v1" "nginx" {
  metadata {
    name = "nginx-helm"
  }
}
