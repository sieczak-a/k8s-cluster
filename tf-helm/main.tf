resource "helm_release" "nginx" {
  name             = "my-nginx"
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "nginx"
  version          = "15.3.0"
  namespace        = "nginx-tf"
  create_namespace = true

  values = [
    yamlencode({
      service = {
        type = "ClusterIP"
        port = 8080
      }
      replicaCount = 2
    })
  ]
}
