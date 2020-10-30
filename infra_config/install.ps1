kubectl apply -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/release-0.42/example/prometheus-operator-crd/monitoring.coreos.com_alertmanagers.yaml
kubectl apply -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/release-0.42/example/prometheus-operator-crd/monitoring.coreos.com_podmonitors.yaml
kubectl apply -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/release-0.42/example/prometheus-operator-crd/monitoring.coreos.com_prometheuses.yaml
kubectl apply -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/release-0.42/example/prometheus-operator-crd/monitoring.coreos.com_prometheusrules.yaml
kubectl apply -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/release-0.42/example/prometheus-operator-crd/monitoring.coreos.com_servicemonitors.yaml
kubectl apply -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/release-0.42/example/prometheus-operator-crd/monitoring.coreos.com_thanosrulers.yaml
kubectl apply -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/release-0.42/example/prometheus-operator-crd/monitoring.coreos.com_probes.yaml

kubectl apply -f ./
