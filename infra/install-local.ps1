
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

helm repo update

# Ingress Http Proxy ( https://github.com/bitnami/charts/tree/master/bitnami/nginx-ingress-controller )
helm install nginx-ingress-proxy -f $PSScriptRoot\helm-values\nginx-ingress-controller-values.yaml ingress-nginx/ingress-nginx --namespace ingress --create-namespace --atomic

# cluster monitoring stack with prometheus and grafana ( https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack )
helm install prometheus-stack prometheus-community/kube-prometheus-stack -f $PSScriptRoot\helm-values\prometheus-stack-values.yaml --namespace monitoring --create-namespace --atomic

# Custom Metrics API for the Horizontal Autoscale ( https://github.com/prometheus-community/helm-charts/tree/main/charts/prometheus-adapter )
helm install prometheus-adapter prometheus-community/prometheus-adapter -f $PSScriptRoot\helm-values\prometheus-adapter-values.yaml --namespace monitoring --create-namespace --atomic

# Install metrics server ( https://github.com/bitnami/bitnami-docker-metrics-server )
helm install metrics-server bitnami/metrics-server -f $PSScriptRoot\helm-values\metrics-server-values.yaml --namespace monitoring --create-namespace --atomic

kubectl apply -f $PSScriptRoot\monitoring-defaults.yaml
