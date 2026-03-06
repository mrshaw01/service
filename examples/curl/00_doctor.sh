#!/usr/bin/env bash
set -euo pipefail

script_dir="$(
  cd -- "$(dirname -- "${BASH_SOURCE[0]}")" >/dev/null 2>&1
  pwd
)"
# shellcheck disable=SC1091
source "${script_dir}/common.sh"

tm_init

mask_secret() {
  local s="$1"
  local n="${#s}"
  if ((n == 0)); then
    printf "%s" ""
    return 0
  fi
  if ((n <= 8)); then
    printf "%s" "****"
    return 0
  fi
  printf "%s" "${s:0:4}****${s: -4}"
}

echo "Tensormesh curl doctor"
echo
echo "curl: $(curl --version | head -n1)"
echo "dotenv: ${dotenv_path}"
echo
echo "OPENAI_BASE_URL: ${OPENAI_BASE_URL}"
echo "Derived TM_OPENAI_BASE_URL: ${TM_OPENAI_BASE_URL}"
echo "TENSORMESH_API_BASE_URL: ${TENSORMESH_API_BASE_URL:-<unset>}"
echo "Derived TM_API_BASE_URL (${TM_API_BASE_URL_SOURCE}): ${TM_API_BASE_URL}"
echo
echo "TENSORMESH_USER_ID: ${TENSORMESH_USER_ID}"
echo "OPENAI_MODEL: ${OPENAI_MODEL:-<unset>}"
echo "TENSORMESH_API_KEY: $(mask_secret "${TM_API_KEY:-}")"
echo
echo "timeouts: connect=${TM_CURL_CONNECT_TIMEOUT}s total=${TM_CURL_MAX_TIME}s"
echo
if [[ -z "${TM_API_KEY:-}" ]]; then
  echo "Next: set TENSORMESH_API_KEY in ${dotenv_path} to run authenticated requests." >&2
fi
