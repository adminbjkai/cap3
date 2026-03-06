# Repository Map Skill

## Purpose
Canonical procedure for building a repository map from manifests, entry points, and service boundaries.

## Procedure

1. **Detect Languages**
   ```bash
   scc --format json . > repo_stats.json
   ```

2. **Build Symbol Index**
   ```bash
   ctags -R --languages=TypeScript,JavaScript --output-format=json -o symbols.json
   ```

3. **Find Entry Points**
   ```bash
   rg "^import|^require" --type ts --type tsx -l | head -20
   ```

4. **Parse Package.json Files**
   - Extract dependencies
   - Identify scripts
   - Map workspaces

5. **Generate INDEX.md**

## Output Format

```markdown
# Repository Index

## Overview
- Languages: TypeScript (85%), Docker (10%), Shell (5%)
- Total LOC: 15,000
- Services: 4 (web-api, web, worker, media-server)

## Services

### web-api (port 3000)
- Entry: apps/web-api/src/index.ts
- Framework: Fastify
- Dependencies: @cap/db, @cap/config

### web (port 8022)
- Entry: apps/web/src/main.tsx
- Framework: React + Vite

## Key Files
- docker-compose.yml
- package.json
- Makefile

## Dependencies
- Production: 45
- Development: 120
```
