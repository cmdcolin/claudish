#!/usr/bin/env bash
# Runs scan.sh on the fixtures and diffs the output against expected.txt.
# front.md has hits only in its frontmatter, so it adds no lines. post.mdx
# checks that MDX imports, exports and JSX attributes are skipped.
cd "$(dirname "$0")" || exit 1
diff <(bash ../scan.sh fixture.md front.md agency.md post.mdx | sed 's|fixture.md:||' | sort) <(sort expected.txt) && echo ok
