# Chat Completions (Streaming)

Stream tokens back as Server-Sent Events (OpenAI-compatible `POST /v1/chat/completions` with `"stream": true`).

```bash
curl -N -sS \
  "${OPENAI_BASE_URL}/chat/completions" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${TENSORMESH_API_KEY}" \
  -H "X-User-Id: ${TENSORMESH_USER_ID}" \
  -d @- <<JSON
{
  "model": "${OPENAI_MODEL}",
  "stream": true,
  "messages": [
    {"role": "user", "content": "Stream a 1-paragraph answer about on-demand inference."}
  ]
}
JSON
```
