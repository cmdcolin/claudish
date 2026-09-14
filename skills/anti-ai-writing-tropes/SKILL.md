---
name: anti-ai-writing-tropes
description: Checklist of prose habits that make technical writing read as generated, each with a before/after rewrite. Use when writing or editing docs, READMEs, tutorials, code comments, commit messages, figure captions or agent instruction files (CLAUDE.md), and when asked to review or clean up writing for AI tropes.
---

# Anti-AI writing tropes

Write plain technical English in ordinary declarative sentences. Each habit
below is one that model-written prose falls into, with a pair so the fix is a
shape to copy rather than a matter of taste. The habits compound: one of them
reads as a choice, and a page of them reads as generated, because the sentences
stop connecting and the reader supplies the joins.

## How to use this

- **Writing:** draft normally, then reread against the checklist before
  finishing. Fix the sentence around a trope; don't swap in a synonym for the
  same shape.
- **Reviewing a file or repo:** grep for the markers in
  [Quick scan](#quick-scan) to find hotspots, then read those passages in
  context. A grep hit is a lead, not a verdict: many contrasts and em-dashes are
  fine.
- **Fixing:** keep every fact. A rewrite that drops a number or changes what a
  sentence claims is worse however plain it reads. See
  [What not to flatten](#what-not-to-flatten).
- **Instruction files:** fix `CLAUDE.md`, `AGENTS.md` and similar files first.
  Agents read them every session and copy their prose as house voice, so a
  trope there spreads into every document written afterwards.

## Stance and agency

**A value given knowledge or a stance.** A component may act: the parser
rejects a file, the CLI warns, the server refuses the request. A value, a
column, a file, a figure or a sign is a thing being described, so it knows
nothing, says nothing, disagrees with nothing and earns nothing.

> A layer the alignment cannot know → Pathogenic variants per residue, from
> ClinVar
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

## Sentence shapes

**The cleft: "X is what does Y".** It turns a plain verb into a verdict.

> column-locking is what stacks them → the overlay places domains by column,
> which lines them up
>
> Rounding is what buys the room → Rounding saves two characters per value

**The significance announcement.** "the point", "the whole point", "the honest
answer", "the payoff", "the key insight", "worth naming". Delete the
announcement and state the fact.

> which is the honest answer to the question it was asked → because the model
> predicts whether a substitution breaks the fold, and this one does not

**Dramatic negation.** A sentence whose subject is "nothing", "no one" or
"none", or a "not X's job", reads as a pronouncement. Say what does happen.

> Nothing is prepared for the viewer → The example loads the published URL as
> is.
>
> Producing the file is not the viewer's job → The CLI produces the file.

**Contrastive framing where the positive half says it.** "X, not Y", "rather
than", "instead of", "not just X but Y". Keep one only where the reader needs the
distinction to choose correctly: an option they would otherwise pick, a fault
that resembles another, a design record naming the option it declined.

> so it is tested rather than remembered → so a broken install line fails CI
>
> Staleness is stamped, not compared. → Staleness is stamped.

**A which-ladder.** Each relative clause relabels the one before it.

> a different alignment, which is a new model, which React spells `key` → A new
> input needs a new model, so change the component's `key`.

**Two conclusions stacked on "so".** Split the second into its own sentence; it
is the one the reader loses.

**A mannered inversion or dropped subject.** Fronting the complement, or opening
on "So", "And" or "Hence" that carries the previous sentence's subject.

> Which latency is now known: the lane's own. → The latency is now known, and it
> is the lane's own.

**A fragment standing in for a sentence.** A caption with no verb, or a bullet
with its subject dropped.

> Nine load paths, no unit test that can touch them. → Nine load paths, and no
> unit test can touch them.

**A rule-of-three list doing a sentence's work.** Three parallel fragments with
the verbs dropped.

> A file in, a look applied, ProRes out. → The command reads the file, applies
> the look and writes ProRes 4444.

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

> A marker that does not parse stops the build. → The build fails when a marker
> is misspelled.

**Silently, quietly, invisibly.** An adverb standing in for the mechanism of a
failure. Name what the reader observes, or drop it.

> the same class of wrong, quieter → a highlight on the wrong residue, with no
> error

**The policy refrain.** A project rule ("the viewer computes nothing", "no
external services") restated as the closer of captions and section intros. State
the rule once, in the design doc.

**A thesis paragraph.** An opening that argues for the page's importance, or a
wrong inference named only to refute it. Start at the first observation; stop a
section at the last one.

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

> Where the file goes → Output · What you need before starting → Requirements

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

> reset() used to leave the Cancel button behind → reset() also clears the
> download status

**An essay where a clause would do.** Keep the measurement and the non-obvious
constraint; cut the argument around them. Repeated rationale belongs in one
place with pointers to it.

**ALL-CAPS emphasis.** "the ONLY difference", "DON'T MEASURE". Emphasis is the
sentence's job.

## Register

**Stock sentences.** A caution or framing sentence repeated from page to page
reads as boilerplate by the second page. Say it once and link to it.

**An informalism in a formal register.** The test is the document, not the
word. An intensifier with no number behind it is the same slip in a document
that quantifies everything else: `dramatically simpler`, `greatly reduced`.

**Promotional and vague-attribution words.** `vibrant`, `groundbreaking`,
`boasts`, `flagship`, `crisp`, `seamless`, `robust`; `industry reports`,
`surveys show`; the `delve` / `tapestry` / `testament` / `showcase` / `pivotal`
cluster.

**Present-participle synthesis.** `…, highlighting how the two stages interact`
is a claim with nobody making it. Write the claim as its own sentence or drop
it.

**Small tics.** "reads straight off", "tells a story", "shape" as an all-purpose
noun, "counterpoint", "actually", "genuinely", circular sentences ("an alignment
is an alignment").

## Also in technical prose

[tropes.fyi](https://tropes.fyi) catalogs the tropes of essay and blog prose.
These ones from its list turn up in docs and READMEs too.

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
decoration. Keep bold for a term being defined, as in a glossary.

**A dead metaphor.** One image repeated through a page ("doors", "walls",
"layers of the onion"). Use it once or not at all.

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
- An established idiom. One flagged instance is not licence to sweep a device an
  author uses deliberately and consistently across a corpus.
- The author's own voice in a README tagline or a personal note.
- The distinctions a design record is about. A record that names the option it
  declined needs both halves.
- Generated prose. Fix the generator; an edit to the output lasts until the
  next build.

## Quick scan

Markers worth grepping for on a file or repo. Read each hit in context.

```sh
grep -rnE ' — | -- |is what |which is what|rather than|, not |instead of' .
grep -rnE 'the (whole )?point|honest|payoff|worth (naming|noting)|exists to' .
grep -rnE '\b(cannot|doesn.t|does not) know|says |silently|quietly|invisibly' .
grep -rnE '^(Nothing|No one|None) |not (the|its|our) job|used to ' .
grep -rniE 'delve|tapestry|testament|showcase|pivotal|vibrant|seamless|flagship' .
grep -rniE 'serves as|here.s (the|where)|let.s (break|dive|unpack)|in summary' .
```
