# Dead Code Detector - AGENTS.md

## Model
- **Model**: Kimi-K2-Instruct
- **Context**: 128K
- **Max Steps**: 50

## Scope
- All `**/*.ts`, `**/*.tsx`

## Tools
- filesystem (read-only)
- code-search (AST references)
- shell (rg, grep)

## Output
- `artifacts/PRUNING_RECOMMENDATIONS.md`
