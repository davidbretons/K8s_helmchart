# variables.tf

variable "kind_cluster_name" {
  type        = string
  description = "Name of the cluster"
  #default     = "cluster-local"
}

variable "kind_cluster_config_path" {
  type        = string
  description = "Path to use for the kubeconfig"
#  default     = "~/.kube/config"
}