#!/usr/bin/env bash
# Usage: walls.sh <dir-or-file>...
# Maps a set of Markdown guide pages: words and figures per page, then the
# leads an audit reads in context.
#   [wall]    a paragraph or bullet over 4 lines
#   [bare]    a section of 150+ words of prose with no figure
#   [alt]     an image with empty alt text
#   [orphan]  a page no other page in the set links to
#   [overlap] a heading that appears on more than one page
set -u
targets=("${@:-.}")
mapfile -t files < <(find "${targets[@]}" -name '*.md' -not -path '*/node_modules/*' -not -path '*/.git/*' | sort)
[ ${#files[@]} -eq 0 ] && exit 0

printf '%-48s %6s %4s\n' page words figs
awk '
  FNR == 1 { if (f) out(); f = FILENAME; words = 0; figs = 0; fence = 0 }
  /^```/ { fence = !fence; next }
  fence { next }
  /!\[|<img|<video/ { figs++ }
  { words += NF }
  function out() { printf "%-48s %6d %4d\n", f, words, figs }
  END { out() }
' "${files[@]}"
echo

awk '
  function flush() {
    if (plines > 4) print "[wall] " pfile ":" pstart ": " plines " lines: " substr(pfirst, 1, 60)
    plines = 0
  }
  function section() {
    if (swords >= 150 && sfigs == 0) print "[bare] " pfile ":" sstart ": " swords " words, no figure: " shead
    swords = 0; sfigs = 0
  }
  FNR == 1 { if (NR > 1) { flush(); section() } pfile = FILENAME; fence = 0; sstart = 1; shead = "(top)" }
  /^```/ { fence = !fence; flush(); next }
  fence { next }
  /^#/ { flush(); section(); sstart = FNR; shead = $0; next }
  /!\[\]\(/ { print "[alt] " FILENAME ":" FNR ": " $0 }
  /!\[|<img|<video/ { sfigs++ }
  !/^[[:space:]]*\|/ { swords += NF }
  /^[[:space:]]*$/ { flush(); next }
  /^[[:space:]]*[>|<]/ { flush(); next }
  /^[[:space:]]*([-*+]|[0-9]+\.) / { flush() }
  { if (plines == 0) { pstart = FNR; pfirst = $0 } plines++ }
  END { flush(); section() }
' "${files[@]}"

for f in "${files[@]}"; do
  base=$(basename "$f")
  [ "$base" = README.md ] && continue
  grep -lF "$base" "${files[@]}" 2>/dev/null | grep -vxF "$f" -q || echo "[orphan] $f"
done

awk '
  FNR == 1 { fence = 0 }
  /^```/ { fence = !fence; next }
  !fence && /^##+ / { h = tolower($0); sub(/^#+ +/, "", h); if (!index(seen[h], FILENAME)) seen[h] = seen[h] (seen[h] ? ", " : "") FILENAME }
  END { for (h in seen) if (index(seen[h], ", ")) print "[overlap] \"" h "\": " seen[h] }
' "${files[@]}" | sort
