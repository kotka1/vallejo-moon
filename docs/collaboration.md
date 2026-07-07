# Collaboration guide — Mikael & Dwayne

How to share this project so you both work from the same source of truth.

## Recommended: GitHub (private repo)

Cursor does **not** have a single “shared cloud workspace” for two people editing the same files live. The standard pattern is:

**One Git repo → two local copies → push and pull changes.**

### Setup (once)

1. Create a **private** repository on GitHub: `vallejo-moon`
2. From this folder on Mikael’s machine:

```bash
cd vallejo-moon
git init
git add .
git commit -m "Initial Vallejo Moon workspace"
git branch -M main
git remote add origin git@github.com:YOUR_USERNAME/vallejo-moon.git
git push -u origin main
```

3. On GitHub: **Settings → Collaborators → Add people** → invite Dwayne’s GitHub account

4. Dwayne clones and opens in Cursor:

```bash
git clone git@github.com:YOUR_USERNAME/vallejo-moon.git
cd vallejo-moon
# Open Vallejo-Moon.code-workspace in Cursor
```

### Daily workflow

```bash
git pull                    # get Dwayne’s latest changes
# … edit files in Cursor …
git status
git add content/articles/my-story.md
git commit -m "Add draft: downtown housing story"
git push
```

**Rule of thumb:** Pull before you start working. Push when you finish a logical chunk.

### Avoid stepping on each other

- Split by **section** (Mikael: site/design · Dwayne: reporting) or by **article file**
- One person per article file in `content/articles/`
- Use `content/drafts/` for early ideas; move to `articles/` when ready for review
- Optional: short **branch** per story (`git checkout -b story/707-punk-show`), merge via GitHub PR

---

## Alternative: shared Google Drive folder

You already use Google Drive. You *can* put `vallejo-moon/` in a shared folder — but:

| Pros | Cons |
|------|------|
| Easy for non-code files (photos, PDFs) | Git conflicts are painful if both use Drive sync |
| Familiar | Cursor + Drive sync sometimes creates duplicate/conflict files |

**If you use Drive:** only one person edits code at a time, or use Git *inside* the shared folder (still prefer GitHub as remote).

---

## Cursor-specific tips

- Both open **`Vallejo-Moon.code-workspace`** — same folders, same AI rules in `.cursor/rules/`
- Rules travel with the repo — no extra setup for Dwayne
- Use **Cursor chat** with article drafts open; rules keep tone and structure consistent
- **Do not** commit secrets (`.env`, API keys, subscriber lists)

---

## Roles (suggested — edit together)

| Area | Owner | Folder |
|------|-------|--------|
| Editorial / reporting | Dwayne | `content/`, `editorial/` |
| Design / site / brand | Mikael | `site/`, `brand/` |
| Launch & ops | Both | `docs/` |

Adjust in `editorial/team.md` when you decide formally.

---

## Next steps toward launch

- [ ] Pick domain (`vallejomoon.com` or similar — check availability)
- [ ] Finalize name & mission (`editorial/mission.md`)
- [ ] First 3 article drafts
- [ ] MVP homepage in `site/`
- [ ] Newsletter provider (Buttondown, Ghost, Beehiiv, etc.)
- [ ] Legal: LLC or nonprofit? media liability insurance? (consult locally)
