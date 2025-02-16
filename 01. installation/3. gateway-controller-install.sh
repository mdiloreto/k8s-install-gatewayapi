helm pull oci://ghcr.io/nginx/charts/nginx-gateway-fabric --untar
cd nginx-gateway-fabric
helm install ngf . --create-namespace -n nginx-gateway
kubectl wait --timeout=5m -n nginx-gateway deployment/ngf-nginx-gateway-fabric --for=condition=Available
