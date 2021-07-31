#!bin/bash
#deploy ingress resoures
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.48.1/deploy/static/provider/aws/deploy.yaml
#deploy ingress
kubectl create -f https://raw.githubusercontent.com/cornellanthony/nlb-nginxIngress-eks/master/example-ingress.yaml
