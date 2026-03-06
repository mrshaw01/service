#!/usr/bin/env bash
set -euo pipefail

script_dir="$(
  cd -- "$(dirname -- "${BASH_SOURCE[0]}")" >/dev/null 2>&1
  pwd
)"
# shellcheck disable=SC1091
source "${script_dir}/common.sh"

tm_init

tm_require_api_key
tm_require_model

curl -sS  \
  --connect-timeout "${TM_CURL_CONNECT_TIMEOUT}" \
  --max-time "${TM_CURL_MAX_TIME}" \
  "${TM_OPENAI_BASE_URL}/chat/completions" \
  -H "Authorization: Bearer ${TM_API_KEY}" \
  -H "Content-Type: application/json" \
  -H "X-User-Id: ${TENSORMESH_USER_ID}" \
  -d @- <<JSON
{
  "model": "${OPENAI_MODEL}",
  "messages": [
    {"role": "system", "content": "You are a helpful assistant."},
    {"role": "user", "content": "Write a short haiku about cloud compute."}
  ],
  "temperature": 0.7
}
JSON
