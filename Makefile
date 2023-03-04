PROJECT = punkerside
ENV     = lab
SERVICE = argocd

cluster:
	@minikube start --kubernetes-version=1.25.7 --driver=docker

argocd:
	@kubectl create namespace argocd
	@kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

argocd-initial:
	@kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
	@kubectl port-forward svc/argocd-server -n argocd 8080:443

delete:
	@minikube delete