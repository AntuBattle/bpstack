#!/usr/bin/env bash
set -euo pipefail

root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
tmp=$(mktemp -d)
trap 'rm -rf -- "$tmp"' EXIT
export HOME="$tmp/home"
dest="$HOME/.agents/skills"
mkdir -p -- "$dest/unrelated"
printf 'keep this\n' > "$dest/unrelated/local.txt"
installer="$root/scripts/install-skills.sh"
bash "$installer"
bash "$installer"
for source in "$root"/skills/*; do
  diff -qr -- "$source" "$dest/${source##*/}"
done
test "$(<"$dest/unrelated/local.txt")" = 'keep this'
test -f "$dest/poteto-mode/playbooks/review-and-verify.md"
cmp -- "$root/LICENSE" "$dest/LICENSE.bpstack"
cmp -- "$root/NOTICE.md" "$dest/NOTICE.bpstack.md"
test ! -e "$HOME/AGENTS.md"

conflict="$tmp/another project/.agents/skills"
mkdir -p -- "$conflict/poteto-mode"
printf 'local variant\n' > "$conflict/poteto-mode/SKILL.md"
if bash "$installer" "$conflict"; then
  printf 'Expected installed variation to block all copies\n' >&2
  exit 1
fi
test "$(<"$conflict/poteto-mode/SKILL.md")" = 'local variant'
test ! -e "$conflict/architect"

linkdest="$tmp/symlink destination"
mkdir -p -- "$linkdest"
ln -s "$root/skills/architect" "$linkdest/architect"
if bash "$installer" "$linkdest"; then
  printf 'Expected a symlink destination to be refused\n' >&2
  exit 1
fi
test -L "$linkdest/architect"
test ! -e "$linkdest/poteto-mode"

bundle="$tmp/source checkout"
mkdir -p -- "$bundle/scripts"
cp -R -- "$root/skills" "$root/skills.manifest" "$root/LICENSE" "$root/NOTICE.md" "$bundle/"
cp -- "$installer" "$bundle/scripts/"
mkdir -p -- "$bundle/skills/synced/third-party"
touch -- "$bundle/skills/synced/third-party/SKILL.md" "$bundle/skills/architect/local-note.md"
explicit="$tmp/explicit project/.agents/skills"
bash "$bundle/scripts/install-skills.sh" "$explicit"
test ! -e "$explicit/synced"
test ! -e "$explicit/architect/local-note.md"
diff -qr -x LICENSE.bpstack -x NOTICE.bpstack.md -- "$root/skills" "$explicit"
printf 'Install smoke test passed: copies, repeat run, conflicts, symlinks, explicit destination.\n'
