# kubernetes-iac

## Purpose
This repository will be responsible
for creating all the resources to deploy
Kubernetes in AWS.

### Modules
- control_plane: EKS cluster, cluster IAM
- network: subnets, route tables, internet gateway, NAT gateway, VPC, 
            table associations, elastic IPs
- nodes: Managed node group, node group IAM

## Creating and destroying infrastructure
For now, two **variables** are used, they are
**cluster_name** and **region_name**, both of them are
declared in [**variables.tf**](variables.tf). 
One can set the values of the variables in
[**terraform.tfvars**](terraform.tfvars)

To create resources:
- terraform init
- terraform plan
- terraform apply

To destroy resources:
- terraform destroy

## Connecting kubeclt
After the cluster creation run the following command, replacing
**region-code** and **my-cluster** by your values:
- aws eks update-kubeconfig --region region-code --name my-cluster

After that, one can use kubectl to interact with the EKS cluster




