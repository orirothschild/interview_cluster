#!/bin/bash
echo "*************************************"
echo "*******************pushing to dockerhub**************"
echo "*************************************"

echo "$PASS" | docker login -u "$DOCKER_ID" --password-stdin

docker push orirothschild/fleetman-queue
docker push orirothschild/position-simulator
docker push orirothschild/position-tracker
docker push orirothschild/fleetman-api-gateway
docker push orirothschild/fleetman-webapp-angular