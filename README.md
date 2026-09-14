# claudish

Skills for Claude Code.

| Skill | Use it for |
|---|---|
| [anti-ai-writing-tropes](skills/anti-ai-writing-tropes/SKILL.md) | Writing and reviewing docs, comments, captions and CLAUDE.md files. A checklist of the habits that make prose read as generated, each with a rewrite. |

## anti-ai-writing-tropes

A checklist for technical writing: docs, READMEs, tutorials, code comments,
figure captions, commit messages, PR descriptions and agent instruction files.
Each entry pairs a problem with the fix that keeps the same facts. Readers
arrive at a paragraph by search hit and deep link, so every paragraph has to
stand alone. Name the subject, state the fact, and leave nothing for the reader
to carry over from the paragraph before.

**Contrastive framing.** A contrastive sentence defines a thing by what it is
not: "stamped, not compared", "not a cache but a log". Delete the negative
half. The sentence almost always still says everything. Keep the negative only
when a reader who never saw it would pick the wrong option.

| Pattern | Before | After |
|---|---|---|
| Contrastive framing | Staleness is stamped, not compared. | Staleness is stamped. |
| Contrastive framing | It's not a cache. It's a log. | It is a log. |
| Contrastive framing | The CLI doesn't just fetch domains, it caches them. | The CLI fetches domains and caches them on disk. |
| Contrastive framing | CI runs the install command from the README, so it is tested rather than remembered. | CI runs the install command from the README, so a broken one fails the build. |

**Stance and agency.** Generated prose gives inanimate things a mind. A
lockfile knows, a figure says, a bar earns its height, a tab has its own
settings. A value or a drawing can do none of these. Name the component or
person that does the thing, or use a verb of description such as lists, marks
or shows. The same section covers figures of speech and the passive voice.
Write the literal word, and name the actor wherever you know it.

| Pattern | Before | After |
|---|---|---|
| A value given knowledge | The lockfile knows which versions to install. | The lockfile lists the exact version of each package. |
| An inanimate subject given ownership | each tab renders its own settings | each tab renders the settings stored for that window |
| An artifact given a will | each bar rises to the height its frequency earns | each bar's height is proportional to its frequency |
| A figure of speech | The config file is load-bearing. | Every command reads the config file. |
| The passive voice hiding the actor | The field is left unset. | The parser leaves the field unset. |

**Sentence shapes.** Some sentence shapes exist to land a beat, and state no
fact. The cleft ("rounding is what buys the room"), the colon that
generalizes before the facts, the appositive hung off a comma, the fragment and
the list of three all belong here. Write the subject and its plain verb. Give
each fact its own sentence.

| Pattern | Before | After |
|---|---|---|
| The cleft | Rounding is what buys the room. | Rounding saves two characters per value. |
| The significance announcement | The linter accepts the file, which is the honest answer to the question it was asked. | The linter accepts the file, because it checks only syntax, and the syntax is valid. |
| A colon lead-in | Each scale resolves where updating it costs least: a categorical color resolves in the shader. | A categorical color resolves in the shader. |
| A comma-hung appositive | Version 1 opens one file, a design that cannot compare two. | Version 1 opens only one file at a time, so it cannot compare two. |
| A rule-of-three list | A file in, a look applied, ProRes out. | The command reads the file, applies the look and writes ProRes 4444. |

**Openings and closings.** A reader who lands on a paragraph from a search
hit has no antecedent for "it" or "this". Open every paragraph on its subject
by name, even when the paragraph before named it. Say what the machine does
where a sentence names only the outcome. Cut an aphorism, an announcer such as
"two constraints shape the design", and a closing that restates. Stop at the
last fact.

| Pattern | Before | After |
|---|---|---|
| An aphorism opening a section | A phone GPU is still a phone GPU. | A phone GPU has much less headroom. |
| A conclusion standing in for the mechanism | A marker that does not parse stops the build. | The generator exits with an error on a marker it cannot parse, so the build fails. |
| Silently, quietly, invisibly | The second bug is the same class of wrong, quieter. | The second bug writes the wrong value and raises no error. |
| A pronoun opening a paragraph | It runs the app's own engine. | The renderer runs the app's own engine. |
| An announcer | Two constraints shape the design. First, ... | The design has to run offline. |

**Paragraph transitions.** A paragraph that introduces a new version or a
redesign has two parts: what was wrong before, and what changed. Common faults
are a plain description of the old version where a limitation belongs, a
limitation phrased in the new version's feature list, and an unsupported claim
about where the field has moved. Name the limitation as a limitation in one
sentence. Give the response a sentence of its own.

| Pattern | Before | After |
|---|---|---|
| A description where a limitation belongs | Version 1 opens one file at a time. Version 2 opens several. | Version 1 is limited to one open file at a time. Version 2 removes that limit by opening files in tabs, so you can compare two files side by side. |
| A problem sized to the solution | Version 1 cannot show a diff between two files. Version 2 shows diffs. | Version 1 is limited to one open file at a time. Version 2 opens files in tabs, so it can show a diff between two. |
| A narrative bridge | Build tools have since moved toward incremental compilation. Our build recompiled every file on each change. We added a dependency graph, so it now recompiles only the files a change affects. | Our build recompiled every file on each change. We added a dependency graph, so it now recompiles only the files a change affects. |

**Headings and labels.** A heading is read by someone scanning for a
subject, and a flag table by someone looking one thing up. Name the subject in
the heading, in sentence case. Give each flag a plain label. A teaser, a
phrase, a negative and a joke all cost the reader that lookup, and a bold lead
on every bullet is decoration.

| Pattern | Before | After |
|---|---|---|
| A teaser heading | The one setting nobody else has | Offline mode |
| A phrase where a noun would do | Where the file goes | Output |
| A heading that says what a thing is not | What it does not do | Limitations |
| Cute naming in a reference table | `--seed=<n>` \| the dice | `--seed=<n>` \| random seed; the same seed gives the same output |

**Comments and history.** A code comment describes the current behavior of
the code beside it. Bug history belongs in the commit message, and a rationale
essay in a design doc. A doc that reads as a changelog has the same fault at
page scale. Write emphasis into the sentence, never in capitals.

| Pattern | Before | After |
|---|---|---|
| Bug history in a comment | reset() used to leave the Cancel button showing | reset() also hides the Cancel button |
| An essay where a clause would do | We considered leaving the keys in fetch order, but the diff output has to be stable across runs and fetch order is not, so we sort them first. | Sort the keys so the diff output is stable across runs. |
| ALL-CAPS emphasis | the ONLY difference | the only difference |

**Register.** Word choice gives generated prose away as surely as sentence
shape. Promotional adjectives, borrowed authority ("surveys show"), a sentence
adverb such as "Additionally", verbs such as leverage and ensure, a participle
clause drawing a conclusion, an invented label and a cycle of synonyms for one
thing all belong here. Use the plain verb, delete the adjective, and use one
term per thing. An unqualified "faster" is fine; don't invent a measurement to
replace it.

| Pattern | Before | After |
|---|---|---|
| The verb cluster | The tool leverages a comprehensive set of heuristics to ensure correctness. | The tool checks each file against a set of heuristics. |
| Present-participle synthesis | Scores drop after the tokenizer change, highlighting how the two stages interact. | Scores drop after the tokenizer change, because the tagger was trained on the old token boundaries. |
| A sentence adverb | Ultimately, the index is the bottleneck. | The index is the bottleneck. |
| Small tics | The cache serves as the source of truth. | The cache is the source of truth. |

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
