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

echo "Note: Tensormesh gateway currently does not return structured tool calls (tool_calls). This request demonstrates the payload shape only." >&2

resp="$(
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
    {"role": "system", "content": "You are a tool-using assistant. If a tool can answer, call it."},
    {"role": "user", "content": "What is the hourly price for sku H200? Use the tool."}
  ],
  "tools": [
    {
      "type": "function",
      "function": {
        "name": "lookup_price",
        "description": "Return hourly USD price for a GPU sku.",
        "parameters": {
          "type": "object",
          "properties": {"sku": {"type": "string"}},
          "required": ["sku"]
        }
      }
    }
  ],
  "tool_choice": "auto",
  "temperature": 0.0,
  "max_tokens": 200
}
JSON
)"

printf "%s\n" "${resp}"
if printf "%s" "${resp}" | grep -Eq '"tool_calls"[[:space:]]*:[[:space:]]*\\[[[:space:]]*\\{'; then
  echo "tool_calls detected (unexpected for this environment)." >&2
else
  echo "No tool_calls detected (expected): treat tool responses as plain text/JSON in content." >&2
fi
