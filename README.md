# kubernetes-iac - Fase05

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


## Enabling external access
The external access is handle by nginx ingress controller
and load balancer. To install the nginx controller after
the cluster creation one can use helm.

**Intalling helm (Windows):**
```
choco install kubernetes-helm
```

for other OS: https://helm.sh/docs/intro/install/

**install nginx repo:**
```
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
```

**deploy the nginx controller:**
```
helm upgrade -i --set controller.service.type=LoadBalancer --set controller.service.annotations."service\.beta\.kubernetes\.io/aws-load-balancer-type"="nlb" --set controller.autoscaling.maxReplicas=1 ingress-nginx ingress-nginx/ingress-nginx --set controller.service.annotations."service\.beta\.kubernetes\.io/aws-load-balancer-internal"="true"
```

**uninstall the nginx controller**
```
helm uninstall ingress-nginx
```

The annotation will provide an AWS network load balancer that
will be responsible for allowing communication between the
ingress controller and the internet.

### How to connect to the application
Run:
```
kubectl get svc
```

check the url

## cleanup

```
kubectl delete -f deployments
```

```
terraform destroy
```
