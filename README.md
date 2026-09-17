# claudish

Skills for Claude Code.

| Skill | Use it for |
|---|---|
| [anti-ai-writing-tropes](skills/anti-ai-writing-tropes/SKILL.md) | Writing and reviewing docs, comments, captions and CLAUDE.md files. A checklist of the habits that make prose read as generated, each with a rewrite. |

## anti-ai-writing-tropes

The skill is a checklist for technical writing: docs, READMEs, tutorials, code
comments, figure captions, commit messages, PR descriptions and agent
instruction files. Each entry pairs a problem with a fix that keeps the same
facts. A reader usually arrives at a paragraph from a search hit or a deep link,
with no memory of the paragraph before it, so each paragraph has to make sense
by itself. Most of the entries below follow from that rule. Name the subject,
state the fact, and leave nothing for the reader to carry over from the previous
paragraph.

### Contrastive framing

A contrastive sentence defines a thing by what it is not, as in "staleness is
stamped, not compared" or "it's not a cache, it's a log". The negative half
answers an objection the reader never raised, and it usually carries no
information. Delete the negative half, and the sentence almost always still says
everything it said before. The exception is a negative that steers the reader
away from a choice they would otherwise make, such as the flag value people type
by mistake. Even then, a plain sentence with a "because" usually carries the
distinction better than the contrast does.

| Pattern | Before | After |
|---|---|---|
| X, not Y | Staleness is stamped, not compared. | Staleness is stamped. |
| A negation, then the claim | It's not a cache. It's a log. | It is a log. |
| Doesn't just X, it Y | The CLI doesn't just fetch domains, it caches them. | The CLI fetches domains and caches them on disk. |
| Rather than | CI runs the install command from the README, so it is tested rather than remembered. | CI runs the install command from the README, so a broken one fails the build. |

### Stance and agency

Generated prose tends to give inanimate things a mind and a will, so that a
lockfile knows which versions to install, a figure says what the parts are, a
bar rises to the height its frequency earns, and each tab renders its own
settings. None of these subjects can do what the verb claims, and the reader has
to translate each one back into the literal relation it stands for. Name the
component or the person that does the thing, or use a verb of description such
as lists, marks, contains or shows. The same habit produces figures of speech
where a literal word exists, such as "load-bearing" for "required", and passive
sentences that leave the actor out entirely. Write the literal word, and use the
active voice wherever you know who the actor is.

| Pattern | Before | After |
|---|---|---|
| A value given knowledge | The lockfile knows which versions to install. | The lockfile lists the exact version of each package. |
| An inanimate subject given ownership | each tab renders its own settings | each tab renders the settings stored for that tab |
| An artifact given a will | each bar rises to the height its frequency earns | each bar's height is proportional to its frequency |
| A figure of speech | The config file is load-bearing. | Every command reads the config file. |
| The passive voice hiding the actor | The field is left unset. | The parser leaves the field unset. |

### Sentence shapes

Some sentence shapes sound like a conclusion and state none. The cleft restates
a plain verb as "X is what does Y" ("rounding is what buys the room"), and the
significance announcement calls a fact important without saying why. The colon
lead-in puts a generalization first and the facts second, so the reader has to
match the two halves. The comma-hung appositive restates the subject
mid-sentence, and the fragment and the list of three leave out their verbs. A
staccato run of short sentences keeps the verbs and leaves out the "so" or
"because" that connects the facts. In each case the reader has to rebuild the
plain sentence the writer could have written. Write the subject and its plain
verb, give unrelated facts separate sentences, and join facts that depend on
each other.

| Pattern | Before | After |
|---|---|---|
| The cleft | Rounding is what buys the room. | Rounding saves two characters per value. |
| The significance announcement | The linter accepts the file, which is the honest answer to the question it was asked. | The linter accepts the file, because it checks only syntax, and the syntax is valid. |
| A colon lead-in | Each scale resolves where updating it costs least: a categorical color resolves in the shader. | A categorical color resolves in the shader. |
| A comma-hung appositive | Version 1 opens one file, a design that cannot compare two. | Version 1 opens only one file at a time, so it cannot compare two. |
| A rule-of-three list | A file in, a look applied, ProRes out. | The command reads the file, applies the look and writes ProRes 4444. |
| A staccato run | The key includes the path. A rename changes the key. The cache misses. | The key includes the path, so a rename changes the key and misses the cache. |
| A fronted "So that" clause | So that a browser fetches only the region in view, we built an index. | To limit the download to the region in view, we built an index. |

### Openings and closings

A reader who lands on a paragraph from a search hit has no antecedent for "it",
"this", "both" or "that limit". Open every paragraph on its subject by name,
even when the paragraph before named the same subject. The same reader gets
nothing from an aphorism that sounds like a conclusion and carries no fact. A
sentence that names an outcome ("the build stops") where the mechanism belongs,
or an adverb such as "silently" standing in for what happens, leaves the reader
without the fact they came for. Say what the machine does, name the actor, and
end the section at its last fact.

| Pattern | Before | After |
|---|---|---|
| A pronoun opening a paragraph | It runs the same engine as the app. | The renderer runs the same engine as the app. |
| A count standing in for its nouns | Click **Share**, or save the session to a file. *(video)* Both hold the same JSON. | The JSON from the Share dialog and the saved session file contain the same session. |
| An aphorism opening a section | A phone GPU is still a phone GPU. | A phone GPU has much less headroom. |
| A conclusion standing in for the mechanism | A marker that does not parse stops the build. | The generator exits with an error on a marker it cannot parse, so the build fails. |
| Silently, quietly, invisibly | The second bug is the same class of wrong, quieter. | The second bug writes the wrong value and raises no error. |

### Paragraph transitions

A paragraph that introduces a new version, a redesign or a fix has two halves:
what was wrong before, and what changed. Generated prose most often goes wrong
at the step from one half to the other. Sometimes the first half is a plain
description of the old version that leaves the reader to infer it was a
problem. Sometimes the writer phrases the limitation in exactly the terms of the
new version's feature list, so the whole paragraph reads as if it were written
backwards from the solution. And sometimes the writer inserts a sentence about
where the field has moved ("build tools have since shifted to incremental
compilation") to motivate the change, with no citation or measurement behind
it. Name the limitation as a limitation in one sentence, in general terms, and
give the response a separate sentence.

| Pattern | Before | After |
|---|---|---|
| A description where a limitation belongs | Version 1 opens one file at a time. Version 2 opens several. | Version 1 is limited to one open file at a time. Version 2 removes that limit by opening files in tabs, so you can compare two files side by side. |
| A problem sized to the solution | Version 1 cannot show a diff between two files. Version 2 shows diffs. | Version 1 is limited to one open file at a time. Version 2 opens files in tabs, so it can show a diff between two. |
| A narrative bridge | Build tools have since moved toward incremental compilation. Our build recompiled every file on each change. We added a dependency graph, so it now recompiles only the files a change affects. | Our build recompiled every file on each change. We added a dependency graph, so it now recompiles only the files a change affects. |
| The old tool as the subject | A browser that reads PAF downloads the whole file to draw any region. We created PIF, which `make-pif` generates from PAF. | To limit the data transferred to the alignments in view, we created PIF, a Tabix-indexed form of PAF. |

### Headings and labels

Someone scanning for a subject reads a heading, and someone looking up one entry
reads a flag table, so both have to name the thing plainly. A teaser heading
withholds the subject to create interest, a phrase heading ("where the file
goes") makes the reader parse a clause where a noun would do, a negative heading
tells them what a section is not about, and a joke in a reference table makes
them decode a label they only wanted to read. Name the subject in the heading,
in sentence case, and give each flag a plain label. A bold lead on every bullet
of an ordinary list is decoration from the same habit, and it belongs only where
the bullet defines a term.

| Pattern | Before | After |
|---|---|---|
| A teaser heading | The one setting nobody else has | Offline mode |
| A phrase where a noun would do | Where the file goes | Output |
| A heading that says what a thing is not | What it does not do | Limitations |
| Cute naming in a reference table | `--seed=<n>` \| the dice | `--seed=<n>` \| random seed; the same seed gives the same output |

### Comments and history

A code comment describes the current behavior of the code beside it, and
nothing else. A comment that recounts how the code got here ("used to leave the
Cancel button showing") or argues for the choice at essay length is carrying
material that belongs elsewhere: the history in the commit message, and the
rationale in a design doc that the comment can point to. A document that reads
as a changelog, with a paragraph explaining what the previous version did before
saying what this one does, has the same fault at page scale. Write the
constraint the code satisfies, with the measurement if there is one, and write
emphasized words in lowercase.

| Pattern | Before | After |
|---|---|---|
| Bug history in a comment | reset() used to leave the Cancel button showing | reset() also hides the Cancel button |
| An essay where a clause would do | We considered leaving the keys in fetch order, but the diff output has to be stable across runs and fetch order is not, so we sort them first. | Sort the keys so the diff output is stable across runs. |
| ALL-CAPS emphasis | the ONLY difference | the only difference |

### Register

Four word-level patterns are distinctive to generated text. A verb cluster
stacks "leverage", "utilize" and "ensure" where "use", "check" and "make" were
meant. A participle clause draws a conclusion nobody is making ("highlighting
how the two stages interact"). An invented label appears as if it were an
established term. A cycle of synonyms for one thing makes the reader suspect
three things.

A single promotional adjective such as "robust" or "seamless", a
borrowed-authority phrase such as "surveys show", or a sentence adverb such as
"Additionally" is weak prose that people wrote long before LLMs existed. Fix
those as well, because the plain verb and the stated relation carry more
information than the filler did. Use the plain verb, delete the adjective, and
use one term per thing throughout. An unqualified comparative such as "faster"
is fine as it stands, and a measurement invented to replace it reads worse than
the word did.

The pitch register uses none of those words and sells the thing anyway. "WebGPU
is the most modern GPU API in browsers, and it does more than draw" ranks the
API and boasts a capability, and the reader can check neither claim. The same
register produces the future-potential teaser ("they could do much more") and
the priority claim ("an early use of compute shaders in a genome browser").
Write what the thing does, give a superlative the measurement that ranks it, and
give a priority claim the citation it comes before.

| Pattern | Before | After |
|---|---|---|
| The verb cluster | The tool leverages a comprehensive set of heuristics to ensure correctness. | The tool checks each file against a set of heuristics. |
| Present-participle synthesis | Scores drop after the tokenizer change, highlighting how the two stages interact. | Scores drop after the tokenizer change, because the tagger was trained on the old token boundaries. |
| A goal with no quantity | To optimize the rendering of alignments, we created an indexed format. | To limit the data transferred when drawing alignments to the region in view, we created an indexed format. |
| A sentence adverb | Ultimately, the index is the bottleneck. | The index is the bottleneck. |
| Small tics | The cache serves as the source of truth. | The cache is the source of truth. |
| The pitch register | WebGPU is the most modern GPU API in browsers, and it does more than draw. | A WebGPU compute shader runs general-purpose work on the GPU. |

The skill also lists what a fix must preserve, and ships `scan.sh`, which greps
a file or directory for the markers and labels each hit by section.

The skill borrows from the [tropes.fyi directory](https://tropes.fyi/directory),
the [Writing Whip](https://tropes.fyi/whip) and
[Wikipedia's Signs of AI writing](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing),
and differs from them in three ways. It tells the writer to delete contrastive
framing by default, it pairs every pattern with a rewrite, and it adds sections
for technical prose: stance and agency, sentence shapes, openings and closings,
paragraph transitions, headings and labels, comments and history, and register.

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
  where most of the technical-prose patterns and examples first appeared.
