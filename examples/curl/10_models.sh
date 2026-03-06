#!/usr/bin/env bash
set -euo pipefail

script_dir="$(
  cd -- "$(dirname -- "${BASH_SOURCE[0]}")" >/dev/null 2>&1
  pwd
)"
# shellcheck disable=SC1091
source "${script_dir}/common.sh"

tm_init

curl_args=(
  -sS
  --connect-timeout "${TM_CURL_CONNECT_TIMEOUT}"
  --max-time "${TM_CURL_MAX_TIME}"
  "${TM_OPENAI_BASE_URL}/models"
  -H "X-User-Id: ${TENSORMESH_USER_ID}"
)
if [[ -n "${TM_API_KEY:-}" ]]; then
  curl_args+=(-H "Authorization: Bearer ${TM_API_KEY}")
fi

curl "${curl_args[@]}"
