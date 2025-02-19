## If you already have helm installed, you can skip this step
## This is only needed for NGINX Controller. Istio is installed using istioctl

## Install Helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh