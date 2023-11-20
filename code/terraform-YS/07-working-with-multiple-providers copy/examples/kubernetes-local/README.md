Scenario 1: Access web app through ingress-nginx=controller

Additional steps to be performed to be abel to hit the
webservice on port 8080 after deployment and service are created through TF

-create ingress resource:
kubectl create ingress simple-webapp --class=nginx   --rule="simple-webapp.me/*=simple-webapp:80"

-Expose port 8080 from outside on the localhost and resirect it to the ingress nginx service listening on port 80:
kubectl port-forward --namespace=ingress-nginx service/ingress-nginx-controller 8080:80 &


-Run following curl command:
curl --resolve simple-webapp.me:8080:127.0.0.1 http://simple-webapp.me:8080

Handling connection for 8080
Hello Terraform!



Scenario 2: Access web app through MetalLB controller

-create ingress resource:
kubectl create ingress simple-webapp --class=nginx   --rule="simple-webapp.me/*=simple-webapp:80"

-if you describe the newly created service fo for the webapp as seen below, you will see the: LoadBalancer Ingress:     172.18.0.3
which is assigned by MetalLB controller

 2023-11-20 15:39:55 ⌚  ip-10-23-84-51 in ~/Training/TF/code/terraform/07-working-with-multiple-providers/examples/kubernetes-local
± |master ↑15 U:5 ✗| → kind-kind-3 → k describe svc -n default simple-webapp
Name:                     simple-webapp
Namespace:                default
Labels:                   <none>
Annotations:              <none>
Selector:                 app=simple-webapp
Type:                     LoadBalancer
IP Family Policy:         SingleStack
IP Families:              IPv4
IP:                       10.96.227.193
IPs:                      10.96.227.193
LoadBalancer Ingress:     172.18.0.3
Port:                     <unset>  80/TCP
TargetPort:               5000/TCP
NodePort:                 <unset>  32078/TCP
Endpoints:                10.244.1.5:5000,10.244.3.6:5000
Session Affinity:         None
External Traffic Policy:  Cluster
Events:
  Type    Reason        Age                From                Message
  ----    ------        ----               ----                -------
  Normal  IPAllocated   45m                metallb-controller  Assigned IP ["172.18.0.3"]
  Normal  nodeAssigned  43m (x2 over 44m)  metallb-speaker     announcing from node "kind-3-worker3"


-make a call to the respective address with DNS resolution added in the command and result is the same

 2023-11-20 15:59:19 ⌚  ip-10-23-84-51 in ~/Training/TF/code/terraform/07-working-with-multiple-providers/examples/kubernetes-local
± |master ↑15 U:5 ?:1 ✗| → kind-kind-3 → curl --resolve simple-webapp.me:80:172.18.0.3 http://simple-webapp.me:80
Hello Terraform!
