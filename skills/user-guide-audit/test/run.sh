#!/usr/bin/env bash
# Runs walls.sh on the fixture pages and diffs the output against expected.txt.
cd "$(dirname "$0")" || exit 1
diff <(bash ../walls.sh fixture.md other.md) expected.txt && echo ok
