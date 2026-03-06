# Finding Schema Skill

## Purpose
Forces every agent to emit normalized findings with structured evidence.

## Required Fields

```json
{
  "finding_id": "string (e.g., CAP-AUDIT-001)",
  "category": "architecture|backend|frontend|config|dependency|docs|ops",
  "severity": "critical|high|medium|low|info",
  "confidence": 0.0,
  "summary": "Clear, actionable description",
  "evidence": [
    {
      "type": "file|symbol|command|scan|git",
      "path": "optional file path",
      "symbol": "optional symbol name",
      "locator": "line range or query id",
      "snippet": "minimal code excerpt",
      "artifact": "optional artifact reference"
    }
  ],
  "impact": "What this affects and why it matters",
  "recommendation": "Specific fix with example",
  "owner_hint": "team or individual",
  "needs_follow_up": false
}
```

## Severity Levels

- **Critical**: Security vulnerability, data loss risk, production outage
- **High**: Performance issue, significant tech debt, broken functionality
- **Medium**: Code smell, missing tests, documentation gap
- **Low**: Style issue, minor optimization
- **Info**: Observation, suggestion

## Confidence Scoring

- 0.9-1.0: Certain (reproducible, documented)
- 0.7-0.89: High confidence (clear evidence)
- 0.5-0.69: Medium (some ambiguity)
- 0.3-0.49: Low (educated guess)
- <0.3: Flag for human review

## Validation

All findings must:
1. Have at least one evidence item
2. Include file path for code issues
3. Provide actionable recommendation
4. Use correct category for routing
