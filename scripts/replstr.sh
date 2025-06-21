#!/usr/bin/env bash
# replace_recursive.sh ─ Recursively replace one literal string with another
# (No .bak backup files are created)
# Usage: ./replace_recursive.sh "search" "replace" [start_dir]
set -euo pipefail

search=${1?  "Need search string"}
replace=${2? "Need replacement string"}
root=${3:-.}

echo "About to replace ALL occurrences of:
   '$search'
with
   '$replace'
in every regular file under:  $root"
read -rp "Continue? [y/N] " ans
[[ $ans = [yY] ]] || { echo "Aborted."; exit 1; }

find "$root" -type f -not -path '*/.git/*' -print0 |
  xargs -0 perl -0777 -i -pe '
     BEGIN { $s = shift; $r = shift }
     s/\Q$s\E/$r/g
  ' "$search" "$replace"

echo "Replacement complete."
