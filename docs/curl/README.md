# curl examples (Tensormesh)

These are copy/paste-friendly `curl` examples for calling the Tensormesh OpenAI-compatible inference gateway.

## Prereqs

Set these env vars (recommended: copy `.env.example` to `.env` and export them in your shell):

- `OPENAI_BASE_URL` (must include `/v1`) — e.g. `https://external.YOUR_REGION.tensormesh.ai/v1`
- `TENSORMESH_USER_ID` — sent as `X-User-Id`
- `TENSORMESH_API_KEY` — bearer token for authenticated endpoints
- `OPENAI_MODEL` — your deployed model id

Tip: load `.env` into your current shell:

```bash
set -a
source .env
set +a
```

## Docs

- `docs/curl/models.md`
- `docs/curl/chat-completions.md`
- `docs/curl/chat-completions-stream.md`
- `docs/curl/chat-completions-json-mode.md`
- `docs/curl/chat-completions-tools.md`
