.cache/tools/linux_x86_64/up-v0.28.0  xpkg push --package=/home/ubuntu/work/crossplane-dev/crossplane-debug/some-provider/_output/xpkg/linux_amd64/some-provider-70251d1.xpkg  kind-registry:5000/some-provider:latest --insecure-skip-tls-verify
xpkg pushed to kind-registry:5000/some-provider:latest



sudo cp certs/domain.crt /usr/local/share/ca-certificates/kind-registry.crt
 sudo update-ca-certificates


 curl https://kind-registry:5000/v2/_catalog



 docker exec kind-control-plane mkdir -p /etc/containerd/certs.d/kind-registry:5000


 docker cp certs/domain.crt kind-control-plane:/etc/containerd/certs.d/kind-registry:5000/ca.crt


 sudo mkdir -p /etc/docker/certs.d/kind-registry:5000
 sudo cp certs/domain.crt /etc/docker/certs.d/kind-registry:5000/ca.crt
 sudo systemctl restart docker


docker exec -it kind-control-plane curl -vk https://kind-registry:5000/v2/_catalog


docker exec -it kind-control-plane crictl pull kind-registry:5000/nginx:test



docker run -d --restart=always --name kind-registry   -v $(pwd)/certs/domain.crt:/certs/domain.crt   -v $(pwd)/certs/domain.key:/certs/domain.key   -e REGISTRY_HTTP_ADDR=0.0.0.0:5000   -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/domain.crt   -e REGISTRY_HTTP_TLS_KEY=/certs/domain.key   -p 5000:5000 registry:2


openssl req -x509 -nodes -newkey rsa:2048   -keyout certs/domain.key   -out certs/domain.crt   -days 365   -config certs/openssl.cnf