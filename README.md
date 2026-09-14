# claudish

Skills for Claude Code.

| Skill | Use it for |
|---|---|
| [anti-ai-writing-tropes](skills/anti-ai-writing-tropes/SKILL.md) | Writing and reviewing docs, comments, captions and CLAUDE.md files. A checklist of the habits that make prose read as generated, each with a rewrite. |

## anti-ai-writing-tropes

A checklist for technical writing: docs, READMEs, tutorials, code comments,
figure captions, commit messages and agent instruction files. Each pattern
comes with a rewrite that keeps the same facts, so the fix is a shape to copy.
The tables below are the short form; the
[skill](skills/anti-ai-writing-tropes/SKILL.md) has the tests and the
exceptions.

### What it catches

**Contrastive framing.** The strictest rule. Every form gets the same fix:
delete the negative half. A contrast survives only when the reader would
otherwise pick the wrong option.

| Pattern | Before | After |
|---|---|---|
| X, not Y | Staleness is stamped, not compared. | Staleness is stamped. |
| rather than, instead of | The overlay is column-locked instead of drawn per protein. | The overlay is column-locked. |
| It's not X. It's Y. | It's not a cache. It's a log. | It is an append-only log. |
| not just X but Y | The CLI doesn't just fetch domains, it caches them. | The CLI fetches domains and caches them on disk. |

**Stance and agency.** A component may act. A value, column, file or figure is
a thing being described, so it knows, says and earns nothing.

| Pattern | Before | After |
|---|---|---|
| A value given knowledge | ClinVar adds a layer the alignment cannot know. | The ClinVar track marks pathogenic variants per residue. |
| A figure given a voice | The boxes say what the parts are; the arcs say how they pack. | The boxes mark the domains, and the arcs mark residue pairs in contact. |
| An artifact given a will | which is the tree saying it cannot resolve them | the support values are too low to resolve them |
| A figure of speech | each bar rises to the height its frequency earns | each bar's height is proportional to its frequency |
| A figure of speech | the config is load-bearing | the config is required |

**Sentence shapes.**

| Pattern | Before | After |
|---|---|---|
| Cleft | Rounding is what buys the room | Rounding saves two characters per value |
| Significance announcement | ..., which is the honest answer to the question it was asked | ..., because the model predicts whether a substitution breaks the fold, and this one does not |
| Dramatic negation | Producing the file is not the viewer's job. | The CLI produces the file. |
| Which-ladder | a different alignment, which is a new model, which React spells `key` | A new input needs a new model, so change the component's `key`. |
| Mannered inversion | Hence the second pass. | The parser makes a second pass to resolve forward references. |
| Fragment | Nine load paths, no unit test that can reach them. | There are nine load paths, and no unit test reaches any of them. |
| Rule of three | A file in, a look applied, ProRes out. | The command reads the file, applies the look and writes ProRes 4444. |
| Em-dash asides | three in one paragraph | one kept, one promoted to a sentence, one demoted to a comma |

**Openings and closings.**

| Pattern | Before | After |
|---|---|---|
| Aphorism | A phone GPU is still a phone GPU. | A phone GPU has much less headroom. |
| Conclusion in place of mechanism | A marker that does not parse stops the build. | The generator exits with an error on a marker it cannot parse, so the build fails. |
| Silently, quietly, invisibly | The second bug is the same class of wrong, quieter. | The second bug highlights the wrong residue and raises no error. |
| Policy refrain | "the viewer computes nothing" closing every caption | the rule stated once, in the design doc |
| Pronoun opening a paragraph | It runs the app's own engine. | The renderer runs the app's own engine. |
| Padding | an overview that repeats the headings, a summary per section | the outcome first, supporting detail after |

**Headings and labels.**

| Pattern | Before | After |
|---|---|---|
| Teaser heading | The four columns nobody else has | PRRA insert |
| Phrase where a noun would do | Where the file goes | Output |
| Negative heading | What it does not do | Limitations |
| Cute naming in a reference table | `--seed=<n>`: the dice | `--seed=<n>`: random seed; the same seed gives the same output |

**Comments.**

| Pattern | Before | After |
|---|---|---|
| Bug history | `reset() used to leave the Cancel button showing` | `reset() also hides the Cancel button` |
| Essay where a clause would do | `We considered leaving the keys in fetch order, but the diff output has to be stable across runs and fetch order is not, so we sort them first.` | `Keys are sorted so the diff output is stable across runs.` |
| ALL-CAPS emphasis | `the ONLY difference` | `the only difference` |

**Register.**

| Pattern | Before | After |
|---|---|---|
| Stock sentence | the same caution on every page | said once and linked |
| Intensifier with no number | dramatically simpler | the measured difference |
| Promotional words | robust, seamless, delve, pivotal, testament | the plain word, or nothing |
| Present-participle synthesis | Scores drop after the tokenizer change, highlighting how the two stages interact. | Scores drop after the tokenizer change, because the tagger was trained on the old token boundaries. |
| Synonym cycling | a track, then a lane, then a layer | one noun, repeated |

**From tropes.fyi.** The skill folds the essay-prose tropes that turn up in
docs into the sections above: the self-answered question, "serves as", false
ranges, comma-clipped tails, announcers and counts, premise stacking, closings
that restate, invented concept labels, bold-first bullets, dead metaphors,
synonym cycling, self-echo, documentation as a changelog, appended
corrections, appeals to familiarity, narrated deliberation, grandiose stakes
and Title Case Headings.

### What it offers over other trope lists

The [tropes.fyi directory](https://tropes.fyi/directory) (49 tropes, each with
one example and a trend label), [The Writing Whip](https://tropes.fyi/whip) (the
directory restated as instructions) and
[Wikipedia's Signs of AI writing](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing)
catalog the tells of essays, blog posts, slides and encyclopedia articles. The
skill folds in the ones that also appear in technical prose, credited under
[References](#references), and adds:

- Contrastive framing is banned by default. The directory objects to negative
  parallelism only when it is overused.
- Every pattern has a rewrite that keeps the same facts. The directory and the
  whip show one example to avoid per trope, with no rewrite.
- The stance and agency, sentence shape, heading and comment patterns above
  are specific to technical prose. As of September 2026, none of them appears
  in the directory.
- Tests a writer can apply mechanically:
  - "Could the subject perform the verb if you ran the program?" A parser can
    reject; a column cannot know.
  - "What literal word does this figure stand for?" A table maps common figures
    to their literal replacements ("load-bearing" → "required", "a one-way
    door" → "irreversible").
  - "Would a reader who never saw the negative half choose wrong?" If not, the
    contrast goes.
- A list of what a fix must preserve: the claim, every number and identifier,
  the terms the tools use, an author's deliberate idiom, the declined option in
  a design record, and generated text, whose fix goes in the generator.
- A warning about overcorrecting. Removing tropes tends to lengthen sentences,
  so the skill covers density, and it says when a list or table is the right
  format.
- Instruction files first. Agents copy the prose of `CLAUDE.md` and `AGENTS.md`
  into everything they write, so the skill says to fix those files before any
  other and to write every style rule in the style it asks for.
- A review workflow: a scan script that greps for hotspots and labels each
  hit by group, each hit read in context, and every instance reported before
  deciding which to fix.
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
