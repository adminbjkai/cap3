# Worker Auditor - AGENTS.md

## Model
- **Model**: Kimi-K2-Instruct
- **Context**: 128K
- **Max Steps**: 50

## Scope
- `apps/worker/src/**`
- Job queue logic in `apps/web-api/src/**`

## Tools
- filesystem (read-only)
- code-search (AST)
- git (blame)

## Output
- `artifacts/QUEUE_LOGIC_AUDIT.md`
