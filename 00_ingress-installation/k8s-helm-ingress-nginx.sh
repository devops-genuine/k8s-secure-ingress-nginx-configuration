#! /bin/bash

kubectl create ns ingress-nginx

helm install -f public-value.yaml --name ingress-public stable/nginx-ingress --version 1.4.0 --namespace ingress-nginx \
  --set controller.ingressClass=public \
  --set controller.daemonset.useHostPort=\"false\" \
  --set controller.service.enableHttp=\"true\" \
  --set controller.service.enableHttps=\"true\" \
  --set controller.service.targetPorts.http=80 \
  --set controller.service.targetPorts.https=443

kubectl create configmap ingress-public-nginx-ingress-controller --dry-run=true -o yaml \
  --from-literal=add-headers='ingress-nginx/custom-headers' \
  --from-literal=proxy-body-size='10m' \
  --from-literal=server-tokens='false' \
  --from-literal=enable-vts-status='false' |
  kubectl apply -f - -n ingress-nginx

kubectl delete pod -l release=ingress-public -n ingress-nginx