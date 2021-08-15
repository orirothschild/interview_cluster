
make sure pods are running and serving
=======
kubectl get pods -l app=queue \
    -o go-template='{{range .items}}{{.status.podIP}}{{"\n"}}{{end}}'

if a specific pod is required, lets test it is serving with 

for ep in <podIP><podPort>; do
    wget -qO- $ep
done

for ep in 10.0.1.73:5000; do
    wget -qO- $ep
done
make sure services are up and running:
kubectl get svc <<hostname>>

can our pod view our service?
=======
make sure kube-dns is working:
nslookup kubernetes.default
if successfull,
from inside a pod in our cluster run the follwing to test a service is in our dns:

nslookup "host name here"
if result looks like fleetman-webapp.default.svc.cluster.local 
then the service runs as the service name in the default namespace in the local cluster and is reachable

make sure the service serves is serving currectly by running curl command  from a node, or by using port forward
=======
1. get the ip of the previous service
2. exec into a pod
3. wget/curl/telnet the ip adress

make sure endpoints are alive if previous step failed such as the right selectors or right ports
kubectl get endpoints <<service_name>>
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







