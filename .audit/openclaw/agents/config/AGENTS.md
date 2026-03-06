# Config Auditor - AGENTS.md

## Model
- **Model**: Kimi-K2-Instruct
- **Context**: 128K
- **Max Steps**: 40

## Scope
- `docker-compose.yml`
- `Dockerfile`
- `Makefile`
- `.env.example`
- `docs/ops/**`

## Tools
- filesystem (read-only)
- shell (cat, grep)

## Output
- `artifacts/INFRASTRUCTURE_AUDIT.md`
