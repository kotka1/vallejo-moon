#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
export PATH="$ROOT/.tools/node/bin:$PATH"
export NO_UPDATE_NOTIFIER=1 VERCEL=1 VERCEL_TELEMETRY_DISABLED=1

unset HTTP_PROXY HTTPS_PROXY http_proxy https_proxy \
  ALL_PROXY all_proxy GIT_HTTP_PROXY GIT_HTTPS_PROXY \
  SOCKS_PROXY SOCKS5_PROXY socks_proxy socks5_proxy
export NO_PROXY='*'

if [[ -f "$ROOT/.env" ]]; then
  set -a
  # shellcheck disable=SC1091
  source "$ROOT/.env"
  set +a
fi

if [[ -z "${VERCEL_TOKEN:-}" ]]; then
  echo "VERCEL_TOKEN is not set. Add it to .env first."
  exit 1
fi

cd "$ROOT"
PROJECT="vallejo-moon"

echo "==> Production deploy"
vercel deploy --prod --yes --token "$VERCEL_TOKEN"

echo ""
echo "==> Attach vallejomoon.com to project"
vercel project domain add "$PROJECT" vallejomoon.com --token "$VERCEL_TOKEN" 2>/dev/null \
  || vercel domains add vallejomoon.com --token "$VERCEL_TOKEN" || true
vercel project domain add "$PROJECT" www.vallejomoon.com --token "$VERCEL_TOKEN" 2>/dev/null \
  || vercel domains add www.vallejomoon.com --token "$VERCEL_TOKEN" || true

echo ""
echo "==> Domain status"
vercel project domain ls "$PROJECT" --token "$VERCEL_TOKEN" 2>/dev/null \
  || vercel domains inspect vallejomoon.com --token "$VERCEL_TOKEN" 2>/dev/null \
  || echo "(Run 'vercel domains inspect vallejomoon.com' if inspect failed)"

echo ""
echo "==> DNS at your registrar (if not already set)"
echo "  Type    Name    Value"
echo "  A       @       76.76.21.21"
echo "  CNAME   www     cname.vercel-dns.com"
echo ""
echo "After DNS propagates, https://vallejomoon.com will serve this site."
echo "Dashboard: https://vercel.com/dwiggedy/vallejo-moon/settings/domains"
