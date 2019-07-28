# k8s-secure-ingress-nginx-configuration

This repository describe how to configure nginx in secured way to comply with security.

# Step #1, Install ingresss-nginx by using helm
Refer : https://github.com/helm/charts/tree/master/stable/nginx-ingress
```sh
$ ./00_ingress-installation/k8s-helm-ingress-nginx.sh
```
After run this script, you will get
- New namespace named : ingress-nginx
- New ingress-nginx pod which is deployed to namespace "ingress-nginx"
  ingress-nginx will configued with nginxClass named "public"
  and
  applied new configmap which is secured configuration

# Step #2, Build nginx image
```sh
$ cd 01_example-kubernetes-ingress
$ docker build -t <username>/secued-nginx:1.0.0 .
```
# Step #3, Deploy ingress
```sh
$ kubectl apply -f 01_example-kubernetes-ingress/ingress-annotation.yaml
```