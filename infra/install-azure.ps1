
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

helm repo update

# cluster monitoring stack with prometheus and grafana ( https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack )
helm install prometheus-stack prometheus-community/kube-prometheus-stack `
 -f .\helm-values\prometheus-stack-values.yaml -f .\helm-values\prometheus-stack-values-azure.yaml `
 --namespace monitoring --create-namespace --atomic

# Custom Metrics API for the Horizontal Autoscale ( https://github.com/prometheus-community/helm-charts/tree/main/charts/prometheus-adapter )
helm install prometheus-adapter prometheus-community/prometheus-adapter -f .\helm-values\prometheus-adapter-values.yaml --namespace monitoring --create-namespace --atomic

kubectl apply -f .\monitoring-defaults.yaml
