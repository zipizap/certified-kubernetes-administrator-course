#!/usr/bin/env bash
# zipizap
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
function shw_info { echo -e '\033[1;34m'"$1"'\033[0m'; }
function error { echo "ERROR in ${BASH_LINENO[0]} : $@"; exit 1; }
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace
export PS4='||||| $0.$LINENO || '

#sudo kubeadm join 192.168.56.2:6443 --token v9sqfa.28qcqumivmejv1ml --discovery-token-ca-cert-hash sha256:c51a1f01278c3153672f7460a79a6743043223b17dcf74b12a51b4da1c28a009
#shw_info "$0 Completed successfully"
