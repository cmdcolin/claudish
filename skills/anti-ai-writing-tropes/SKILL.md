---
name: anti-ai-writing-tropes
description: Checklist of prose habits that make technical writing read as generated, each with a before/after rewrite. Use when writing or editing docs, READMEs, tutorials, code comments, commit messages, figure captions or agent instruction files (CLAUDE.md), and when asked to review or clean up writing for AI tropes.
---

# Anti-AI writing tropes

Write plain technical English in ordinary declarative sentences. Each habit
below is one that model-written prose falls into, paired with a rewrite, so the
fix is a pattern to copy. The habits compound: one of them reads as a choice,
and a page of them reads as generated, because the sentences stop connecting
and the reader supplies the joins.

## How to use this

- Writing: draft normally, then reread against the checklist before finishing.
  Fix the sentence around a trope. A synonym in the same sentence pattern is
  the same trope.
- Reviewing a file or repo: grep for the markers in [Quick scan](#quick-scan)
  to find hotspots, then read those passages in context. Treat a grep hit as a
  lead to read; some em-dashes are fine.
- Fixing: keep every fact. A rewrite that drops a number or changes what a
  sentence claims is worse however plain it reads. See
  [What not to flatten](#what-not-to-flatten).
- Reviewing for someone else: report every instance, then triage. A "report
  only the worst" instruction makes a reviewer drop real findings.
- Instruction files: fix `CLAUDE.md`, `AGENTS.md` and similar files first.
  Agents read them every session and copy their prose as house voice, so a
  trope there spreads into every document written afterwards. When you add a
  style rule to one, include the rewrite along with the ban: a model copies a
  positive example more reliably than it obeys a prohibition.

## Contrastive framing

Contrastive framing is the strictest rule in the checklist. State what a thing
is or does. Leave out what it is not, what it replaces, and what someone might
have assumed.

The pattern defines a thing against an alternative the reader never raised.
It shows up in every register and in several forms:

- "X, not Y": "Staleness is stamped, not compared."
- "rather than" and "instead of": "so it is tested rather than remembered"
- "not just X but Y" and "X doesn't just Y, it Z"
- "not because X but because Y"
- a negation followed by the real claim: "It's not a cache. It's a log." and
  "The question isn't speed. The question is correctness."
- "Not X. Not Y. Just Z."
- "is not X's job" or "is not the point" before saying what is
- a heading that says what a thing is not: "What this is not"

The default fix is to delete the negative half. The sentence almost always
still says everything.

> Staleness is stamped, not compared. → Staleness is stamped.
>
> CI runs the install command from the README, so it is tested rather than
> remembered. → CI runs the install command from the README, so a broken one
> fails the build.
>
> The overlay is column-locked instead of drawn per protein. → The overlay is
> column-locked.
>
> It's not a cache. It's a log. → It is an append-only log.
>
> The CLI doesn't just fetch domains, it caches them. → The CLI fetches domains
> and caches them on disk.

The test: would a reader who never saw the negative half make a wrong choice or
hold a wrong belief? If not, delete it. The test passes only in three cases:

- An option the reader would otherwise pick. "Use `Pfam`, not `PfamA`" names
  the value people type by mistake.
- A choice whose alternative gives a different result. "All-atom distance,
  not C-beta" matters when the two give different contact sets.
- A design record naming the option it declined, which is the record's
  purpose.

Even then, a plain sentence usually carries the distinction better than the
"X, not Y" pattern: "Contacts use all-atom distance, because C-beta distance
misses side-chain contacts." A contrast written for rhythm or emphasis never
passes the test.

## Stance and agency

**A value given knowledge or a stance.** A component may act: the parser
rejects a file, the CLI warns, the server refuses the request. A value, a
column, a file, a figure or a sign is a thing being described, so it knows
nothing, says nothing, disagrees with nothing and earns nothing. The test: could
the subject perform the verb if you ran the program? A parser can reject; a
column cannot know. When it could not, find the actor that does the thing, or
use a verb of description (marks, contains, shows, is).

> ClinVar adds a layer the alignment cannot know. → The ClinVar track marks
> pathogenic variants per residue.
>
> The boxes say what the parts are; the arcs say how they pack → The boxes mark
> the domains, and the arcs mark residue pairs in contact.
>
> signs that disagree → one end marked `+` and the other `-`

**An artifact given a purpose or a will.** "the choice it exists to offer",
"the failure this layer exists to avoid", "the tree cannot resolve them".

> which is the tree saying it cannot resolve them → the support values are too
> low to resolve them

**A technical term given a personality.** Keep the term the tools use and fix
the sentence around it.

> `useEffect` is eager to re-run → `useEffect` re-runs whenever a dependency
> changes

**A figure of speech where a literal word exists.** Metaphors like "a dial worth
turning" for "a parameter worth varying", or "earns its keep" for "is useful",
make the reader translate back to the literal claim. They also bring
connotations the writer did not choose: "rot" implies decay nobody measured,
and "a one-way door" implies a door. The test is mechanical. For each verb or
noun that is not literally true of its subject, ask what literal word it stands
for, and write that word. Keep a figure only when no literal phrase exists or
the field has adopted it as a term ("memory leak", "race condition").

> each bar rises to the height its frequency earns → each bar's height is
> proportional to its frequency

| Figure | Literal |
|---|---|
| earns its keep, earns its place | is needed, is used |
| buys (room, time, safety) | saves, gives, allows |
| pays for itself, pays double | costs less than it saves, is useful twice |
| a dial / knob / lever | a parameter, an option |
| load-bearing | required, depended on |
| a one-way door | irreversible |
| rots, drifts, goes stale | falls out of date when X changes |
| fight over, compete for | both write, both read |
| the edge, the frontier | the exception, the limit |
| lives in, lands in, arrives | is defined in, is stored in, is loaded |
| a second door, the front door | a second entry point, the main API |
| reads loud / reads quiet | is high / is low |
| the shape (of a problem, of data) | the structure, the format, the pattern |
| surfaces (a problem) | reports, shows |
| a footgun, a trap | an error-prone API; name the error |
| moves the needle | changes the measured result by N |

## Sentence shapes

**The cleft: "X is what does Y".** It turns a plain verb into a verdict.

> column-locking is what stacks them → the overlay places domains by column,
> which lines them up
>
> Rounding is what buys the room → Rounding saves two characters per value

**The significance announcement.** "the point", "the whole point", "the honest
answer", "the payoff", "the key insight", "worth naming". Delete the
announcement and state the fact.

> The model scores the variant benign, which is the honest answer to the
> question it was asked. → The model scores the variant benign, because it
> predicts whether a substitution breaks the fold, and this one does not.

**Dramatic negation.** A sentence whose subject is "nothing", "no one" or
"none", or a "not X's job", reads as a pronouncement. Say what does happen.

> Nothing is prepared for the viewer → The example loads the published URL as
> is.
>
> Producing the file is not the viewer's job → The CLI produces the file.

**A which-ladder.** Each relative clause relabels the one before it.

> a different alignment, which is a new model, which React spells `key` → A new
> input needs a new model, so change the component's `key`.

**Two conclusions stacked on "so".** Split the second into its own sentence; it
is the one the reader loses.

> The key includes the path, so a rename misses the cache, so the first load
> after a rename is slow. → The key includes the path, so a rename misses the
> cache. The first load after a rename is therefore slow.

**A mannered inversion or dropped subject.** Fronting the complement, or opening
on "So", "And" or "Hence" that carries the previous sentence's subject.

> Known now is which latency the number reports: the queue's own. → The number
> reports the queue's own latency.
>
> Hence the second pass. → The parser makes a second pass to resolve forward
> references.

**A fragment standing in for a sentence.** A caption with no verb, or a bullet
with its subject dropped.

> Nine load paths, no unit test that can reach them. → There are nine load
> paths, and no unit test reaches any of them.

**A rule-of-three list doing a sentence's work.** Three parallel fragments with
the verbs dropped.

> A file in, a look applied, ProRes out. → The command reads the file, applies
> the look and writes ProRes 4444.

**Density.** Long sentences packed with qualifications, and paragraphs that run
for a screen without a break. A rewrite that removes the tropes above often
makes this worse, because the fix adds a clause for the mechanism. Give each
fact its own sentence, and break the paragraph where the subject changes.

**Em-dash asides.** One in a paragraph is punctuation; three is a writer avoiding
sentence boundaries. A ` -- ` in a code comment is the same habit. Promote one
to its own sentence, demote one to a comma, keep the one that is genuinely
parenthetical.

## Openings and closings

**An aphorism closing (or opening) a section.** A short balanced sentence that
sounds like a conclusion and carries no fact. It survives a first edit because
it reads as style.

> A phone GPU is still a phone GPU. → A phone GPU has much less headroom.
>
> The snapshot is the API. → Every field below is a property of the model.

**A conclusion standing in for the mechanism.** A sentence naming the outcome
(the build stops, the link breaks) where the sentence saying how it happens
belongs. Write what the machine does and name the actor.

> A marker that does not parse stops the build. → The generator exits with an
> error on a marker it cannot parse, so the build fails.

**Silently, quietly, invisibly.** An adverb standing in for the mechanism of a
failure. Name what the reader observes, or drop it.

> The second bug is the same class of wrong, quieter. → The second bug
> highlights the wrong residue and raises no error.

**The policy refrain.** A project rule ("the viewer computes nothing", "no
external services") restated as the closer of captions and section intros. State
the rule once, in the design doc.

**A thesis paragraph.** An opening that argues for the page's importance, or a
wrong inference named only to refute it. Start at the first observation; stop a
section at the last one.

**Padding.** A document longer than its substance: an overview that repeats the
headings, a summary per section, a boilerplate "Future work". Match the length
to the facts. A report or a PR description leads with the outcome, what changed
or what was found, and puts supporting detail after it.

**A pronoun opening a paragraph.** A reader arriving by search hit or deep link
has no antecedent for "It", "This" or "That". Name the subject.

> It runs the app's own engine. → The renderer runs the app's own engine.

## Headings and labels

**A teaser heading.** A heading or title that withholds its subject to create
interest. Name the subject.

> The four columns nobody else has → PRRA insert

**A phrase where a noun would do.** Keep a phrase only where the section answers
a question the reader asks in those words, such as an FAQ entry or a `Why ...`
section.

> Where the file goes → Output
>
> What you need before starting → Requirements

**A heading that says what a thing is not.** A scanning reader gets nothing from
a negative, unless the distinction is the whole finding of the section.

> What it does not do → Limitations

**Cute naming in a reference table.** A flag table or column header is read by
someone looking one thing up.

> `--seed=<n>` | the dice → `--seed=<n>` | random seed; the same seed gives the
> same output

## Comments

**Bug history in a comment.** "used to", "the previous version", "found while
debugging" describe how the code got here, and that belongs in the commit
message. The comment states the constraint the code satisfies, with the
measurement if there is one.

> reset() used to leave the Cancel button showing → reset() also hides the
> Cancel button

**An essay where a clause would do.** Keep the measurement and the non-obvious
constraint; cut the argument around them. Repeated rationale belongs in one
place with pointers to it.

> // We considered leaving the keys in fetch order, but the diff output has to
> // be stable across runs and fetch order is not, so we sort them first. →
> // Keys are sorted so the diff output is stable across runs.

**ALL-CAPS emphasis.** "the ONLY difference", "DON'T MEASURE". Emphasis is the
sentence's job.

## Register

**Stock sentences.** A caution or framing sentence repeated from page to page
reads as boilerplate by the second page. Say it once and link to it.

**An informalism in a formal register.** Judge a word by the document it
appears in. An intensifier with no number behind it is the same slip in a document
that quantifies everything else: `dramatically simpler`, `greatly reduced`.

**Promotional and vague-attribution words.** `vibrant`, `groundbreaking`,
`boasts`, `flagship`, `crisp`, `seamless`, `robust`; `industry reports`,
`surveys show`; the `delve` / `tapestry` / `testament` / `showcase` / `pivotal`
cluster.

**Present-participle synthesis.** `…, highlighting how the two stages interact`
is a claim with nobody making it. Write the claim as its own sentence or drop
it.

> Scores drop after the tokenizer change, highlighting how the two stages
> interact. → Scores drop after the tokenizer change, because the tagger was
> trained on the old token boundaries.

**Small tics.** "reads straight off", "tells a story", "shape" as an all-purpose
noun, "counterpoint", "actually", "genuinely", circular sentences ("an alignment
is an alignment").

## Also in technical prose

[tropes.fyi](https://tropes.fyi) catalogs the tropes of essay and blog prose.
These, from its directory, turn up in docs and READMEs too.

**The self-answered question.** "The result? A 3x speedup." State the result.

**"Serves as", "stands as", "represents"** where "is" is meant.

> The cache serves as the source of truth → The cache is the source of truth

**Suspense and teacher transitions.** "Here's the thing", "Here's where it gets
interesting", "Let's break this down", "Think of it as". Delete them; the next
sentence stands on its own.

**A false range.** "from parsing to rendering to export" where nothing sits on a
scale between the ends. List the items, or name the one that matters.

**An invented concept label.** "the staleness trap", "the dangerous shape",
"config creep", used as if the term were established. Describe the thing the
label stands for.

**A signposted summary.** "In summary", "As we've seen", or a closing paragraph
restating each section. A reference page ends when its last fact does.

**Bold-first bullets.** A bold lead on every item of an ordinary list is
decoration. Keep bold for a term being defined, as in a glossary. Don't
overcorrect into no formatting: a list, table or heading belongs wherever the
content has several parallel parts a reader will scan or look up.

**A dead metaphor.** One image repeated through a page ("doors", "walls",
"layers of the onion"). Use it once or not at all.

The [writing whip](https://tropes.fyi/whip) adds these.

**Synonym cycling.** One referent called a track, then a lane, then a layer.
In technical prose the reader assumes three words mean three things. Pick the
noun and repeat it.

**An announcer.** A sentence that names the shape of what follows: "Two
constraints shape the design." Counting belongs to the same
habit: "for two reasons", "three things to know". Write the first constraint.

**Premise stacking.** A paragraph of evidence before the claim it supports. Put
the claim first.

**The tie-back.** A closing sentence that loops back to the question: "So, to
answer the original question: yes." Stop after the answer.

**Documentation as a changelog.** A doc that narrates what changed and when:
"we switched to X after Y broke". A doc describes the current behavior, and the
history goes in commits and release notes.

**Appending a correction.** When a passage is wrong, rewrite or delete it. A new
paragraph that corrects the one above leaves both for the reader to reconcile.

**Appeal to familiarity.** "a classic", "famously", "the well-known" borrow
consensus in place of a citation. Cite it or drop the adjective.

**A comma-clipped tail.** A short phrase hung off a comma to close a sentence
with a beat: "it rebuilds on every keystroke, every time."

The [directory](https://tropes.fyi/directory) also lists these.

**A reasoning leak.** The text narrates its own deliberation: "What that changes
in the design is worth being precise about." In a PR description or a design
doc, write the change.

> what it changes is worth being precise about → The change moves validation
> from the client to the server.

**Belaboring the unnecessary.** Defending a minor point against an objection
nobody raised: "We spell this out rather than changing it silently, because the
failure mode is why it matters." State the point and move on.

**A never-ending conclusion.** A closing sentence that stacks clause after
clause. End on the last fact.

**Self-echo.** A distinctive word from earlier in the page reused as if paying it
off, such as "quietly" in two sections. Write the plain word each time. A
technical term is the exception, and should repeat (see synonym cycling).

**Grandiose stakes.** "This changes how we think about configuration." Say what
the change does, with the number if there is one.

**Title Case Headings.** Capitalize the first word and proper nouns only.

## A rule that breaks its own rule teaches the break

A style rule is read as prose before it is read as a rule, and the prose is the
part that gets imitated. A "no em-dashes" rule written in a sentence containing
one ships the em-dash. Write instruction files in the style they ask for.

## What not to flatten

- The claim. A rewrite that changes what a sentence asserts is worse however
  plain it reads.
- Measurements. Numbers, identifiers, file paths and the names of mechanisms
  are the content. A prose pass moves sentences around them and changes none of
  them.
- Terms the tools use. Renaming a flag or a field in prose leaves the reader
  without the word the manual uses.
- An established idiom. A device an author uses deliberately and consistently
  across a corpus stays, even when one instance of it gets flagged.
- The author's own voice in a README tagline or a personal note.
- The distinctions a design record is about. A record that names the option it
  declined needs both halves.
- Generated prose. Fix the generator; an edit to the output lasts until the
  next build.

## Quick scan

Markers worth grepping for on a file or repo. Read each hit in context.

```sh
grep -rnE ' — | -- |is what |which is what|rather than|, not |not just|instead of' .
grep -rnE 'the (whole )?point|honest|payoff|worth (naming|noting)|exists to' .
grep -rnE '\b(cannot|doesn.t|does not) know|says |silently|quietly|invisibly' .
grep -rnE '^(Nothing|No one|None) |not (the|its|our) job|used to ' .
grep -rniE 'delve|tapestry|testament|showcase|pivotal|vibrant|seamless|flagship' .
grep -rniE 'serves as|here.s (the|where)|let.s (break|dive|unpack)|in summary' .
```
