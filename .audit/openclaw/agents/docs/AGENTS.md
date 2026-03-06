# Docs Checker - AGENTS.md

## Model
- **Model**: Kimi-K2-Instruct
- **Context**: 128K
- **Max Steps**: 40

## Scope
- `README.md`
- `docs/**/*.md`
- `ENDPOINTS.md`

## Tools
- filesystem (read-only)
- code-search (for comparison)

## Output
- `artifacts/DOCS_CONSISTENCY_REPORT.md`
