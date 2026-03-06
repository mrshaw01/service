## Tensormesh Inference

This repository is a minimal "bring your own client" starter for calling the Tensormesh LLM inference service through an OpenAI-compatible inference endpoint.

## Environment setup

### Python environment (`.venv`)

Use a single project-local virtual environment (`.venv`) for all notebooks in this repository.

1. Install Python 3.12 if not already available.
2. Create and activate `.venv`:
   ```bash
   python3.12 -m venv .venv
   source .venv/bin/activate
   ```
3. Verify Python and pip are from `.venv`:
   ```bash
   which python
   # .../serving-scenarios/.venv/bin/python
   which pip
   # .../serving-scenarios/.venv/bin/pip
   ```
4. Install dependencies:
   ```bash
   pip install --upgrade pip wheel
   pip install -r requirements.txt
   ```

### Runtime configuration (`.env`)

1. Copy `.env.example` to `.env`.
2. Fill the four required values listed above.

## curl quickstart

- Runnable scripts: `examples/curl/README.md`
- Copy/paste snippets: `docs/curl/README.md`
