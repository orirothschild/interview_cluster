#!/bin/bash

helm repo add stable https://kubernetes-charts.storage.googleapis.com
kubectl apply -f ../aws_storage/storage-aws.yaml
helm install nginx-ingress stable/nginx-ingress --set controller.publishService.enabled=true
helm install monitoring stable/prometheus-operator
kubectl delete secret alertmanager-monitoring-prometheus-oper-alertmanager
kubectl create secret generic alertmanager-monitoring-prometheus-oper-alertmanager --from-file ../secrets/alertmanager.yaml
