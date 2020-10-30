
**Reference: https://kubernetes.io/docs/reference/kubectl/cheatsheet/**

```bash
kubectl apply -f ./my-manifest.yaml            # create resource(s)
kubectl apply -f ./my1.yaml -f ./my2.yaml      # create from multiple files
kubectl apply -f ./dir                         # create resource(s) in all manifest files in dir
kubectl apply -f https://git.io/vPieo          # create resource(s) from url

kubectl get services                          # List all services in the namespace
kubectl get pods --all-namespaces             # List all pods in all namespaces
kubectl get pods -o wide                      # List all pods in the current namespace, with more details
kubectl get deployment my-dep                 # List a particular deployment
kubectl get pods                              # List all pods in the namespace
kubectl get pod my-pod -o yaml                # Get a pod's YAML

# Describe commands with verbose output
kubectl describe nodes my-node
kubectl describe pods my-pod

# List Services Sorted by Name
kubectl get services --sort-by=.metadata.name

# Get pods by labels
kubectl get pods --selector=app=my-app

kubectl rollout history deployment/frontend                      # Check the history of deployments including the revision 
kubectl rollout undo deployment/frontend                         # Rollback to the previous deployment
kubectl rollout undo deployment/frontend --to-revision=2         # Rollback to a specific revision
kubectl rollout status -w deployment/frontend                    # Watch rolling update status of "frontend" deployment until completion
kubectl rollout restart deployment/frontend                      

# Force replace, delete and then re-create the resource. Will cause a service outage.
kubectl replace --force -f ./pod.yaml

kubectl edit svc/docker-registry                                  # Edit the service named docker-registry

# scale mysql to 3
kubectl scale --replicas=3 deployment/mysql

kubectl delete -f ./pod.json                                      # Delete a pod using the type and name specified in pod.json
kubectl delete pod,service baz foo                                # Delete pods and services with same names "baz" and "foo"
kubectl delete pods,services -l name=myLabel                      # Delete pods and services with label name=myLabel
kubectl -n my-ns delete pod,svc --all                             # Delete all pods and services in namespace my-ns,

kubectl logs my-pod                                               # dump pod logs (stdout)
kubectl logs -l name=myLabel                                      # dump pod logs, with label name=myLabel (stdout)
kubectl logs -f my-pod                                            # stream pod logs (stdout)
kubectl logs -f my-pod -c my-container                            # stream pod container logs (stdout, multi-container case)
kubectl logs -f -l name=myLabel --all-containers                  # stream all pods logs with label name=myLabel (stdout)

kubectl exec my-pod -- ls /                                       # Run command in existing pod (1 container case)
kubectl exec my-pod -c my-container -- ls /                       # Run command in existing pod (multi-container case)
kubectl top pod POD_NAME --containers                             # Show metrics for a given pod and its containers

kubectl cordon my-node                                            # Mark my-node as unschedulable
kubectl drain my-node                                             # Drain my-node in preparation for maintenance
kubectl uncordon my-node                                          # Mark my-node as schedulable
kubectl top node my-node                                          # Show metrics for a given node
kubectl cluster-info                                              # Display addresses of the master and services

kubectl config get-contexts                                       # display list of contexts 
kubectl config current-context                                    # display the current-context
kubectl config use-context my-cluster-name                        # set the default context to my-cluster-name
```