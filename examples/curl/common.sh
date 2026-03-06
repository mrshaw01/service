#!/usr/bin/env bash
set -euo pipefail

script_dir="$(
  cd -- "$(dirname -- "${BASH_SOURCE[0]}")" >/dev/null 2>&1
  pwd
)"
repo_root="$(cd -- "${script_dir}/../.." >/dev/null 2>&1 && pwd)"

dotenv_path="${DOTENV_PATH:-${repo_root}/.env}"

tm_load_env() {
  if [[ ! -f "${dotenv_path}" ]]; then
    echo "Missing ${dotenv_path}. Create it with: cp ${repo_root}/.env.example ${repo_root}/.env" >&2
    exit 1
  fi

  set -a
  # shellcheck disable=SC1090
  source "${dotenv_path}"
  set +a
}

tm_require() {
  local name="$1"
  if [[ -z "${!name:-}" ]]; then
    echo "Missing required env var: ${name} (from ${dotenv_path})" >&2
    exit 1
  fi
}

tm_require_model() {
  tm_require "OPENAI_MODEL"
}

tm_get_api_key() {
  if [[ -n "${TENSORMESH_API_KEY:-}" ]]; then
    echo "${TENSORMESH_API_KEY}"
    return 0
  fi
  echo ""
}

tm_require_api_key() {
  if [[ -z "${TM_API_KEY:-}" ]]; then
    echo "Missing API key: set TENSORMESH_API_KEY in ${dotenv_path}" >&2
    exit 1
  fi
}

tm_derive_base_url() {
  local base="${OPENAI_BASE_URL%/}"
  if [[ "${base}" != */v1 ]]; then
    base="${base}/v1"
  fi
  echo "${base}"
}

tm_derive_api_base_url() {
  if [[ -n "${TENSORMESH_API_BASE_URL:-}" ]]; then
    echo "${TENSORMESH_API_BASE_URL%/}"
    return 0
  fi

  # Best-effort default: strip `/v1` from the OpenAI-compatible base URL.
  # Warning: in some environments control-plane APIs are hosted on a different origin.
  local openai_base
  openai_base="$(tm_derive_base_url)"
  echo "${openai_base%/v1}"
}

tm_init() {
  tm_load_env
  tm_require "OPENAI_BASE_URL"
  tm_require "TENSORMESH_USER_ID"

  export TM_OPENAI_BASE_URL TM_API_BASE_URL TM_API_BASE_URL_SOURCE TM_CURL_CONNECT_TIMEOUT TM_CURL_MAX_TIME TM_API_KEY
  TM_OPENAI_BASE_URL="$(tm_derive_base_url)"
  if [[ -n "${TENSORMESH_API_BASE_URL:-}" ]]; then
    TM_API_BASE_URL="${TENSORMESH_API_BASE_URL%/}"
    TM_API_BASE_URL_SOURCE="TENSORMESH_API_BASE_URL"
  else
    TM_API_BASE_URL="$(tm_derive_api_base_url)"
    TM_API_BASE_URL_SOURCE="derived_from_OPENAI_BASE_URL"
  fi
  TM_CURL_CONNECT_TIMEOUT="${TM_CURL_CONNECT_TIMEOUT:-10}"
  TM_CURL_MAX_TIME="${TM_CURL_MAX_TIME:-60}"
  TM_API_KEY="$(tm_get_api_key)"
}
