#!/usr/bin/env bash
set -euo pipefail

if (( $# > 1 )); then
  printf 'Usage: %s [skill-destination]\n' "$0" >&2
  exit 2
fi

root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
dest=${1:-"$HOME/.agents/skills"}
stage=$(mktemp -d)
trap 'rm -rf -- "$stage"' EXIT
while IFS= read -r file; do
  if [[ $file != skills/*/* || $file == *'/../'* || $file == skills/synced/* || ! -f $root/$file || -L $root/$file ]]; then
    printf 'Invalid skill manifest entry: %s\n' "$file" >&2
    exit 1
  fi
  target=$stage/${file#skills/}
  mkdir -p -- "${target%/*}"
  cp -- "$root/$file" "$target"
done < "$root/skills.manifest"
cp -- "$root/LICENSE" "$stage/LICENSE.bpstack"
cp -- "$root/NOTICE.md" "$stage/NOTICE.bpstack.md"
mkdir -p -- "$dest"

for source in "$stage"/*; do
  target=$dest/${source##*/}
  if [[ -L $target ]] || { [[ -e $target ]] && ! diff -qr -- "$source" "$target" >/dev/null; }; then
    printf 'Refusing to overwrite: %s\n' "$target" >&2
    exit 1
  fi
done

for source in "$stage"/*; do
  target=$dest/${source##*/}
  if [[ ! -e $target ]]; then
    cp -R -- "$source" "$target"
  fi
done
printf 'Skills installed or already up to date in %s\n' "$dest"
