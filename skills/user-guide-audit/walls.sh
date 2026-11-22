#!/usr/bin/env bash
# Usage: walls.sh <dir-or-file>...
# Maps a set of Markdown guide pages: words and figures per page, then the
# leads an audit reads in context.
#   [wall]    a paragraph or bullet over 4 lines, at 100 characters a line
#   [bare]    a section of 150+ words of prose with no figure
#   [alt]     an image with empty or missing alt text
#   [orphan]  a page no other page in the set links to
#   [overlap] a heading that appears on more than one page
set -u
targets=("${@:-.}")
status=0
for t in "${targets[@]}"; do
  [ -e "$t" ] || { echo "walls.sh: no such file or directory: $t" >&2; status=1; }
done
files=()
while IFS= read -r -d '' f; do files+=("$f"); done < <(
  find "${targets[@]}" -name '*.md' -not -path '*/node_modules/*' -not -path '*/.git/*' -print0 2>/dev/null | sort -z
)
[ ${#files[@]} -eq 0 ] && exit "$status"

# Shared by every pass: skips YAML frontmatter and fenced code (``` or ~~~,
# indented or not), and sets "skip" for the lines a pass should ignore.
markdown='
{ skip = 0; fenceline = 0 }
FNR == 1 { fence = 0; front = 0 }
FNR == 1 && /^---[ \t]*$/ { front = 1; skip = 1; next }
front { if (/^---[ \t]*$/) front = 0; skip = 1; next }
/^[ \t]*(```|~~~)/ { fence = !fence; skip = 1; fenceline = 1 }
!fenceline && fence { skip = 1 }
'

printf '%-48s %6s %4s\n' page words figs
awk '
  FNR == 1 { if (f) out(); f = FILENAME; words = 0; figs = 0 }
'"$markdown"'
  skip { next }
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
  FNR == 1 { if (NR > 1) { flush(); section() } pfile = FILENAME; sstart = 1; shead = "(top)" }
'"$markdown"'
  skip { flush(); next }
  /^#/ { flush(); section(); sstart = FNR; shead = $0; next }
  /!\[[ \t]*\]\(/ || (/<img/ && !/alt=["\047][^"\047]/) { print "[alt] " FILENAME ":" FNR ": " $0 }
  /!\[|<img|<video/ { sfigs++ }
  !/^[[:space:]]*\|/ { swords += NF }
  /^[[:space:]]*$/ { flush(); next }
  /^[[:space:]]*[>|<]/ { flush(); next }
  /^[[:space:]]*([-*+]|[0-9]+\.) / { flush() }
  { if (plines == 0) { pstart = FNR; pfirst = $0 } plines += length($0) > 100 ? int((length($0) + 99) / 100) : 1 }
  END { flush(); section() }
' "${files[@]}"

# A page is linked when another page has a Markdown or HTML link, inline or
# by reference, whose target resolves to it, relative to the linking page. A
# target without an extension also matches target.md, target/README.md and
# target/index.md, and a site-root target (/docs/x) matches a page whose path,
# less .md, shares its trailing path segments.
awk "$markdown"'
  function norm(p,  n, i, k, seg, out) {
    n = split(p, seg, "/"); k = 0
    for (i = 1; i <= n; i++) {
      if (seg[i] == "" || seg[i] == ".") continue
      if (seg[i] == ".." && k > 0 && stack[k] != "..") k--
      else stack[++k] = seg[i]
    }
    out = ""
    for (i = 1; i <= k; i++) out = out (i > 1 ? "/" : "") stack[i]
    return out
  }
  function endswith(a, b) { return a == b || substr(a, length(a) - length(b)) == "/" b }
  function dir(p) { return p ~ /\// ? substr(p, 1, match(p, /\/[^\/]*$/) - 1) : "." }
  function link(from, t,  base, cands, c, n, i, p) {
    sub(/[#?].*/, "", t)
    if (t == "" || t ~ /^[a-z]+:/) return
    if (t ~ /^\//) { rooted[norm(t)] = 1; return }
    base = norm(dir(from) "/" t)
    n = split(base "|" base ".md|" base "/README.md|" base "/index.md", cands, "|")
    for (i = 1; i <= n; i++) if (cands[i] != norm(from)) linked[cands[i]] = 1
  }
  FNR == 1 { pages[norm(FILENAME)] = FILENAME }
  skip { next }
  {
    s = $0
    gsub(/`[^`]*`/, "", s)
    while (match(s, /\]\([^) ]+/)) { link(FILENAME, substr(s, RSTART + 2, RLENGTH - 2)); s = substr(s, RSTART + RLENGTH) }
    if (match(s, /^[ \t]*\[[^]]+\]:[ \t]*<?[^ \t>]+/)) { t = substr(s, RSTART, RLENGTH); sub(/^[^]]*\]:[ \t]*<?/, "", t); link(FILENAME, t) }
    while (match(s, /href="[^"]+"/)) { link(FILENAME, substr(s, RSTART + 6, RLENGTH - 7)); s = substr(s, RSTART + RLENGTH) }
  }
  END {
    for (p in pages) {
      ok = (p in linked)
      for (r in rooted) {
        if (ok) break
        stem = p; sub(/(\/(README|index))?\.md$/, "", stem)
        if (endswith(r, stem) || endswith(stem, r)) ok = 1
      }
      if (!ok && p !~ /(^|\/)README\.md$/) print "[orphan] " pages[p]
    }
  }
' "${files[@]}" | sort

awk "$markdown"'
  skip { next }
  /^##+ / { h = tolower($0); sub(/^#+ +/, "", h); if (!((h, FILENAME) in on)) { on[h, FILENAME] = 1; seen[h] = seen[h] (seen[h] ? ", " : "") FILENAME } }
  END { for (h in seen) if (index(seen[h], ", ")) print "[overlap] \"" h "\": " seen[h] }
' "${files[@]}" | sort
exit "$status"
