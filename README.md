# claudish

Skills for Claude Code.

| Skill | Use it for |
|---|---|
| [anti-ai-writing-tropes](skills/anti-ai-writing-tropes/SKILL.md) | Writing and reviewing docs, comments, captions, CLAUDE.md files and chat answers. A checklist of the habits that make prose read as generated, each with a rewrite. |

## anti-ai-writing-tropes

The skill is a checklist for technical writing: docs, READMEs, code comments,
figure captions, commit messages, PR descriptions and agent instruction files.
Each entry pairs a habit with a rewrite that keeps the same facts. A reader
often arrives at a paragraph from a search hit, so each paragraph has to make
sense alone: name the subject, state the fact, and leave nothing to carry over
from the previous paragraph.

### Contrastive framing

A sentence that defines a thing by what it is not answers an objection nobody
raised. Delete the negative half unless it steers the reader away from a choice
they would otherwise make.

| Pattern | Before | After |
|---|---|---|
| X, not Y | Each cache entry is stamped with an expiry time, not compared against the source. | Each cache entry is stamped with an expiry time. |
| A negation, then the claim | It's not a cache. It's a log. | It is a log. |
| Doesn't just X, it Y | The CLI doesn't just fetch the page, it caches it. | The CLI fetches the page and caches it. |
| Rather than | CI runs the install command from the README, so it is tested rather than remembered. | CI runs the install command from the README, so the command is tested. |
| A limiting "only" | The exporter names only the primary sample and labels every other sample `unknown#N`. | The exporter labels each sample other than the primary one `unknown#N`. |
| A bare negative | A record from a shard does not store its sample name. The sample table adds the names. | Sample names come from the sample table. |

### Stance and agency

A value, a file or a figure cannot know, say or earn anything. Name the
component or person that acts, or use a verb of description such as lists,
marks, contains or shows. Keep the passive where the actor is unknown, because
an invented actor is a new claim.

| Pattern | Before | After |
|---|---|---|
| A value given knowledge | The lockfile knows which versions to install. | The lockfile lists the versions to install. |
| An inanimate subject given ownership | each tab renders its own settings | each tab renders the settings stored for that tab |
| An artifact given a will | each bar rises to the height its frequency earns | each bar's height is proportional to its frequency |
| A figure of speech | The config file is load-bearing. | Every command reads the config file. |
| The passive voice hiding the actor | The field is left unset. | The parser leaves the field unset. |
| A value given perception | the cache sees the first request | the cache stores the first request |

### Sentence shapes

These shapes sound like a conclusion and state none, or split one sentence
across punctuation so the reader has to rejoin it. Write the subject and its
plain verb, and join facts that depend on each other.

| Pattern | Before | After |
|---|---|---|
| The cleft | Rounding is what shrinks the file. | Rounding shrinks the file. |
| The significance announcement | The key insight is that the index is sorted, which lets lookups use binary search. | The index is sorted, so lookups can use binary search. |
| A colon lead-in | Each cache invalidates where a stale read costs most: the session cache invalidates on logout. | The session cache invalidates on logout. |
| A comma-hung appositive | Version 1 opens one file, a design that cannot compare two. | Version 1 opens one file, so it cannot compare two. |
| A rule-of-three list | A file in, a filter applied, a PNG out. | The command reads the file, applies the filter and writes a PNG. |
| A staccato run | The key includes the path. A rename changes the key. The cache misses. | The key includes the path, so a rename changes the key and misses the cache. |
| A fronted "So that" clause | So that the page loads faster, we added an index. | To make the page load faster, we added an index. |
| A compressed noun phrase | The flush writes the dirty half of each page. | The flush writes the half of each page that has unsaved changes. |

### Openings and closings

A paragraph opens on its subject by name, even when the paragraph before named
it, and a section ends at its last fact. Aphorisms and outcome-only sentences
leave out the mechanism the reader came for.

| Pattern | Before | After |
|---|---|---|
| A pronoun opening a paragraph | It runs the same engine as the app. | The renderer runs the same engine as the app. |
| "The same X" across a heading | The same track feeds the graph view. | The `coverage` track also feeds the graph view. |
| A count standing in for its nouns | Click **Share**, or save the session to a file. *(video)* Both hold the same JSON. | The JSON from the Share dialog and the saved session file contain the same session. |
| An aphorism closing a section | The rate limit counts retries. A retry is still a request. | The rate limit counts retries as requests. |
| A conclusion standing in for the mechanism | A marker that does not parse stops the build. | The generator exits with an error on a marker it cannot parse, so the build fails. |
| Silently, quietly, invisibly | The second bug silently writes the wrong value. | The second bug writes the wrong value and raises no error. |

### Paragraph transitions

A paragraph that introduces a redesign states the limitation as a limitation in
one sentence and the response in the next. A sentence about where the field has
moved, with no citation behind it, adds nothing.

| Pattern | Before | After |
|---|---|---|
| A description where a limitation belongs | Version 1 opens one file at a time. Version 2 opens several, in tabs. | Version 1 is limited to one open file at a time. Version 2 removes that limit by opening several files in tabs. |
| A problem sized to the solution | Version 1 cannot show a diff between two files. Version 2 opens files in tabs and shows diffs. | Version 1 is limited to one open file at a time. Version 2 opens files in tabs, so it shows diffs. |
| A narrative bridge | Build tools have since moved toward incremental compilation. Our build recompiled every file on each change. We added a dependency graph, so it now recompiles only the files a change affects. | Our build recompiled every file on each change. We added a dependency graph, so it now recompiles only the files a change affects. |
| The old tool as the subject | A viewer that reads a log file downloads the whole file to show any line range. We created a chunked format, which `make-chunks` generates from a log file. | To limit the data transferred to the line range in view, we created a chunked format, which `make-chunks` generates from a log file. |

### Headings and labels

A heading names its subject in sentence case, and a flag table gives each flag a
plain label.

| Pattern | Before | After |
|---|---|---|
| A teaser heading | The one setting nobody else has | Offline mode |
| A phrase where a noun would do | Where the file goes | Output |
| A heading that says what a thing is not | What it does not do | Limitations |
| A heading that gives its subject agency | What a database answers | Contents and limitations |
| Cute naming in a reference table | `--seed=<n>` \| the dice | `--seed=<n>` \| random seed |

### Comments and history

A code comment states what the code does now. History belongs in the commit
message and rationale in a design doc.

| Pattern | Before | After |
|---|---|---|
| Bug history in a comment | reset() used to leave the Cancel button showing | reset() also hides the Cancel button |
| An essay where a clause would do | We considered leaving the keys in fetch order, but the diff output has to be stable across runs and fetch order is not, so we sort them first. | Sort the keys so the diff output is stable across runs. |
| ALL-CAPS emphasis | the ONLY difference | the only difference |

### Register

Generated text favors a small set of words and moves: stacked verbs such as
"leverage" and "ensure", participle clauses that draw a conclusion nobody is
making, invented labels, and a pitch that sells the thing without describing it.
Use the plain verb, one term per thing, and a measurement behind any
superlative.

| Pattern | Before | After |
|---|---|---|
| The verb cluster | The tool leverages a comprehensive set of heuristics to ensure correctness. | The tool uses a set of heuristics to check correctness. |
| Present-participle synthesis | Scores drop after the tokenizer change because the tagger was trained on the old token boundaries, highlighting how the two stages interact. | Scores drop after the tokenizer change because the tagger was trained on the old token boundaries. |
| A goal with no quantity | To optimize the rendering of alignments, we created an indexed format. | To limit the data transferred when drawing alignments to the region in view, we created an indexed format. |
| A sentence adverb | Ultimately, the index is the bottleneck. | The index is the bottleneck. |
| Small tics | The cache serves as the source of truth. | The cache is the source of truth. |
| A code-internal verb | The loader hydrates each record from the cache or the database. | The loader fills in each record from the cache or the database. |
| The pitch register | The library is the most modern JSON toolkit, and it does more than parse: it validates against a schema. | The library parses JSON and validates it against a schema. |

The skill also lists what a fix must preserve, and ships `scan.sh`, which greps
a file or directory for the markers and labels each hit by section.

The skill borrows from the [tropes.fyi directory](https://tropes.fyi/directory),
the [Writing Whip](https://tropes.fyi/whip) and
[Wikipedia's Signs of AI writing](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing).
It differs in three ways: it deletes contrastive framing by default, it pairs
every pattern with a rewrite, and it adds sections for technical prose.

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
  where most of the technical-prose patterns first appeared.
