# Check if GatewayAPI is installed: 

kubectl get crd | grep gateway

# Install 1.2.0 version of GatewayAPI

kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.2.0/standard-install.yaml

