# kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.4/manifests/namespace.yaml
# kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.4/manifests/metallb.yaml
# kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

# mac
# ./docker-tuntap-osx/sbin/docker_tap_install.sh
# ./docker-tuntap-osx/sbin/docker_tap_up.sh
# sudo route -v add -net 172.18.0.1 -netmask 255.255.0.0 10.0.75.2

helm install metallb metallb/metallb -f metallb-values.yaml
kubectl  create secret generic docker-config --from-file=.dockerconfigjson=config.json --type=kubernetes.io/dockerconfigjson
kubectl apply -f calico.yaml-3.20
calicoctl create -f calico-bgp.yaml
calicoctl create -f calico-peer.yaml

helmfile sync

kubectl apply -f metallb-test-ingress.yaml
