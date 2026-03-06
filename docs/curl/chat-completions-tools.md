# Chat Completions (Tools Payload Shape)

Demonstrates the request payload shape for tool calling (`tools`, `tool_choice`). Note: the Tensormesh gateway currently does not return structured `tool_calls` in responses.

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
```
