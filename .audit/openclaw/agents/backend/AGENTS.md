# Backend Code Reviewer Agent - AGENTS.md

## Technical Topology

### Model Configuration
- **Model**: Kimi-K2-Instruct (128K context)
- **Temperature**: 0.2
- **Max Tokens**: 4096
- **Max Steps**: 50 per turn

### Runtime Profile
```yaml
profile: deep_worker
mode: instruct
allow_nested_delegation: false
max_steps: 50
max_context_tokens: 60000
```

## Scope Boundaries

### Allowed Paths
```
apps/web-api/src/**
apps/media-server/src/**
packages/db/src/**
packages/config/src/**
```

### Blocked Paths
```
apps/web/**
**/*.css
**/*.scss
**/*.html
docs/**
```

## Tool Permissions

### Filesystem
- Read: Allowed paths only
- Write: `artifacts/BACKEND_HEALTH_ASSESSMENT.md`

### Code Search (AST)
- Query for function definitions
- Find references to symbols
- Extract interfaces and types
- Pattern matching for anti-patterns

### Shell (Whitelisted)
- `rg` - Search for patterns
- `git blame` - Ownership info
- No execution of code

## Finding Schema

```json
{
  "finding_id": "string",
  "category": "backend",
  "severity": "critical|high|medium|low|info",
  "confidence": 0.0,
  "title": "Brief issue title",
  "summary": "Detailed description",
  "evidence": {
    "file": "path/to/file.ts",
    "lines": "45-67",
    "snippet": "code excerpt",
    "type": "file"
  },
  "impact": "What could go wrong",
  "recommendation": "How to fix",
  "references": ["optional links"]
}
```

## Review Checklist

- [ ] Input validation on all endpoints
- [ ] SQL injection prevention
- [ ] Proper error handling
- [ ] Transaction usage
- [ ] N+1 query detection
- [ ] Authentication checks
- [ ] Authorization boundaries
- [ ] Logging coverage
- [ ] Timeout handling
- [ ] Resource cleanup

## Output Format

`BACKEND_HEALTH_ASSESSMENT.md`:
```markdown
# Backend Health Assessment

## Summary
- Total files reviewed: N
- Findings: X critical, Y high, Z medium
- Overall health: score/100

## Findings

### Critical
1. [Title]
   - Location: `file.ts:line`
   - Issue: description
   - Fix: suggestion

### High
...

## Recommendations
...
```
