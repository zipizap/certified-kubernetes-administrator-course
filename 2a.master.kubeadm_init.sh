#!/usr/bin/env bash
# zipizap
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
function shw_info { echo -e '\033[1;34m'"$1"'\033[0m'; }
function error { echo "ERROR in ${BASH_LINENO[0]} : $@"; exit 1; }
exec > >(tee -i /tmp/$(date +%Y%m%d%H%M%S.%N)__$(basename $0).log ) 2>&1
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace
export PS4='||||| $0.$LINENO || '

set -x
ENP0S8_IP=$(ip -f inet addr show enp0s8 | grep -Po 'inet \K[\d.]+')
(sudo kubeadm init \
  --pod-network-cidr 10.244.0.0/16 \
  --apiserver-advertise-address=${ENP0S8_IP}
) &> kubeadm_init.log

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config


# https://www.weave.works/docs/net/latest/kubernetes/kube-addon/#install
#kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')&env.IPALLOC_RANGE=10.244.0.0/16"
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
sleep 60
kubectl get pod -A

## untait master-node to accept workloads
#kubectl taint nodes --all node-role.kubernetes.io/master-

# create new token to join-nodes latter
kubeadm token create --print-join-command | tee kubeadm_join_command_for_additional_nodes.txt
  # kubeadm join 192.168.56.2:6443 --token 4801yv.n2dycj5vg58njisg --discovery-token-ca-cert-hash sha256:c51a1f01278c3153672f7460a79a6743043223b17dcf74b12a51b4da1c28a009
kubeadm token list

shw_info "$0 Completed successfully"
