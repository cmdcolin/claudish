# claudish

Skills for Claude Code.

| Skill | Use it for |
|---|---|
| [anti-ai-writing-tropes](skills/anti-ai-writing-tropes/SKILL.md) | Writing and reviewing docs, comments, captions and CLAUDE.md files. A checklist of the habits that make prose read as generated, each with a rewrite. |

## anti-ai-writing-tropes

Lists of AI tells like [tropes.fyi](https://tropes.fyi) target essay and blog
prose: "It's not X, it's Y", "Here's the kicker", "delve". This skill targets
technical writing, where the tells are different:

- data, files and figures given knowledge or a stance ("a layer the alignment
  cannot know")
- cleft sentences ("X is what makes Y work") and "the point is" announcements
- a conclusion in place of the mechanism ("a bad marker stops the build")
- teaser, negative and cute headings, and jokes in reference tables
- bug history and essays in code comments
- instruction files like CLAUDE.md, whose prose agents copy into everything they
  write next

Every pattern comes with a rewrite. The skill also covers fixing the prose
without breaking what it says, so the numbers, the terms the tools use and the
distinctions a reader needs survive the edit. The examples come from rewriting
real repositories.

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
