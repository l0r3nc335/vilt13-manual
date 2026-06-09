#!/bin/bash
set -e
cd /home/enzo/vilt13-manual
REPORT=/mnt/c/Users/loren/.cursor/projects/wsl-localhost-Ubuntu-26-04-home-enzo-vilt13-manual/git-commit-out.txt
{
  echo "=== GIT STATUS BEFORE ==="
  git status
  echo
  echo "=== GIT DIFF ==="
  git diff
  echo
  echo "=== GIT DIFF STAGED ==="
  git diff --staged
  echo
  echo "=== GIT LOG -5 ==="
  git log -5 --oneline
} > "$REPORT"

git add README-NOTES.md bootstrap/app.php package-lock.json package.json resources/js/app.js resources/views/app.blade.php routes/web.php app/Http/Middleware/ resources/js/pages/

git commit -m "$(cat <<'EOF'
Add Inertia.js and Vue front-end for VILT course.

Wire Laravel middleware, root Blade view, Vite entry, and sample Index page; document setup in README-NOTES.
EOF
)"

{
  echo
  echo "=== COMMIT HASH ==="
  git rev-parse HEAD
  echo
  echo "=== COMMIT MESSAGE ==="
  git log -1 --format=%B
  echo "=== GIT STATUS AFTER ==="
  git status
} >> "$REPORT"
