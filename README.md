# claudish

Skills for Claude Code.

| Skill | Use it for |
|---|---|
| [anti-ai-writing-tropes](skills/anti-ai-writing-tropes/SKILL.md) | Writing and reviewing docs, comments, captions and CLAUDE.md files. A checklist of the habits that make prose read as generated, each with a rewrite. |

## anti-ai-writing-tropes

A checklist for technical writing: docs, READMEs, tutorials, code comments,
figure captions, commit messages and agent instruction files.

### What it offers over other trope lists

The [tropes.fyi directory](https://tropes.fyi/directory) (49 tropes, each with
one example and a trend label), [The Writing Whip](https://tropes.fyi/whip) (the
directory restated as instructions) and
[Wikipedia's Signs of AI writing](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing)
catalog the tells of essays, blog posts, slides and encyclopedia articles. The
skill folds in the ones that also appear in technical prose, credited under
[References](#references), and adds:

- Contrastive framing is banned by default. "X, not Y", "rather than",
  "instead of", "not just X but Y" and "It's not X. It's Y." all get the same
  fix: delete the negative half. The skill allows a contrast in three narrow
  cases, each defined by a test. The directory objects to negative parallelism
  only when it is overused.
- Every pattern comes with a rewrite that keeps the same facts, e.g. "the height
  its frequency earns" → "a height proportional to its frequency". The
  directory and the whip show one example to avoid per trope, with no rewrite.
- The skill lists tropes specific to technical prose. As of September 2026, none
  of these appears in the directory:
  - data, files and figures given knowledge or a stance ("a layer the alignment
    cannot know", "the boxes say")
  - cleft sentences ("column-locking is what stacks them")
  - a conclusion in place of the mechanism ("a bad marker stops the build")
  - a project policy restated as the closer of every caption ("the viewer
    computes none of it")
  - which-ladders ("a new alignment, which is a new model, which React spells
    `key`")
  - teaser headings, negative headings and jokes in reference tables
  - a paragraph that opens on "It" or "This", which a reader arriving by deep
    link cannot resolve
- It covers code comments: bug history ("used to", "the previous version")
  that belongs in the commit, rationale essays that fit in a clause, and
  ALL-CAPS emphasis.
- It gives tests a writer can apply mechanically:
  - "Could the subject perform the verb if you ran the program?" A parser can
    reject; a column cannot know.
  - "What literal word does this figure stand for?" A table maps common figures
    to their literal replacements ("load-bearing" → "required", "a one-way
    door" → "irreversible").
  - "Would a reader who never saw the negative half choose wrong?" If not, the
    contrast goes.
- It lists what a fix must preserve: the claim, every number and identifier,
  the terms the tools use, an author's deliberate idiom, the declined option in
  a design record, and generated text, whose fix goes in the generator.
- It warns about overcorrecting. Removing tropes tends to lengthen sentences,
  so the skill covers density, and it says when a list or table is the right
  format.
- It treats instruction files as the source of the problem. Agents copy the
  prose of `CLAUDE.md` and `AGENTS.md` into everything they write, so the skill
  says to fix those files first and to write every style rule in the style it
  asks for.
- It includes a review workflow: grep commands for finding hotspots, each hit
  read in context, and every instance reported before deciding which to fix.
- Most patterns and examples came from rewriting the docs and comments of two
  real codebases, videoskillet and react-msaview.

The directory tracks which tropes are rising or fading across model releases.
The skill does not, so check the directory for that.

## Install

As a plugin:

```
/plugin marketplace add cmdcolin/claudish
/plugin install claudish@claudish
```

Or copy a skill into your personal skills directory:

```sh
git clone https://github.com/cmdcolin/claudish
cp -r claudish/skills/anti-ai-writing-tropes ~/.claude/skills/
```

Claude loads a skill when its description matches the task, or when you ask for
it by name, e.g. "review README.md with the anti-ai-writing-tropes skill".

## References

The anti-ai-writing-tropes skill borrows ideas from these sources:

- [tropes.fyi](https://tropes.fyi) by [Ossama Chaib](https://ossama.is), a
  directory of AI writing tropes. The self-answered question, "serves as",
  suspense transitions, false ranges, invented concept labels, signposted
  summaries, bold-first bullets and dead metaphors come from its list.
- The [tropes.fyi directory](https://tropes.fyi/directory), for reasoning leaks,
  belaboring the unnecessary, never-ending conclusions, self-echo, grandiose
  stakes and title case headings.
- [The Writing Whip](https://tropes.fyi/whip), also by Ossama Chaib. Synonym
  cycling, announcers and counts, premise stacking, the tie-back, documentation
  as a changelog, appended corrections, appeals to familiarity and comma-clipped
  tails come from it.
- [Prompting Claude Fable 5.1](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/prompting-claude-fable-5-1)
  (Anthropic), whose "mannered prose" section led to the figure-of-speech test,
  and whose notes on writing density and formatting led to the density entry and
  the warning against dropping all formatting.
- [Prompting Claude Opus 5](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/prompting-claude-opus-5)
  (Anthropic), for padding in written documents, outcome-first reports,
  reporting every finding before triage, and positive examples over
  prohibitions.
- [Wikipedia: Signs of AI writing](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing),
  for promotional vocabulary, vague attribution and present-participle
  synthesis.
- The writing guides in [videoskillet](https://github.com/cmdcolin/videoskillet/blob/main/docs/WRITING.md)
  and [react-msaview](https://github.com/GMOD/JBrowseMSA/blob/main/docs/WRITING.md),
  where most of the technical-prose patterns and their examples were first
  written down.
