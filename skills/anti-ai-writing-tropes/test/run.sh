#!/usr/bin/env bash
# Runs scan.sh on fixture.md and diffs the output against expected.txt.
cd "$(dirname "$0")" || exit 1
diff <(bash ../scan.sh fixture.md | sed 's|fixture.md:||' | sort) <(sort expected.txt) && echo ok
