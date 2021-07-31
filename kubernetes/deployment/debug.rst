
make sure pods are running and serving
=======
kubectl get pods -l app=queue \
    -o go-template='{{range .items}}{{.status.podIP}}{{"\n"}}{{end}}'

make sure services are served with dns
=======
nslookup "host name here"
if result looks like fleetman-webapp.default.svc.cluster.local
then the service runs as the service name in the default namespace in the local cluster

make sure the service serves its pods by curling its ip from the cluster
=======
1. get the ip of the previous service
2. exec into a pod
3. wget/curl/telnet the ip adress

3a.if service doesnt respond we can wget the ip of any of the pods in the deployments


make sure endpoints are alive if previous step failed such as the right selectors or right ports
=======

make sure kube-proxy works right
=======
ps auxw | grep kube-proxy

check ingress is configured well
=======
kubectl get ing "ingress name"
check ingress logs rout successfully from its logs 
=======
kubectl logs -n ingress-nginx "nginx pod"



test services:
1. kubectl port forward to the service







