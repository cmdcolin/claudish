# claudish

Skills for Claude Code.

| Skill | Use it for |
|---|---|
| [anti-ai-writing-tropes](skills/anti-ai-writing-tropes/SKILL.md) | Writing and reviewing docs, comments, captions and CLAUDE.md files. A checklist of the habits that make prose read as generated, each with a rewrite. |

## anti-ai-writing-tropes

A checklist for technical writing: docs, READMEs, tutorials, code comments,
figure captions, commit messages, PR descriptions and agent instruction files.
Each entry pairs a problem with the fix that keeps the same facts.

**Contrastive framing.** The sentence defines a thing by what it is not.
Delete the negative half; the sentence almost always still says everything.
Keep it only when a reader who never saw it would pick the wrong option.

| Before | After |
|---|---|
| Staleness is stamped, not compared. | Staleness is stamped. |
| It's not a cache. It's a log. | It is a log. |
| The CLI doesn't just fetch domains, it caches them. | The CLI fetches domains and caches them on disk. |
| CI runs the install command from the README, so it is tested rather than remembered. | CI runs the install command from the README, so a broken one fails the build. |

**Stance and agency.** A value, file or figure knows, says and earns nothing,
and a drawn thing owns nothing. Name the actor that does the thing, or use a
verb of description. Replace a figure of speech with the literal word.

| Before | After |
|---|---|
| ClinVar adds a layer the alignment cannot know. | The ClinVar track marks pathogenic variants per residue. |
| each lane draws its own cluster genes | each lane draws the cluster genes annotated in that genome |
| each bar rises to the height its frequency earns | each bar's height is proportional to its frequency |
| The config file is load-bearing. | Every command reads the config file. |

**Sentence shapes.** The sentence bends to land a beat: a cleft, a
significance announcement, a which-ladder, a colon lead-in, a comma-hung
appositive, a fragment, a rule-of-three list. Write the plain verb and its
subject, and give each fact its own sentence.

| Before | After |
|---|---|
| Rounding is what buys the room. | Rounding saves two characters per value. |
| The model scores the variant benign, which is the honest answer to the question it was asked. | The model scores the variant benign, because it predicts whether a substitution breaks the fold, and this one does not. |
| Each scale resolves where updating it costs least: a categorical color resolves in the shader. | A categorical color resolves in the shader. |
| Version 1 displays a single chromosome, a design that cannot show synteny. | Version 1 is limited to a single chromosome at a time, so it cannot show synteny. |
| A file in, a look applied, ProRes out. | The command reads the file, applies the look and writes ProRes 4444. |

**Openings and closings.** A section opens on an aphorism or a pronoun,
states an outcome where the mechanism belongs, hides a failure behind
"silently", announces its own shape, or closes by restating. Open on the
subject by name. Write what the machine does. Stop at the last fact.

| Before | After |
|---|---|
| A phone GPU is still a phone GPU. | A phone GPU has much less headroom. |
| A marker that does not parse stops the build. | The generator exits with an error on a marker it cannot parse, so the build fails. |
| The second bug is the same class of wrong, quieter. | The second bug highlights the wrong residue and raises no error. |
| It runs the app's own engine. | The renderer runs the app's own engine. |
| Two constraints shape the design. First, ... | The design has to run offline. |

**Paragraph transitions.** The turn from prior state to response is missing
or overloaded: a description where a limitation belongs, a narrative bridge
with no evidence, a problem sized to the solution's features. Name the
limitation as a limitation, in one sentence, then give the response its own.

| Before | After |
|---|---|
| Version 1 shows a single chromosome of a single species at a time. We built version 2 to lift that limit. | Version 1 is limited to visualizing a single chromosome of a single species at a time. We built version 2 as a general-purpose genome browser that removes this restriction by displaying multiple assemblies and regions together, which allows it to visualize cross-species synteny and complex structural variation. |
| Version 1 cannot show a syntenic alignment between two genomes. We built version 2 to visualize synteny. | Version 1 is limited to visualizing a single chromosome of a single species at a time. We built version 2 ... displaying multiple assemblies and regions together, which allows it to visualize cross-species synteny. |
| We built version 2 as a genome browser without that restriction, one that can display multiple assemblies together. | We built version 2 as a genome browser that removes this restriction by displaying multiple assemblies together. |
| Build tools have since moved toward incremental compilation. Our build recompiles every file on each change, so we added a dependency graph. | Our build recompiles every file on each change, so we added a dependency graph. |

**Headings and labels.** A teaser, phrase or negative heading; Title Case; a
joke in a reference table; a bold-first bullet. Name the subject in the
heading, in sentence case, and give a flag table plain labels.

| Before | After |
|---|---|
| The one setting nobody else has | Offline mode |
| Where the file goes | Output |
| What it does not do | Limitations |
| `--seed=<n>` \| the dice | `--seed=<n>` \| random seed; the same seed gives the same output |

**Comments and history.** A comment carries bug history or a rationale essay;
a doc reads as a changelog; ALL-CAPS for emphasis. Comment the current
behavior only. Put history in git and rationale in a design doc.

| Before | After |
|---|---|
| reset() used to leave the Cancel button showing | reset() also hides the Cancel button |
| We considered leaving the keys in fetch order, but the diff output has to be stable across runs and fetch order is not, so we sort them first. | Keys are sorted so the diff output is stable across runs. |
| the ONLY difference | the only difference |

**Register.** An intensifier with no number, a promotional word, borrowed
authority, a sentence adverb, the leverage/utilize/ensure verb cluster,
present-participle synthesis, an invented label, synonym cycling. Use the plain
verb, delete the promotional adjective, and use one term per thing. An
unqualified "faster" is fine; don't invent a measurement to replace it.

| Before | After |
|---|---|
| The tool leverages a comprehensive set of heuristics to ensure correctness. | The tool checks each file against a set of heuristics. |
| Scores drop after the tokenizer change, highlighting how the two stages interact. | Scores drop after the tokenizer change, because the tagger was trained on the old token boundaries. |
| Ultimately, the index is the bottleneck. | The index is the bottleneck. |
| The cache serves as the source of truth. | The cache is the source of truth. |

The skill also lists what a fix must preserve, and ships `scan.sh`, which greps
a file or directory for the markers and labels each hit by section.

Compared with the [tropes.fyi directory](https://tropes.fyi/directory), the
[Writing Whip](https://tropes.fyi/whip) and
[Wikipedia's Signs of AI writing](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing),
this repo deletes contrastive framing by default, gives every pattern a
rewrite, and adds the patterns of technical prose: stance and agency, clefts,
mechanism, headings and comments.

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
