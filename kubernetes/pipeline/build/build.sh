#!/bin/bash

echo "*************************"
echo "****retag images****"
echo "*************************"
docker-retag richardchesterwood/k8s-fleetman-queue:release2 orirothschild/fleetman-queue
docker-retag richardchesterwood/k8s-fleetman-position-simulator:release2 orirothschild/position-simulator
docker-retag richardchesterwood/k8s-fleetman-position-tracker:release3 orirothschild/position-tracker
docker-retag richardchesterwood/k8s-fleetman-api-gateway:release2 orirothschild/fleetman-api-gateway
docker-retag richardchesterwood/k8s-fleetman-webapp-angular:release2 orirothschild/fleetman-webapp-angular