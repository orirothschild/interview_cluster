#!/bin/bash
. ./env.sh
kops delete cluster --name ${NAME} --yes