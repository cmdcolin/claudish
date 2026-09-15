#!/usr/bin/env bash
# Usage: scan.sh <file-or-dir>...
# Prints likely AI-writing tropes, labelled by the skill section they belong
# to. Every hit is a lead to read in context.
set -u
targets=("${@:-.}")
includes=(--include='*.md' --include='*.tex' --include='*.txt' --include='*.rst')
scan() {
  local label=$1 flags=$2 pattern=$3
  grep -rn"$flags" --color=never --exclude-dir=.git --binary-files=without-match \
    "${includes[@]}" -E "$pattern" "${targets[@]}" 2>/dev/null |
    sed "s/^/[$label] /"
}
coldstart() {
  awk -v f="$1" 'prev=="" && /^(\\[a-z]+\{)?(It|This|That|These|Those|Such|The same|So|And|Hence) / {print "[coldstart] " f ":" NR ":" $0} {prev=$0}' "$1"
}
staccato() {
  awk -v f="$1" '
    function check(  n, s, i, words, run) {
      if (para == "") return
      n = split(para, s, /[.!?]["\047)]? +/)
      run = 0
      for (i = 1; i <= n; i++) {
        words = split(s[i], _, " ")
        run = (words > 0 && words <= 6) ? run + 1 : 0
        if (run >= 3) { print "[staccato] " f ":" start ":" first; break }
      }
      para = ""
    }
    /^```/ { check(); fence = !fence; next }
    fence { next }
    /^[ \t]*($|[|#>])/ { check(); next }
    /^[ \t]*([-*]|[0-9]+\.) / { check() }
    para == "" { start = NR; first = $0 }
    { para = para " " $0 }
    END { check() }
  ' "$1"
}
find "${targets[@]}" -name .git -prune -o -type f \( -name '*.md' -o -name '*.tex' -o -name '*.txt' -o -name '*.rst' \) -print 2>/dev/null |
  while read -r f; do coldstart "$f"; staccato "$f"; done
scan contrast   ''  'is what |which is what|rather than|, not |not just|instead of|isn.t (the|about)|not because'
scan shape      ''  ' — | -- |the (whole )?point|honest|payoff|worth (naming|noting|being)|key insight|the result\?'
scan agency     ''  '\b(cannot|doesn.t|does not) know|says |exists to|earns|buys |load-bearing|one-way door|footgun|moves the needle|surfaces |\b(its|their) own\b'
scan colon      ''  '[a-z]: [a-z]'
scan apposition ''  ', (one|ones|a|an) (that|which|whose|where) |, (a|an) [a-z-]+ (that|which|whose) '
scan opening    ''  '^(Nothing|No one|None) |not (the|its|our) job|silently|quietly|invisibly|\bhere.s (the|where)|let.s (break|dive|unpack)|think of it as|in summary|as we.ve seen|for (two|three) reasons|(two|three) things'
scan passive    ''  '\b(is|are|was|were) ([a-z]+ed and [a-z]+ed|[a-z]+ed by|left unset)\b'
scan history    ''  'used to |previous version|found while|\b[A-Z]{4,}\b'
scan register   'i' 'serves as|stands as|delve|tapestry|testament|showcase|pivotal|vibrant|seamless|flagship|robust|groundbreaking|famously|a classic|well-known|leverage|utili[sz]e|streamline|empower|unlock|comprehensive|crucial|a (variety|range) of|^(additionally|furthermore|moreover|notably|importantly|ultimately|overall),'
