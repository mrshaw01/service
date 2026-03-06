# curl quickstart

## Prereqs

```bash
.env
```

## Run

```bash
chmod +x examples/curl/*.sh
examples/curl/00_doctor.sh
examples/curl/10_models.sh
examples/curl/20_chat_completions.sh
examples/curl/21_chat_completions_stream.sh
examples/curl/22_chat_completions_json_mode.sh
examples/curl/23_chat_completions_tools_unsupported.sh
```

Notes:

- These call the OpenAI-compatible inference gateway at `OPENAI_BASE_URL` and always send `X-User-Id: $TENSORMESH_USER_ID`.
- Auth: set `TENSORMESH_API_KEY` for `/chat/completions`.
- Tool calling: Tensormesh gateway currently does not return structured `tool_calls` in responses.
