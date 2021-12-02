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

vagrant up
