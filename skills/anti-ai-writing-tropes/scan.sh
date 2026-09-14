#!/usr/bin/env bash
# Usage: scan.sh <file-or-dir>...
# Prints likely AI-writing tropes, labelled by group. Every hit is a lead to
# read in context.
set -u
targets=("${@:-.}")
scan() {
  local label=$1 flags=$2 pattern=$3
  grep -rn$flags --color=never -E "$pattern" "${targets[@]}" 2>/dev/null |
    sed "s/^/[$label] /"
}
coldstart() {
  awk -v f="$1" 'prev=="" && /^(\\[a-z]+\{)?(It|This|That|These|Those|Such|The same|So|And|Hence) / {print "[coldstart] " f ":" NR ":" $0} {prev=$0}' "$1"
}
find "${targets[@]}" -type f \( -name '*.md' -o -name '*.tex' -o -name '*.txt' \) 2>/dev/null |
  while read -r f; do coldstart "$f"; done
scan contrast   ''  ' — | -- |is what |which is what|rather than|, not |not just|instead of|isn.t (the|about)|not because'
scan announce   ''  'the (whole )?point|honest|payoff|worth (naming|noting|being)|exists to|key insight'
scan agency     ''  '\b(cannot|doesn.t|does not) know|says |silently|quietly|invisibly|earns|buys |load-bearing|one-way door|footgun|moves the needle|surfaces |\b(its|their) own\b'
scan colon      ''  '[a-z]: [a-z]'
scan apposition ''  ', (one|ones|a|an) (that|which|whose|where) |, (a|an) [a-z-]+ (that|which|whose) '
scan negation   ''  '^(Nothing|No one|None) |not (the|its|our) job|^(So|And|Hence) |used to '
scan promo      'i' 'delve|tapestry|testament|showcase|pivotal|vibrant|seamless|flagship|robust|groundbreaking|dramatically|greatly|famously|a classic|well-known'
scan transition 'i' 'serves as|stands as|here.s (the|where)|let.s (break|dive|unpack)|think of it as|in summary|as we.ve seen|the result\?|for (two|three) reasons|(two|three) things'
