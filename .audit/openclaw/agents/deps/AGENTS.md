# Dependency Analyzer - AGENTS.md

## Model
- **Model**: Kimi-K2-Instruct
- **Context**: 128K
- **Max Steps**: 40

## Scope
- `package.json` files
- `pnpm-lock.yaml`
- `.github/workflows/**`

## Tools
- filesystem (read-only)
- shell (npm audit, jq)

## Output
- `artifacts/DEPENDENCY_ANALYSIS.md`
