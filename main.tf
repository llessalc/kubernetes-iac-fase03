terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.39"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.region_name
}


#######################
# MODULES
##################################

# NETWORKS
module "network" {
  source = "./modules/network"

  cluster_name = var.cluster_name
  region_name  = var.region_name
  vpc_name     = "${var.cluster_name}-vpc"
  igw_name     = "${var.cluster_name}-igw"

  priv_subnet_name = "${var.cluster_name}-private"
  pub_subnet_name  = "${var.cluster_name}-public"

  nat_name = "${var.cluster_name}-nat"
  eip_name = "${var.cluster_name}-eip"

}

# EKS CLUSTER AND CONTROL PLANE
module "eks_control_plane" {
  source = "./modules/control_plane"

  eks_role_name = "eks_iam_role"
  cluster_name  = var.cluster_name

  subnet_priv-a_id = module.network.subnet_priv-a_id
  subnet_priv-b_id = module.network.subnet_priv-b_id
  subnet_pub-a_id  = module.network.subnet_pub-a_id
  subnet_pub-b_id  = module.network.subnet_pub-b_id
}

# MANAGED NODE GROUP
module "workers_node_group" {
  source = "./modules/nodes"

  cluster_name     = module.eks_control_plane.eks_cluster_name
  subnet_priv-a_id = module.network.subnet_priv-a_id
  subnet_priv-b_id = module.network.subnet_priv-b_id

}
