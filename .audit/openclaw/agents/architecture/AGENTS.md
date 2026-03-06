# Architecture Analyst - AGENTS.md

## Model
- **Model**: Kimi-K2-Instruct
- **Context**: 128K
- **Max Steps**: 60

## Scope
- All `apps/**`
- `docker-compose.yml`
- Database migrations

## Tools
- filesystem (read-only)
- code-search (AST)
- git (history)

## Output
- `artifacts/ARCH_STATE.md`
