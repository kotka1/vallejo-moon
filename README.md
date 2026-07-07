# The Vallejo Moon

Vallejo's premier satirical newspaper — *illuminating nothing since last Tuesday.*

Static, self-contained `index.html`. No build step. Parody/satire; all persons fictional.

**Live:** https://vallejomoon.com

## Preview locally

```bash
python3 -m http.server 5180
```

Open http://localhost:5180

## Project layout

| Path | Purpose |
|------|---------|
| `index.html`, `css/` | Live site source |
| `content/` | Article drafts |
| `editorial/` | Mission, style, team |
| `brand/` | Visual assets |
| `docs/` | Collaboration guide |
| `deploy.sh` | Manual Vercel deploy |
| `.github/workflows/` | Auto-deploy on push to `main` |

Open **`Vallejo-Moon.code-workspace`** in Cursor for the full sidebar.

## Deploy from Cursor

The AI agent sandbox blocks Vercel's API. Use Cursor's **integrated terminal** instead:

| Action | Shortcut |
|--------|----------|
| **Deploy to Vercel** | `Cmd+Shift+B` |
| Pick a deploy task | `Cmd+Shift+P` → **Tasks: Run Task** |

Requires `VERCEL_TOKEN` in `.env` (see [vercel.com/account/tokens](https://vercel.com/account/tokens)).

### Git push → GitHub Actions

Push to `main` with `VERCEL_TOKEN` set as a GitHub repo secret.

## Collaborators

Mikael Hill & Dwayne — see `docs/collaboration.md`.
