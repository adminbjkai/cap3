# Audit Orchestrator Skill

## Purpose
Defines the workflow phases, spawn policies, and stop conditions for the multi-agent audit system.

## Workflow Phases

### Phase 1: Repository Survey
- Run `index_repo.sh`
- Generate `INDEX.md`
- Identify services, entry points, boundaries

### Phase 2: Architecture Analysis
- Delegate to Architecture Analyst
- Generate `ARCH_STATE.md`
- Map service topology

### Phase 3: Parallel Code Analysis
- Backend Reviewer (API logic)
- Frontend Reviewer (React/UI)
- Worker Auditor (queue logic)

### Phase 4: Infrastructure + Hygiene
- Config Auditor (Docker, env)
- Dead Code Detector
- Dependency Analyzer

### Phase 5: Risk + Documentation
- Security Risk Assessor (synthesizes findings)
- Documentation Consistency Checker

### Phase 6: Final Synthesis
- Orchestrator reads all artifacts
- Deduplicates findings
- Generates `FINAL_AUDIT_REPORT.md`

## Spawn Policy

```yaml
max_concurrent: 6
max_depth: 2
refinement_rounds: 1
timeout_seconds: 600
```

## Stop Conditions
- All TASKS.json entries completed
- All artifacts present
- No contradictions remaining
- Report generated
