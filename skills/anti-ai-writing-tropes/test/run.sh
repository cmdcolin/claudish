#!/usr/bin/env bash
# Runs scan.sh on the fixtures and diffs the output against expected.txt.
# front.md has hits only in its frontmatter, so it adds no lines.
cd "$(dirname "$0")" || exit 1
diff <(bash ../scan.sh fixture.md front.md agency.md | sed 's|fixture.md:||' | sort) <(sort expected.txt) && echo ok
