data "template_file" "nginx_ingress" {
  template = file("${path.module}/templates/values.yaml")
}

resource "helm_release" "nginx" {
  name            = "nginx"
  repository      = "ingress-nginx https://kubernetes.github.io/ingress-nginx"
  chart           = "ingress-nginx/ingress-nginx"
  namespace       = "kube-system"
  depends_on = [var.addon_depends_on_nodegroup_no_taint]
  set {
    name  = "controller.resources.requests.cpu"
    value = "100m"
  }
  set {
    name  = "controller.resources.requests.memory"
    value = "100Mi"
  }
  values = [ data.template_file.nginx_ingress.rendered ]
  # set {
  #   name  = "controller.tolerations"
  #   value = "[]"
  # }
  # set {
  #   name = "controller.nodeSelector"
  #   value = "{'kubernetes.io/os':'linux'}" # role: eks-apps-node-groups
  # }
  # set {
  #   name = "controller.service.annotations"
  #   value = {
  #     "service.beta.kubernetes.io/aws-load-balancer-type" = "nlb"
  #   }
  # }

  # set {
  #   name  = "controller.service.annotations"
  #   value = "service.beta.kubernetes.io/aws-load-balancer-type: nlb"
  # }

}