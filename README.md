# claudish

Skills for Claude Code.

| Skill | Use it for |
|---|---|
| [anti-ai-writing-tropes](skills/anti-ai-writing-tropes/SKILL.md) | Writing and reviewing docs, comments, captions and CLAUDE.md files. A checklist of the habits that make prose read as generated, each with a rewrite. |

## anti-ai-writing-tropes

A checklist for technical writing: docs, READMEs, tutorials, code comments,
figure captions, commit messages and agent instruction files. Each entry pairs
a problem with the fix that keeps the same facts.

| Section | Problem | Fix |
|---|---|---|
| Contrastive framing | The sentence defines a thing by what it is not: "X, not Y", "rather than", "not just X but Y", "It's not X. It's Y." | Delete the negative half; the sentence almost always still says everything. Keep it only when a reader who never saw it would pick the wrong option or hold a wrong belief. |
| Stance and agency | A value, file or figure knows, says or earns something; a drawn thing owns what it shows ("each lane draws its own genes", "takes its own row"); a figure of speech stands where a literal word exists. | Name the actor that does the thing (the parser, the display) or use a verb of description. Say what the possessive stands for: one per genome, annotated on that contig. Replace the figure with the literal word from the lookup table. |
| Sentence shapes | The sentence bends to land a beat: a cleft ("X is what does Y"), a significance announcement, dramatic negation, a which-ladder, a colon lead-in, a comma-hung appositive ("a browser without X, one that can Y"), a fragment, a rule-of-three list, an em-dash aside. | Write the plain verb and its subject. Delete the lead-in and start on the facts. Fold the appositive into a relative clause on the noun. Give each fact its own sentence. |
| Openings and closings | A section opens on an aphorism or a pronoun, states an outcome where the mechanism belongs, hides a failure behind "silently", announces its own shape, repeats a refrain, or closes by restating. | Open on the subject by name and the first observation. Write what the machine does. Stop at the last fact. |
| Paragraph transitions | The turn from prior state to response is missing or overloaded: a description where a limitation belongs, a narrative bridge with no evidence, a problem sized to the solution's features, a colon or comma carrying the turn. | Name the limitation as a limitation, in general terms, in one sentence. Give the response its own sentence. Cut any motivating claim that has no citation. |
| Headings and labels | A teaser, phrase or negative heading; Title Case; a joke in a reference table; a bold-first bullet. | Name the subject in the heading, in sentence case. Give a flag table plain labels and a list plain bullets. |
| Comments and history | A comment carries bug history or a rationale essay; a doc reads as a changelog; ALL-CAPS for emphasis. | Comment the current behavior only. Put history in git and rationale in a design doc. |
| Register | An intensifier with no number, a promotional word, borrowed authority, present-participle synthesis (", reducing data transfer"), an invented label, synonym cycling. | Give the number. Delete the adjective. Make the participle its own sentence with its own subject. Use one term per thing. |

The skill also lists what a fix must preserve, and ships `scan.sh`, which greps
a file or directory for the markers and labels each hit by group.

Compared with the [tropes.fyi directory](https://tropes.fyi/directory), the
[Writing Whip](https://tropes.fyi/whip) and
[Wikipedia's Signs of AI writing](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing),
this repo bans contrastive framing
outright, gives every pattern a rewrite, and adds the patterns of technical
prose: stance and agency, clefts, mechanism, headings and comments. 

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
