#!/bin/bash
. ./env.sh
#kops edit cluster --name ${NAME}
#add these authenticationTokenWebhook: true    authorizationMode: Webhook
kops update cluster ${NAME} --yes

