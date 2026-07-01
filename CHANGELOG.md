## v1.1.0 (2026-07-01)

### Bug Fixes

- update Open WebUI to v0.10.2
- update Apache Tika to v3.3.1.0
- update Redis to v8.8.0
- update LiteLLM to v1.89.4
- pin to pgvector v0.8.4 on PostgreSQL 17
- update Ollama to v0.31.1
- update OpenClaw to v2026.6.1
- pin the desired qwen2.5-coder model by parameter count, matching the others

### New Features

- add preliminary support for OpenClaw

## v1.0.0 (2026-04-03)

### Bug Fixes

- update Open WebUI to version 0.8.12
- update LiteLLM to version 1.82.3-stable.patch.2

### New Features

- explain how to connect to Ollama running on the host
- embed the LiteLLM configuration in the Docker Compose project definition
- publish a Docker Compose project that runs LLMs locally

### Refactoring

- use YAML anchors/references to reduce repetition
