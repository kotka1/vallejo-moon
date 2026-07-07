#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"

# Cursor injects a localhost HTTP/SOCKS proxy that blocks api.vercel.com (CONNECT 403).
# Clear it before any network calls so deploy works from the IDE terminal too.
unset HTTP_PROXY HTTPS_PROXY http_proxy https_proxy \
      ALL_PROXY all_proxy \
      GIT_HTTP_PROXY GIT_HTTPS_PROXY \
      SOCKS_PROXY SOCKS5_PROXY socks_proxy socks5_proxy
export NO_PROXY='*'
export no_proxy='*'

export PATH="$ROOT/.tools/node/bin:$PATH"
export NO_UPDATE_NOTIFIER=1 VERCEL=1 VERCEL_TELEMETRY_DISABLED=1

if [[ -f "$ROOT/.env" ]]; then
  set -a
  # shellcheck disable=SC1091
  source "$ROOT/.env"
  set +a
fi

if [[ -z "${VERCEL_TOKEN:-}" ]]; then
  echo "VERCEL_TOKEN is not set. Add it to .env or export it in your shell."
  exit 1
fi

check_vercel_api() {
  local code
  code="$(curl -sS -o /dev/null -w '%{http_code}' --max-time 15 \
    -H "Authorization: Bearer $VERCEL_TOKEN" \
    https://api.vercel.com/v2/user || true)"
  case "$code" in
    200) return 0 ;;
    401|403) echo "Vercel API reachable but VERCEL_TOKEN was rejected ($code). Regenerate at https://vercel.com/account/tokens"; return 1 ;;
    000|"") echo "Cannot reach api.vercel.com (network/DNS). Run this script in macOS Terminal, not the Cursor agent sandbox."; return 1 ;;
    *) echo "Unexpected Vercel API response: HTTP $code"; return 1 ;;
  esac
}

echo "Checking Vercel API connection..."
check_vercel_api

cd "$ROOT"
echo "Deploying to production..."
vercel deploy --prod --yes --token "$VERCEL_TOKEN"

echo ""
echo "Adding custom domains (if not already linked)..."
vercel domains add vallejomoon.com --token "$VERCEL_TOKEN" 2>/dev/null || true
vercel domains add www.vallejomoon.com --token "$VERCEL_TOKEN" 2>/dev/null || true

echo ""
echo "Done. Configure DNS:"
echo "  vallejomoon.com  A      76.76.21.21"
echo "  www              CNAME  cname.vercel-dns.com"
