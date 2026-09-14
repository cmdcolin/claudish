# claudish

Skills for Claude Code.

| Skill | Use it for |
|---|---|
| [anti-ai-writing-tropes](skills/anti-ai-writing-tropes/SKILL.md) | Writing and reviewing docs, comments, captions and CLAUDE.md files. A checklist of the habits that make prose read as generated, each with a rewrite. |

## anti-ai-writing-tropes

A checklist for technical writing: docs, READMEs, tutorials, code comments,
figure captions, commit messages and agent instruction files. Each entry pairs
a habit with a rewrite that keeps the same facts.

| Section | Catches |
|---|---|
| Contrastive framing | "X, not Y", "rather than", "not just X but Y", "It's not X. It's Y." Banned by default; three narrow exceptions, each with a test. |
| Stance and agency | Values, files and figures that know, say or earn things; figures of speech where a literal word exists, with a lookup table. |
| Sentence shapes | Clefts, significance announcements, dramatic negation, which-ladders, fragments, rule-of-three lists, em-dash asides, density. |
| Openings and closings | Aphorisms, a conclusion in place of the mechanism, "silently", refrains, announcers, restating closers, padding, paragraphs opening on "It". |
| Paragraph transitions | The problem-then-response turn: a description where a limitation belongs, a narrative bridge with no evidence, a problem sized to the solution, a colon or comma doing the turn. |
| Headings and labels | Teaser, phrase and negative headings, Title Case, jokes in reference tables, bold-first bullets. |
| Comments and history | Bug history in comments, docs written as changelogs, rationale essays, ALL-CAPS. |
| Register | Intensifiers with no number, promotional words, borrowed authority, present-participle synthesis, invented labels, synonym cycling. |

The skill also lists what a fix must preserve, and ships `scan.sh`, which greps
a file or directory for the markers and labels each hit by group.

Compared with the [tropes.fyi directory](https://tropes.fyi/directory), the
[Writing Whip](https://tropes.fyi/whip) and
[Wikipedia's Signs of AI writing](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing),
which catalog essays and blog posts, the skill bans contrastive framing
outright, gives every pattern a rewrite, and adds the patterns of technical
prose: stance and agency, clefts, mechanism, headings and comments. Most of
those came from rewriting the docs of two real codebases, videoskillet and
react-msaview.

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

- [tropes.fyi](https://tropes.fyi) and its [directory](https://tropes.fyi/directory)
  by [Ossama Chaib](https://ossama.is): the self-answered question, "serves
  as", suspense transitions, false ranges, invented concept labels, restating
  closers, bold-first bullets, dead metaphors, narrated deliberation,
  self-echo, grandiose stakes and Title Case Headings.
- [The Writing Whip](https://tropes.fyi/whip), also by Ossama Chaib: synonym
  cycling, announcers and counts, the claim after its evidence, documentation
  as a changelog, appended corrections, borrowed authority and comma-clipped
  tails.
- [Prompting Claude Fable 5.1](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/prompting-claude-fable-5-1)
  (Anthropic): the figure-of-speech test, density, and the warning against
  dropping all formatting.
- [Prompting Claude Opus 5](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/prompting-claude-opus-5)
  (Anthropic): padding, outcome-first reports, reporting every finding before
  triage, and positive examples over prohibitions.
- [Wikipedia: Signs of AI writing](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing):
  promotional vocabulary, vague attribution and present-participle synthesis.
- The writing guides in [videoskillet](https://github.com/cmdcolin/videoskillet/blob/main/docs/WRITING.md)
  and [react-msaview](https://github.com/GMOD/JBrowseMSA/blob/main/docs/WRITING.md),
  where most of the technical-prose patterns and examples were first written
  down.
