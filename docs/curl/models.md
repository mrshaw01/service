# Models API

List available/deployed models for your account (OpenAI-compatible `GET /v1/models`).

```bash
curl -sS \
  "${OPENAI_BASE_URL}/models" \
  -H "X-User-Id: ${TENSORMESH_USER_ID}" \
  -H "Authorization: Bearer ${TENSORMESH_API_KEY}"
```

Notes:

- Some environments may allow `GET /models` without auth; if so, you can omit the `Authorization` header.
