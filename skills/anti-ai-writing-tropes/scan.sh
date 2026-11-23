#!/usr/bin/env bash
# Usage: scan.sh [--summary] <file-or-dir>...
# Prints likely AI-writing tropes, one sentence per hit, labelled by the skill
# section they belong to. Every hit is a lead to read in context. --summary
# prints hit counts per file and per label instead.
set -u
summary=0
if [ "${1:-}" = --summary ]; then summary=1; shift; fi
targets=("${@:-.}")
status=0
for t in "${targets[@]}"; do
  [ -e "$t" ] || { echo "scan.sh: no such file or directory: $t" >&2; status=1; }
done
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

# Splits prose into sentences, dropping YAML frontmatter, fenced code, inline
# code and URLs.
# Writes "file<TAB>line" to $meta and the sentence to $text, one pair per line,
# and the paragraph-level coldstart and staccato hits to $hits.
prose='
function clean(s) {
  gsub(/\t/, " ", s)
  gsub(/`[^`]*`/, "`…`", s)
  gsub(/\]\([^)]*\)/, "]", s)
  gsub(/<https?:[^>]*>|https?:\/\/[^ )>\]]*/, "URL", s)
  gsub(/<\/?[a-zA-Z][^>]*>/, "", s)
  gsub(/^[ \t]+|[ \t]+$/, "", s)
  return s
}
function add(s) {
  if (s == "") return
  if (para == "") { nk = 0 } else para = para " "
  off[++nk] = length(para); lno[nk] = FNR
  para = para s
}
function lineof(o,  k) {
  for (k = nk; k > 1 && off[k] > o; k--) ;
  return lno[k]
}
function hit(label, ln, s) {
  if (length(s) > 300) s = substr(s, 1, 300) "…"
  print file "\t" ln "\t" label "\t" s >> hits
}
function flush(  start, pos, e, piece, ns, i, run, words, w) {
  if (para == "") return
  ns = 0; start = 1; pos = 1
  while (match(substr(para, pos), /[.!?]["\047)]*[ ]+[^ a-z]/)) {
    e = pos - 1 + RSTART + RLENGTH - 2
    piece = substr(para, start, e - start + 1)
    sub(/ +$/, "", piece)
    pos = e + 1
    if (piece ~ /(^|[ (])(e\.g|i\.e|vs|cf|approx|Fig|et al)\.$/) continue
    sent[++ns] = piece; sl[ns] = lineof(start - 1); start = pos
  }
  piece = substr(para, start); sub(/ +$/, "", piece)
  if (piece != "") { sent[++ns] = piece; sl[ns] = lineof(start - 1) }
  for (i = 1; i <= ns; i++) { print file "\t" sl[i] >> meta; print sent[i] >> text }
  if ((kind == "p" || kind == "q" || kind == "li") && sent[1] ~ /^(\\[a-z]+\{)?(It|This|That|These|Those|Such|The same|So|And|Hence|Both|Neither|Either|The (two|three|four)|All (three|four)|Each of the) /)
    hit("coldstart", sl[1], sent[1])
  if (kind == "h" && sent[1] ~ /(^|[^A-Za-z])([Tt]he (same|two|three|other|rest)|[Bb]oth|[Tt]his|[Tt]hese|[Tt]hose|[Ss]uch|[Ii]t|[Tt]hem|[Tt]hey)([^A-Za-z]|$)/)
    hit("label", sl[1], sent[1])
  if (kind == "h" && sent[1] ~ /^What /)
    hit("label", sl[1], sent[1])
  run = 0
  if (kind != "h" && kind != "t")
    for (i = 1; i <= ns; i++) {
      words = split(sent[i], w, " ")
      run = (words > 0 && words <= 6) ? run + 1 : 0
      if (run >= 3) { hit("staccato", sl[1], para); break }
    }
  if (run < 3 && (kind == "p" || kind == "q" || kind == "li") && ns >= 2)
    for (i = 1; i <= ns; i++)
      if (split(sent[i], w, " ") <= 7 && sent[i] ~ /^[A-Z][^`\[]*[.!]$/ && sent[i] !~ /^(See|For example|Returns|Run|Use) / && sent[i] !~ /\([0-9]{4}[a-z]?\)\.$/)
        hit("short", sl[i], sent[i])
  para = ""
}
FNR == 1 { flush(); file = FILENAME; fence = 0; comment = 0; front = 0; mdx = FILENAME ~ /\.mdx$/; esm = 0; jsx = 0 }
FNR == 1 && /^---[ \t]*$/ { front = 1; next }
front { if (/^---[ \t]*$/) front = 0; next }
/^[ \t]*(```|~~~)/ { flush(); fence = !fence; next }
fence { next }
comment { if (/-->/) comment = 0; next }
/^[ \t]*<!--/ { flush(); if (!/-->/) comment = 1; next }
mdx && esm { if (/^[}\])]|from ["\047]/) esm = 0; next }
mdx && /^(import|export) / { flush(); if (/[{(\[][ \t]*$/) esm = 1; next }
mdx && jsx { if (/>[ \t]*$/) jsx = 0; next }
mdx && /^[ \t]*<[A-Za-z]/ && !/>/ { flush(); jsx = 1; next }
mdx { gsub(/\{\047 \047\}/, " "); gsub(/\{[^{}]*\}/, "…") }
/^[ \t]*$/ { flush(); next }
/^[ \t]*#/ { flush(); kind = "h"; s = $0; sub(/^[ \t]*#+[ \t]*/, "", s); add(clean(s)); flush(); next }
/^[ \t]*\|/ {
  flush()
  if ($0 ~ /^[ \t|:-]+$/) next
  kind = "t"; add(clean($0)); flush(); next
}
/^[ \t]*>/ { s = $0; sub(/^[ \t]*>[ \t>]*/, "", s); if (s == "") { flush(); next } if (para == "") kind = "q"; add(clean(s)); next }
/^[ \t]*([-*+]|[0-9]+[.)])[ \t]/ { flush(); kind = "li"; s = $0; sub(/^[ \t]*([-*+]|[0-9]+[.)])[ \t]+/, "", s); add(clean(s)); next }
{ if (para == "") kind = "p"; add(clean($0)) }
END { flush() }
'

find "${targets[@]}" \( -path '*/.git' -o -path '*/node_modules' -o -path '*/.claude' \
  -o -path '*/dist' -o -path '*/esm' -o -path '*/esm_branch[12]' -o -path '*/build' \
  -o -path '*/target' -o -path '*/coverage' -o -path '*/vendor' -o -path '*/.venv' \) -prune -o \
  -type f \( -name '*.md' -o -name '*.mdx' -o -name '*.tex' -o -name '*.txt' -o -name '*.rst' \) -print0 2>/dev/null |
  xargs -0 -r awk -v meta="$tmp/meta" -v text="$tmp/text" -v hits="$tmp/hits" "$prose"
touch "$tmp/meta" "$tmp/text" "$tmp/hits"

scan() {
  local label=$1 flags=$2 pattern=$3 version=${4:-}
  grep -n"$flags" -E "$pattern" "$tmp/text" |
    if [ -n "$version" ]; then
      awk -v v="$version" -v p="$pattern" '{ s = $0; gsub(v, "", s); if (s ~ p) print }'
    else cat; fi |
    awk -v label="$label" 'NR == FNR { m[FNR] = $0; next }
      { i = index($0, ":"); print m[substr($0, 1, i - 1)] "\t" label "\t" substr($0, i + 1) }' "$tmp/meta" - >> "$tmp/hits"
}
scan contrast   ''  'is what |which is what|is where |rather than|, not |not just|instead of|isn.t (the|about)|not because|\b[a-z]+s only '
scan negative   ''  '\b(does not|doesn.t|do not|don.t|cannot|can.t|never) (record|store|hold|contain|carry|include|say|tell|track|keep)s?\b|\b(holds|carries|records|stores) no\b'
scan aphorism   ''  ', not (who|what|where|when|how|which|why)\b|, not .*( and not | instead of | rather than )'
scan shape      ''  '(^|\. )So that | — | -- |the (whole )?point|honest|payoff|worth (naming|noting|being)|key insight|the result\?'
scan agency     ''  '\b(cannot|doesn.t|does not) know|says |exists to|earns|buys |load-bearing|one-way door|footgun|moves the needle|surfaces |for free|costs? nothing|stands? between|\b(its|their) own\b|\bcarr(y|ies|ied|ying|iage|iers?)\b'
scan figure     ''  '\b(lands?|landed|landing) (in|inside|on|at)\b|\b(lives?|living) (in|on|under)\b|\bcollaps(e|es|ed|ing) (them |it |the [a-z]+ )?(in)?to\b|\b(rots?|rotting|goes stale|drifts?)\b|\b(dial|knob|lever)s?\b|\bthe shape of\b|\b(a|the) trap\b'
scan agency     'i' '\b(estimates?|numbers?|counts?|reads?|measures?|values?|scores?) (also |still |both )?(credit|credits|put|puts|mislead|misleads|disagree|disagrees|splice|splices|restore|restores)\b'
scan agency     'i' '\b(patch(es)?|logs?|files?|documents?|specs?|schemas?|headers?|changelogs?|manifests?) (already |also )?(records?|describes?|tells?|expresses?|encodes?|captures?)\b'
scan figure     'i' 'what [a-z ]{1,40} costs\b|\b(cheap|cheaper|cheaply|expensive|costly)\b|\bpays? for\b|\bthe price of\b'
scan gerund     ''  '^[A-Z][a-z]+ing\b[^,;:]* (collapses|makes|gives|lets|turns|serves|keeps|saves|buys|costs|means|avoids|stops|breaks|fixes|cuts|brings|forces|leaves|sends|takes|wins)\b'
scan colon      ''  '[a-z]: [a-z]'
scan apposition ''  ', (one|ones|a|an) (that|which|whose|where) |, (a|an) [a-z-]+ (that|which|whose) |, (its|their) [a-z-]+ (through|across|between|of) '
scan opening    ''  '^(Nothing|No one|None) |not (the|its|our) job|silently|quietly|invisibly|\bhere.s (the|where)|let.s (break|dive|unpack)|think of it as|in summary|as we.ve seen|for (two|three) reasons|(two|three) things'
scan passive    ''  '\b(is|are|was|were) ([a-z]+ed and [a-z]+ed|[a-z]+ed by|left unset)\b'
scan history    ''  'used to |previous version|found while|\b(ONLY|NOT|NEVER|ALWAYS|MUST|CANNOT|EVERY|SAME|BOTH|EACH|ALL|ANY|BEFORE|AFTER|FIRST|EXACTLY|WHOLE|MORE|LESS|AND|IS|ARE|WAS|DOES|DON.T|DOESN.T|ISN.T|CAN.T|WON.T)\b'
scan register   'i' 'serves as|stands as|delve|tapestry|testament|showcase|pivotal|vibrant|seamless|flagship|robust|groundbreaking|famously|a classic|well-known|leverage|utili[sz]e|streamline|empower|unlock|comprehensive|crucial|a (variety|range) of|^(additionally|furthermore|moreover|notably|importantly|ultimately|overall),|to (optimi[sz]e|improve|enhance|help with) '
scan pitch      'i' '(does|do|is|are|goes|go) (more than|beyond)|more than just|not limited to|state.of.the.art|cutting.edge|industry.leading|best.in.class|next.generation|the most [a-z]+ |the first (tool|browser|library|system|format|program|to )|an early (use|example)|(could|can) do (much )?more|the possibilities'
scan claim      ''  'in the same way|similar to|just like'
scan label      'i' '(^|\\item )(\*\*|\\textbf\{)[^*}]{0,80}\b(same|both|this|these|those|such|above|below|other|rest|former|latter|it|them|they)\b|\\(sub)*section\*?\{[^}]*\b(the (same|two|three|other|rest)|both|this|these|those|such|it|them|they)\b'
scan float      ''  'was (created|built|designed|made|written) for |, where that [a-z]+ is (largest|smallest|greatest|highest|lowest)'
scan number     ''  '(^|[^:0-9,./A-Za-z-])[0-9]{1,3}(,[0-9]{3})+\b'
scan number     ''  '(^|[^:0-9,./A-Za-z-])[0-9]+[.][0-9]{2,}([^0-9./]|$)' \
  '(^|[^A-Za-z])(Python|Node|Node[.]js|Java|Ruby|Perl|Go|R|GCC|version|release|v) [0-9]+[.][0-9]{2,}'
scan agency     'i' '\b(documents?|files?|configs?|sessions?|specs?|formats?|manifests?|schemas?|tables?|layers?|sources?) (only |also |already )?(leaves?|left) [^.]*\bto\b'

if [ "$summary" = 1 ]; then
  awk -F'\t' '{ n[$1]++; c[$1 "\t" $3]++; t[$3]++ }
    END {
      for (k in c) { split(k, p, "\t"); per[p[1]] = per[p[1]] " " p[2] ":" c[k] }
      for (f in n) printf "%6d  %s %s\n", n[f], f, per[f]
      for (l in t) printf "%6d  [%s]\n", t[l], l
    }' "$tmp/hits" | sort -rn
else
  sort -t "$(printf '\t')" -k1,1 -k2,2n -s "$tmp/hits" | awk -F'\t' '{ print "[" $3 "] " $1 ":" $2 ":" $4 }'
fi
exit "$status"
