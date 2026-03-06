# Chat Completions (JSON Mode)

Request a JSON-only response (OpenAI-compatible `response_format` with `{"type":"json_object"}`).

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
    {
      "role": "system",
      "content": "Return ONLY a JSON object with keys: ok (boolean), notes (string)."
    },
    {"role": "user", "content": "Say ok=true and add a short note."}
  ],
  "response_format": {"type": "json_object"},
  "temperature": 0.0,
  "max_tokens": 120
}
JSON
```
