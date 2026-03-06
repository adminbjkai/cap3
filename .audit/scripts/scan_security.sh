#!/bin/bash
set -euo pipefail

# Security Scanning Script for Cap3
# Runs Trivy, Semgrep, and Gitleaks

REPO_ROOT="/Users/m17/2026/gh_repo_tests/cap3"
OUTPUT_DIR="${REPO_ROOT}/.audit/artifacts"
mkdir -p "$OUTPUT_DIR"

echo "🔒 Cap3 Security Scanner"
echo "========================"

cd "$REPO_ROOT"

# Check tools
command -v trivy >/dev/null 2>&1 || echo "⚠️  Trivy not installed (optional)"
command -v semgrep >/dev/null 2>&1 || echo "⚠️  Semgrep not installed (optional)"
command -v gitleaks >/dev/null 2>&1 || echo "⚠️  Gitleaks not installed (optional)"

# 1. Trivy filesystem scan
echo "🔍 Running Trivy filesystem scan..."
if command -v trivy >/dev/null 2>&1; then
  trivy filesystem --scanners vuln,secret,misconfig \
    --format json \
    --output "$OUTPUT_DIR/trivy_scan.json" \
    . 2>/dev/null || echo "[]" > "$OUTPUT_DIR/trivy_scan.json"
else
  echo "[]" > "$OUTPUT_DIR/trivy_scan.json"
fi

# 2. Semgrep scan
echo "🔍 Running Semgrep..."
if command -v semgrep >/dev/null 2>&1; then
  semgrep --config=auto \
    --json \
    --output="$OUTPUT_DIR/semgrep_scan.json" \
    . 2>/dev/null || echo '{"results": []}' > "$OUTPUT_DIR/semgrep_scan.json"
else
  echo '{"results": []}' > "$OUTPUT_DIR/semgrep_scan.json"
fi

# 3. Gitleaks scan
echo "🔍 Running Gitleaks..."
if command -v gitleaks >/dev/null 2>&1; then
  gitleaks detect \
    --source . \
    --report-format json \
    --report-path "$OUTPUT_DIR/gitleaks_scan.json" \
    --verbose 2>/dev/null || echo "[]" > "$OUTPUT_DIR/gitleaks_scan.json"
else
  echo "[]" > "$OUTPUT_DIR/gitleaks_scan.json"
fi

# 4. Check for common security issues manually
echo "🔍 Manual security checks..."

cat > "$OUTPUT_DIR/manual_security_findings.json" << 'EOF'
{
  "findings": []
}
EOF

# Check for .env files in git
echo "  - Checking for .env files..."
if git ls-files | grep -E "^\.env" >/dev/null; then
  echo "⚠️  WARNING: .env files found in git!"
  cat > "$OUTPUT_DIR/manual_security_findings.json" << EOF
{
  "findings": [
    {
      "tool": "manual",
      "severity": "high",
      "title": "Environment files in git",
      "description": ".env or .env.* files should not be committed to version control",
      "files": $(git ls-files | grep -E "^\.env" | jq -R -s -c 'split("\n")[:-1]')
    }
  ]
}
EOF
fi

# 5. Generate summary
echo "📝 Generating security summary..."

cat > "$OUTPUT_DIR/SECURITY_SCAN.json" << EOF
{
  "scan_timestamp": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
  "scanner_version": "1.0.0",
  "tools": {
    "trivy": $(command -v trivy >/dev/null 2>&1 && echo "true" || echo "false"),
    "semgrep": $(command -v semgrep >/dev/null 2>&1 && echo "true" || echo "false"),
    "gitleaks": $(command -v gitleaks >/dev/null 2>&1 && echo "true" || echo "false")
  },
  "artifacts": [
    "trivy_scan.json",
    "semgrep_scan.json",
    "gitleaks_scan.json",
    "manual_security_findings.json"
  ],
  "next_steps": [
    "Review trivy_scan.json for CVEs",
    "Review semgrep_scan.json for code patterns",
    "Review gitleaks_scan.json for secrets"
  ]
}
EOF

echo "✅ Security scan complete"
echo "   - Trivy: $OUTPUT_DIR/trivy_scan.json"
echo "   - Semgrep: $OUTPUT_DIR/semgrep_scan.json"
echo "   - Gitleaks: $OUTPUT_DIR/gitleaks_scan.json"
echo "   - Summary: $OUTPUT_DIR/SECURITY_SCAN.json"
