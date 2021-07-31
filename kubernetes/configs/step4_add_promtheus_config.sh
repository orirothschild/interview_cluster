#!/bin/bash
kops edit cluster --name ${NAME}
#add these authenticationTokenWebhook: true    authorizationMode: Webhook