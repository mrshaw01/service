# Chat Completions API

Create a chat completion (OpenAI-compatible `POST /v1/chat/completions`).

```bash
curl -sS \
  "${OPENAI_BASE_URL}/chat/completions" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${TENSORMESH_API_KEY}" \
  -H "X-User-Id: ${TENSORMESH_USER_ID}" \
  -d @- <<JSON
{
  "model": "${OPENAI_MODEL}",
  "messages": [
    {"role": "system", "content": "You are a helpful assistant."},
    {"role": "user", "content": "Explain quantum computing in simple terms."}
  ],
  "temperature": 0.7
}
JSON
```
