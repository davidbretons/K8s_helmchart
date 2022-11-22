# versions.tf

terraform {
  required_providers {
    kind = {
      source  = "kyma-incubator/kind"
      version = "0.0.11"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.15.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "2.7.1"
    }

    null = {
      source  = "hashicorp/null"
      version = "3.2.0"
    }
  }

  required_version = ">= 1.0.0"
}
