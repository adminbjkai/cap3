# Orchestrator Agent - AGENTS.md

## Technical Topology

### Model Configuration
- **Model**: Kimi-K2-Thinking (256K context)
- **Temperature**: 0.3
- **Max Tokens**: 8192
- **Max Steps**: 120 per turn

### Runtime Profile
```yaml
profile: orchestrator
mode: reasoning
allow_nested_delegation: false
max_concurrent_subagents: 6
run_timeout_seconds: 600
```

## Tool Allow/Deny Lists

### Allowed Tools (MCP)
| Tool | Purpose | Constraints |
|------|---------|-------------|
| filesystem | Read repository files | Read-only, root-bounded |
| git | History, blame, diff | No write operations |
| code-search | Symbol/AST queries | Max 100 results per query |
| shell | Analysis commands | Whitelist only |

### Allowed Shell Commands
- `rg` - ripgrep text search
- `git` - version control
- `scc` / `cloc` - code statistics
- `find`, `wc`, `jq` - file utilities
- `cat`, `head`, `tail` - file reading

### Blocked Operations
- No file writes outside artifacts/, reports/, findings/
- No `npm install`, `pnpm install`, or package modifications
- No Docker commands
- No network requests (except through MCP)
- No `eval`, `exec`, or dynamic code execution

## File Access Patterns

### Read Access
- `apps/*` - Application source code
- `packages/*` - Shared packages
- `docs/*` - Documentation
- `docker-compose.yml` - Infrastructure
- `*.md` - Markdown documentation
- `*.json` - Configuration files

### Write Access (Restricted)
- `artifacts/*.md` - Agent outputs
- `findings/*.json` - Structured findings
- `reports/*.md` - Generated reports
- `TASKS.json` - Task ledger

### Blocked Paths
- `.env*` - Environment files with secrets
- `node_modules/` - Dependencies
- `.git/` - Git internals
- `dist/` - Build outputs

## Evidence Contract Enforcement

Every finding must include:
```json
{
  "finding_id": "CAP-AUDIT-001",
  "category": "architecture|backend|frontend|config|dependency|docs|ops",
  "severity": "critical|high|medium|low|info",
  "confidence": 0.85,
  "summary": "Clear description",
  "evidence": [
    {
      "type": "file|symbol|command|scan|git",
      "path": "apps/web-api/src/index.ts",
      "locator": "line 45-67",
      "snippet": "optional code excerpt"
    }
  ],
  "impact": "What this affects",
  "recommendation": "How to fix",
  "owner_hint": "team/person"
}
```

## Concurrency Controls

- Maximum 6 concurrent specialist agents
- Maximum 2 levels of sub-agent nesting
- One refinement round maximum per finding
- Task timeout: 600 seconds (10 minutes)

## Logging Requirements

- Log all task dispatches with task_id and agent
- Log task completions with duration
- Log all contradictions and resolutions
- Log findings deduplication counts
