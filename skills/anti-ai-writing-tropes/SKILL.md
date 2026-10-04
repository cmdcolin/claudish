---
name: anti-ai-writing-tropes
description: Checklist of prose habits that make technical writing read as generated, each with a before/after rewrite. Use when writing or editing docs, READMEs, tutorials, code comments, commit messages, PR descriptions, release notes, manuscripts, figure captions, agent instruction files (CLAUDE.md) or an explanation written in a chat, and when asked to review or clean up writing for AI tropes.
allowed-tools: Bash(bash *scan.sh*)
---

# Anti-AI writing tropes

Write plain technical English in ordinary declarative sentences. The checklist
below pairs each habit with a rewrite, so the fix is a pattern to copy.

## How to use this

- Writing: draft normally, then reread against the checklist before finishing.
  Fix the sentence around a trope. A synonym in the same sentence pattern is
  the same trope.
- Reviewing a file or repo: run the `scan.sh` beside this file on the target to
  find hotspots, then read those passages in context. Treat a hit as a lead to
  read; some em-dashes are fine.
- Fixing: keep every fact. A rewrite that drops a number or changes what a
  sentence claims is worse however plain it reads. Reread the diff before
  finishing, looking for a fact the rewrite deleted and a detail it added to
  make a sentence concrete. See [What not to flatten](#what-not-to-flatten).
- Shortening: delete the sentences and clauses that do not serve the page, and
  keep the ones that remain as full sentences. Compressing every sentence into
  a shorter one produces a [staccato run](#sentence-shapes), or a
  [compressed noun phrase](#sentence-shapes).
- Improving a document: start by cutting. A pass that keeps every paragraph and
  fixes each sentence makes the page longer, because the fixes add clauses. Two
  such passes took one docs set from 1,391 to 1,460 lines, and a pass that cut
  took it to 814. Keep the tables, the numbers and the examples a
  reader looks up, and delete the prose that walks through them.
- Rewording a paragraph: rewrite the whole paragraph and reflow it. Splicing a
  clause into the old line breaks keeps the diff small, but it leaves two ideas
  that depend on each other in one sentence without the word that connects
  them. Keep a small edit to a narrow scope, and reflow every line that scope
  touches.

  > The process limit caps the batch size, where the server renders each
  > report in a separate process because each report is an independent job →
  > Each report is an independent job, so the server renders each one in a
  > separate process. The operating system caps the processes per user, so a
  > batch with more reports than that would exceed the cap
- Answering in a chat: apply the same checklist. An explanation of how a
  system works invites the agency tropes, because it narrates what each part
  does: "the cache hands us every request's entry", "an index does that",
  "the cache earns its place". Make a program or a person the subject, and
  describe data with contains, lists or records.
- Reviewing for someone else: report every instance, then triage. A "report
  only the worst" instruction makes a reviewer drop real findings. One line
  per finding: `file:line`, the trope name, the quoted phrase, the rewrite.
  Group the lines by file and put the tropes that recur across the document at
  the top of the report, because one habit fixed at the source clears many
  lines.
- Delegating a review to other agents: name every section of the checklist in
  the brief, with one example each. A brief that leads with one vivid example
  gets back fixes for that pattern alone and "no other issues" for the rest. A
  brief that lists every section still gets back mostly the sections `scan.sh`
  finds (clefts, pronoun openings, "used to"), with Stance and agency nearly
  untouched, so run a second pass for the sections the scan cannot find and
  quote misses from the files as its examples. Read each diff that comes back
  for changed claims before accepting it.
- Instruction files: fix `CLAUDE.md`, `AGENTS.md` and similar files first,
  because agents copy their prose into everything they write. Write each style
  rule in the style it asks for, and include the rewrite along with the ban: a
  model copies a positive example more reliably than it obeys a prohibition.

## Contrastive framing

Contrastive framing is the strictest rule in the checklist. State what a thing
is or does. Leave out what it is not, what it replaces, and what someone might
have assumed.

The pattern defines a thing against an alternative the reader never raised.
Its forms:

- "X, not Y": "Each cache entry is stamped with an expiry time, not compared."
- a negative half written as a question-word clause: "records what the build
  contains, not who requested it"
- "rather than" and "instead of": "so it is tested rather than remembered"
- "not just X but Y" and "X doesn't just Y, it Z"
- "not because X but because Y"
- a negation followed by the real claim: "It's not a cache. It's a log." and
  "The question isn't speed. The question is correctness."
- "Not X. Not Y. Just Z."
- "is not X's job" or "is not the point" before saying what is
- a bare negative sentence: "A record from a shard does not store its sample
  name."
- "only" limiting a verb against a complement nobody raised: "The exporter
  names only the primary sample"
- a heading that says what a thing is not: "What this is not"

The default fix is to delete the negative half. The sentence almost always
still says everything.

> Each cache entry is stamped with an expiry time, not compared against the
> source. → Each cache entry is stamped with an expiry time.
>
> CI runs the install command from the README, so it is tested rather than
> remembered. → CI runs the install command from the README, so the command is
> tested.
>
> The overlay is drawn once instead of per page. → The overlay is drawn once.
>
> It's not a cache. It's a log. → It is a log.
>
> The CLI doesn't just fetch the page, it caches it. → The CLI fetches the page
> and caches it.

A bare negative sentence has no positive half to keep. Write the fact the
negative points at, which is usually where the missing thing comes from, or
delete the sentence. State a limitation as what the thing does accept.

> A record from a shard does not store its sample name. The sample table adds
> the names. → Sample names come from the sample table.
>
> The `fetch` and `count` functions do not accept a region on a sample. A
> region is a range on the reference path. → A region in `fetch` and `count` is
> a range on the reference path.

"Only" makes the same move inside one word. "X reads only the header" asserts
the header and denies everything else, and the reader is left to supply what
else there was. State what happens to each case the reader cares about, or drop
"only" when the complement does not matter.

> The exporter names only the primary sample and labels every other sample
> `unknown#N`. → The exporter labels each sample other than the primary one
> `unknown#N`.
>
> The importer reads the headers, then loads only the selected files. → The
> importer reads the headers, then loads the selected files.

Keep "only" where the restriction is the fact: "the pager reads only the 64 KiB
blocks a query touches" answers a question about bandwidth the reader has.

The test: would a reader who never saw the negative half make a wrong choice or
hold a wrong belief? If not, delete it. The test passes only in three cases:

- An option the reader would otherwise pick. "Use `--force-with-lease`, not
  `--force`" names the flag people type by mistake.
- A choice whose alternative gives a different result. "Median, not mean"
  matters when outliers make the two differ.
- A design record naming the option it declined, which is the record's
  purpose.

Apply these exceptions one sentence at a time. A page that records a decision,
or an API reference, still contains contrasts written for rhythm, and an auditor
who exempts the whole page keeps them all.

API documentation hits the second case constantly, because the negative half
often names the one behavior that separates two functions. "The strict runner
propagates a throw to the caller instead of logging it" is the whole difference
between the strict and the plain runner, so deleting "instead of logging it"
deletes the fact. Rewrite it as two positive statements, one per function, or
keep it.

Even then, a plain sentence usually states the distinction better than the
"X, not Y" pattern: "Latency is the median, because the mean is skewed
by timeouts." A contrast written for rhythm or emphasis never
passes the test.

Two shapes get the plain rewrite even when the fact survives the test. One is
the question-word clause — "not who has what", "not where it came from" —
which is an aphorism whatever it records. The other is two contrasts stacked in
one sentence. Give the absence its own sentence and say what is missing:

> The manifest records what the build contains, not who requested it, because
> the `owner` field is the build host and not the user. → The manifest records
> what the build contains. Who requested the build is not in it, because the
> `owner` field is the build host, not the user.

## Stance and agency

**A value given knowledge or a stance.** A component may act: the parser
rejects a file, the CLI warns. A value, a column, a file or a figure knows
nothing, says nothing and earns nothing. The test: could the subject perform
the verb if you ran the program? When it could not, name the actor that does
the thing, or use a verb of description (marks, contains, shows, is).

> The lockfile knows which versions to install. → The lockfile lists the
> versions to install.
>
> The log remembers every request. → The log contains every request.
>
> The boxes say which files changed; the arcs say how they depend on each
> other → The boxes mark the changed files, and the arcs mark dependencies
> between files.
>
> the cache sees the first request → the cache stores the first request
>
> signs that disagree → one end marked `+` and the other `-`

**"Carry" for having or holding.** A sequence, a file, a record or a config
has, contains, lists or holds. "Carry" describes that relation as an action, and
"carriage" names it as a quantity. Say the relation, and name a count by what it
counts: "samples with the inversion", not "the inversion's carriers". A carrier
of a recessive allele, a person or an animal heterozygous for it, is the
clinical sense, and stays.

> each haplotype that carries the allele → each haplotype with the allele
>
> the config carries the track → the config holds the track
>
> a lane colored by carriage → a lane colored by how many haplotypes have each
> segment
>
> the sort collects the inversion's carriers into a block → the sort collects
> the samples with the inversion into a block

The replacement is a verb of description, not another action. Swapping "carry"
for "names", "shows", "takes", "keeps", "sends" or "stores" leaves the same
inanimate actor. Where a verb of description does not fit, make the component
or the person that acts the subject.

> CD8A is carried by the CD8 rows → CD8A shows in the CD8 rows (still an actor)
> → the CD8 rows have signal at CD8A
>
> every record carries the result as its `svType` field → every record stores
> the result (still an actor) → each record's `svType` field holds the result
>
> the allele rose and carried its neighbours with it → the allele rose and took
> its neighbours with it (still an actor) → the allele rose in frequency, and
> its neighbouring variants rose with it

In the idioms, "carries on" is "continues", and "carries over" is "stays" or
"applies".

**An artifact given a purpose or a will.** "the choice it exists to offer",
"the failure this layer exists to avoid", "the tree cannot resolve them".

> which is the tree saying it cannot resolve them → the support values are too
> low to resolve them

**An inanimate subject given ownership.** "its own", "their own", "the
haplotype's walk", "the track's genes". A lane, a file or a column owns
nothing, and "own" adds a claim of possession the reader has to discount.
Name the relation the possessive stands for: which input the thing came from,
what it is annotated on, how many there are per what. "its own X" nearly
always means one X per Y.

> each tab renders its own settings → each tab renders the settings stored for
> that tab
>
> each lane draws its own cluster genes → each lane draws the cluster genes
> annotated in that genome
>
> each haplotype on its own contig with its own gene models → one contig per
> haplotype, with the gene models annotated on that contig
>
> each haplotype takes its own row → the display draws each haplotype in a
> separate row

A possessive that states a literal relation ("each library bundles its own
copy", "a module addresses only its own linear memory") is fine; the tell is
"own" beside a verb of action on a drawn or displayed thing.

**A technical term given a personality.** Keep the term the tools use and fix
the sentence around it.

> `useEffect` is eager to re-run → `useEffect` re-runs whenever a dependency
> changes

**A figure of speech where a literal word exists.** For each verb or noun that
is not literally true of its subject, ask what literal word it stands for, and
write that word. Keep a figure only when no literal phrase exists or the field
has adopted it as a term ("memory leak", "race condition"), and use it once: an
image repeated through a page ("doors", "walls") is a dead metaphor.

> each bar rises to the height its frequency earns → each bar's height is
> proportional to its frequency

| Figure | Literal |
|---|---|
| earns its keep, earns its place | is needed, is used |
| buys (room, time, safety) | saves, gives, allows |
| for free, costs nothing | with no extra code, adds no request, takes no time |
| stands between X and Y | prevents X from becoming Y |
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

**The passive voice hiding the actor.** "The field is left unset", "the
constant is exported", "it was measured and rejected". Use the active voice
where you know the actor, and name it. Keep an idiomatic passive ("is
required", "is deprecated") and a passive whose actor does not matter. Keep the
passive, too, when you do not know the actor: "the service keys requests" or "a
cleanup step collapses the calls" invents a component the reader will look
for.

> The field is left unset → The parser leaves the field unset
>
> It was measured and rejected → We measured it and rejected it
>
> The arena sizes itself up front → The record pass sizes the arena up front
> (invents a component the reader will look for) → The arena is sized up front

## Sentence shapes

**The cleft: "X is what does Y".** It turns a plain verb into a verdict.

> column-locking is what stacks them → the overlay places domains by column,
> which lines them up
>
> Rounding is what buys the room → Rounding shrinks the file

Deleting "is what" alone leaves the verb on the old subject, so check that verb
against [Stance and agency](#stance-and-agency).

> What each accessor costs is what says which are worth tuning → What each
> accessor costs says which are worth tuning (still a cost that speaks) → The
> cost of each accessor on first access shows which are worth tuning

**The significance announcement.** "the point", "the whole point", "the honest
answer", "the payoff", "the key insight", "worth naming". Delete the
announcement and state the fact.

> The linter checks only syntax, and the syntax is valid. It accepts the file,
> which is the honest answer to the question it was asked. → The linter checks
> only syntax, and the syntax is valid, so it accepts the file.
>
> The key insight is that the index is sorted, which lets lookups use binary
> search. → The index is sorted, so lookups can use binary search.

**The floating fact.** A sentence states something true about a thing and
draws no consequence, so the reader has to guess why it is there. The commonest
form glues two facts with "and", one about where the thing came from and one
about what it does, and the first explains nothing about the second.

> The tool was created for lightweight deployments and redraws every item to a
> canvas after a zoom. → The tool redraws every item to a canvas after a zoom,
> so its redraw time grows with the number of items in view.

Drop the fact that does no work, and end the sentence on the consequence. A
fact the compared thing shares (both tools are lightweight) explains no
difference between them, so it goes first.

When the cause is the writer's own work, name it with "we" and "because". A
generality in its place reads as evasion, not care.

> The margin is widest at high coverage, where that work is largest. → The
> margin is widest at high coverage, because we put our optimization work into
> the parsers, and more reads mean more parsing.

**Narrated deliberation.** The text describes its own thinking ("What that
changes in the design is worth being precise about") or defends a minor point
against an objection nobody raised ("We spell this out rather than changing it
silently, because the failure mode is why it matters"). Write the change or the
point, and move on.

> what it changes is worth being precise about → The change moves validation
> from the client to the server.

**The self-answered question.** "The result? A 3x speedup." State the result.

**Dramatic negation.** A sentence whose subject is "nothing", "no one" or
"none", or a "not X's job", reads as a pronouncement. Say what does happen.

> Nothing is prepared for the viewer → The example loads the published URL as
> is.
>
> Producing the file is not the viewer's job → The CLI produces the file.

**A which-ladder.** Each relative clause relabels the one before it.

> a different file, which is a new model, which React spells `key` → A new file
> needs a new model, so change the component's `key`.

**Two conclusions stacked on "so".** Split the second into its own sentence; it
is the one the reader loses.

> The key includes the path, so a rename misses the cache, so the first load
> after a rename is slow. → The key includes the path, so a rename misses the
> cache. The first load after a rename is therefore slow.

**A mannered inversion or dropped subject.** Fronting the complement, or opening
on "So", "And" or "Hence" that leaves the subject to the previous sentence.

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

> A file in, a filter applied, a PNG out. → The command reads the file, applies
> the filter and writes a PNG.

**Staccato, or telegraphic, sentences.** A run of short sentences, each
complete, where the facts depend on each other. Every full stop drops the
"so", "and" or "because" that says how one fact leads to the next, and the
reader has to put it back. Join sentences that share a subject or where one
causes the next. Keep a short sentence for a single step or a fact that stands
alone.

> The parser reads the header. It checks the version. It rejects old files. →
> The parser reads the version from the header and rejects old files.
>
> The key includes the path. A rename changes the key. The cache misses. → The
> key includes the path, so a rename changes the key and misses the cache.

**A false range.** "from parsing to rendering to export" where nothing sits on a
scale between the ends. List the items, or name the one that matters.

**A colon lead-in.** A generalizing clause, a colon, then the facts it
summarizes. The reader has to match the abstract half against the concrete
half. Delete the lead-in and start on the facts. A colon that introduces a list
or an example ("four sets of measurements: ...") is fine; the tell is a
generalization first, specifics second.

> Each cache invalidates where a stale read costs most: the session cache
> invalidates on logout → The session cache invalidates on logout

**A comma-hung appositive.** A noun phrase, a comma, then "one that" or "a
design that" restating the subject before the sentence goes on. The comma
does a semicolon's work and the reader has to hold the first half open across
it. Fold the appositive into a relative clause on the noun, or split the
sentence.

> Version 2 is an editor without that limit, one that opens files in tabs →
> Version 2 is an editor that removes that limit by opening files in tabs
>
> Version 1 opens one file, a design that cannot compare two → Version 1 opens
> one file, so it cannot compare two

**A fronted "So that" clause.** "So that X happens, we did Y" puts the result
before the actor and reads as translated. Open on "To" with the goal, or put
the purpose after the main clause.

> So that the page loads faster, we added an index → To make the page load
> faster, we added an index

**A comma-clipped tail.** A short phrase hung off a comma to close a sentence
with a beat: "it rebuilds on every keystroke, every time."

**A compressed noun phrase.** A noun phrase that packs a clause into its
modifiers. An option or a verb becomes an adjective ("a dirty half", "the named
half of each record", "private bytes"), or a chain of prepositions stands in for a
subject and a verb ("a page with no entry at the root", "companion reads
against cache lookups"). The writer coins the shorthand while reading the
code, and the reader has to expand it back into the sentence it came from. The
test: could a reader who has not seen the code expand the phrase? If not, write
the sentence, or delete it when the page can do without it.

> The flush writes the dirty half of each page. → The flush writes the half of
> each page that has unsaved changes.
>
> The reader then trims to the kept set. → The reader then removes the rows the
> filter rejects.
>
> `maxSkip` caps the cold bytes a read skips → `maxSkip` caps the bytes a read
> skips in blocks that no other read touches

A term the page defines, or a name from the API in code font such as `keep`, is
fine. See also [An invented concept label](#register).

**Density.** Long sentences packed with qualifications, and paragraphs that run
for a screen without a break. Fixing the tropes above adds clauses, so after a
pass split a sentence that states unrelated facts and break the paragraph
where the subject changes. Keep facts that depend on each other in one sentence,
or the split produces a staccato run.

**Em-dash asides.** One in a paragraph is punctuation; three is a writer avoiding
sentence boundaries. A ` -- ` in a code comment is the same habit. Promote one
aside to a sentence, demote another to a comma, and keep a dash only around a
parenthetical remark.

## Openings and closings

**An aphorism closing (or opening) a section.** A short balanced sentence that
sounds like a conclusion and states no fact.

> The rate limit counts retries. A retry is still a request. → The rate limit
> counts retries as requests.
>
> The snapshot is the API. Every field below is a property of the model. →
> Every field below is a property of the model.

**A conclusion standing in for the mechanism.** A sentence naming the outcome
(the build stops, the link breaks) where the sentence saying how it happens
belongs. Write what the machine does and name the actor.

> A marker that does not parse stops the build. → The generator exits with an
> error on a marker it cannot parse, so the build fails.

**Silently, quietly, invisibly.** An adverb standing in for the mechanism of a
failure. Name what the reader observes, or drop it.

> The second bug silently writes the wrong value. → The second bug writes the
> wrong value and raises no error.

**A refrain.** A project rule ("the viewer computes nothing", "no external
services") restated as the closer of captions and section intros, or a caution
repeated from page to page. By the second appearance it reads as boilerplate.
State it once, in the design doc, and link to it.

**An announcer.** A sentence that promises content instead of giving it:
"Here's the thing", "Here's where it gets interesting", "Let's break this
down", "Think of it as". Delete the announcer and start on the sentence after
it. A preview that names its parts in the same sentence is fine:
"The design has two constraints: it must run offline and fit under 50MB."

**The claim after its evidence.** A paragraph of premises before the claim they
support, an opening that argues for the page's importance, or a wrong inference
named only to refute it. Put the claim first. Start at the first observation;
stop a section at the last one.

**A term used before its definition.** An opening sentence mentions a feature
in passing ("stores each record at two resolutions") and a later paragraph,
after an unrelated one, defines it. The reader crosses the gap with the term
undefined. Introduce the feature in the paragraph that defines it, or move the
two paragraphs together.

**A closing that restates.** "In summary", "As we've seen", a paragraph
restating each section, a tie-back to the opening question ("So, to answer the
original question: yes"), or a last sentence that stacks clause after clause.
A reference page ends when its last fact does.

**Padding.** A document longer than its substance: an overview that repeats the
headings, a summary per section, a boilerplate "Future work". Match the length
to the facts. A report or a PR description leads with the outcome, what changed
or what was found, and puts supporting detail after it.

**A pronoun opening a paragraph.** A reader arriving by search hit or deep link
has no antecedent for "It", "This", "That" or "that limit". Name the subject,
even when the previous paragraph named it.

> It runs the same engine as the app. → The renderer runs the same engine as the
> app.
>
> That limit is why we wrote a second parser. (after a paragraph on the 2 GB
> file limit) → The 2 GB file limit is why we wrote a second parser.

**A count standing in for its nouns.** "Both", "neither", "either", "the two"
or "all three" as a subject, where the text never named the things it counts
as nouns side by side. The writer knows which two things they mean. The reader
finds only steps to follow, a figure or a paragraph further back, and often
more than one pair that could fit. The test: point to the two noun phrases
"both" replaces in the sentence before it. If you cannot, write the nouns.

> In the web app, click **Share** and copy the JSON. In the desktop app, save
> the session to a file. *(video)* Both hold the same JSON. → The JSON from the
> Share dialog and the saved session file contain the same session.

"Linux and macOS ship `tar`. Both accept `-z`." is fine, because the count
directly follows the sentence that names the pair.

"The same X" opening a paragraph has the same fault. It compares against a
first X the reader has to find, and a heading or a code block between the two
hides it.

> The same track feeds the graph view. → The `coverage` track also feeds the
> graph view.

## Paragraph transitions

A paragraph that introduces a design or a project names the problem with the
prior state in one sentence and gives the response in the next. Each shape below
leaves the reader to work out where the problem ends and the response begins.

**A description where a limitation belongs.** The paragraph states what the
old tool does and then what the new one does, and leaves the reader to work out
that the first was a problem. Say it is a limitation.

The pattern: *A is limited to X. B removes that limit by doing Y, so it can
Z.*

> Version 1 opens one file at a time. Version 2 opens several, in tabs →
> Version 1 is limited to one open file at a time. Version 2 removes that limit
> by opening several files in tabs

**A narrative bridge with nothing behind it.** A sentence about how the field
moved ("teams have since shifted to monorepos", "that design fit its era")
written to motivate the turn, with no citation and no measurement. It is a
claim, and the reader will test it. Cut it, and state the limitation instead.

> Build tools have since moved toward incremental compilation. Our build
> recompiled every file on each change. We added a dependency graph, so it now
> recompiles only the files a change affects. → Our build recompiled every
> file on each change. We added a dependency graph, so it now recompiles only
> the files a change affects.

**A problem sized to the solution.** The limitation is stated in exactly the
terms of the new tool's headline features, so the paragraph reads as
back-formed. State the general limitation; the features follow from it in the
next sentence.

> Version 1 cannot show a diff between two files. Version 2 opens files in tabs
> and shows diffs → Version 1 is limited to one open file at a time. Version 2
> opens files in tabs, so it shows diffs

**The old tool as the subject.** A paragraph introducing a new format or tool
spends its opening sentences on what the old one fails to do, so the old tool
becomes the topic. Keep the limitation to a clause or fold it into the goal,
name the new thing in the first sentence, and mention the old format where it
enters the mechanism, such as the file the new one is converted from.

> A viewer that reads a log file downloads the whole file to show any line
> range. We created a chunked format, which `make-chunks` generates from a log
> file. → To limit the data transferred to the line range in view, we created a
> chunked format, which `make-chunks` generates from a log file.

**A colon or a comma doing the turn.** "That adoption came with a fixed frame:
version 1 opens ..." and "an editor without that limit, one that opens ..."
both make the reader stop mid-sentence to reattach the halves. See
[A colon lead-in](#sentence-shapes) and
[A comma-hung appositive](#sentence-shapes). Two plain sentences, problem then
response, read faster than one joined sentence.

> Version 2 is an editor without that limit, one that opens files in tabs →
> Version 2 is an editor that removes that limit by opening files in tabs

A turn that opens on "that limit" or "this approach" only works for a reader
who has the previous paragraph in mind. See [A pronoun opening a
paragraph](#openings-and-closings).

**The spliced insertion.** A clause or sentence pushed into an existing
paragraph to keep the change small. The host paragraph's sentences were written
to follow one another, and the insertion breaks that: a new subject arrives
with no backward link, a three-item list gains an example on two items and not
the third, a citation lands on the second mention of a name instead of the
first. Moving a sentence verbatim does the same, and keeps every defect the
sentence already had. When a paragraph needs a change, rewrite it as a unit,
then read the rules against the whole.

> There is a need to visualize cohorts such as Project A [1], comparisons, and
> graphs such as Graph B [2]. Tool C draws a cohort of hundreds of samples [3].
> Unfortunately, our earlier design ... → Researchers now need to inspect a
> whole cohort or a set of genomes at once, such as Project A [1] or Graph B
> [2]. Tool C draws such a cohort on the GPU from a specification [3], and its
> authors set it apart from track-based browsers such as ours. Our earlier
> design ...

## Headings and labels

**A teaser heading.** A heading or title that withholds its subject to create
interest. Name the subject.

> The one setting nobody else has → Offline mode

**A phrase where a noun would do.** Keep a phrase only where the section answers
a question the reader asks in those words, such as an FAQ entry or a `Why ...`
section.

> Where the file goes → Output
>
> What you need before starting → Requirements

**A heading that gives its subject agency.** Readers scan the headings before
the text, so name what the section contains.

> What a database answers → Contents and limitations

**A heading that says what a thing is not.** A scanning reader gets nothing from
a negative, unless the distinction is the whole finding of the section.

> What it does not do → Limitations

**Title Case Headings.** Capitalize the first word and proper nouns only.

**Cute naming in a reference table.** A flag table or column header is read by
someone looking one thing up.

> `--seed=<n>` | the dice → `--seed=<n>` | random seed

**Bold-first bullets.** A bold lead on every item of an ordinary list is
decoration. Keep bold for a term being defined, as in a glossary. Keep a list,
table or heading wherever the content has several parallel parts a reader will
scan or look up.

## Comments and history

**Bug history in a comment.** "used to", "the previous version", "found while
debugging" describe how the code got here, and that belongs in the commit
message. The comment states the constraint the code satisfies, with the
measurement if there is one.

> reset() used to leave the Cancel button showing → reset() also hides the
> Cancel button

**Documentation as a changelog.** The same habit at page scale: "we switched to
X after Y broke". A doc describes the current behavior, and the history goes in
commits and release notes. When a passage is wrong, rewrite or delete it; a new
paragraph that corrects the one above leaves both for the reader to reconcile.
Replace the history with the current fact, and keep the claim it made.

> a lot of machinery for what used to be a `for` loop → a lot of machinery for
> what a `for` loop could do instead (now claims the loop would work) → the
> largest piece of machinery in the library, in place of a sequential `for` loop

**An essay where a clause would do.** Keep the measurement and the non-obvious
constraint; cut the argument around them. Repeated rationale belongs in one
place with pointers to it.

> // We considered leaving the keys in fetch order, but the diff output has to
> // be stable across runs and fetch order is not, so we sort them first. →
> // Sort the keys so the diff output is stable across runs.

**ALL-CAPS emphasis.** "the ONLY difference", "DON'T MEASURE". Put the emphasis
in the wording, and write the words in lowercase.

## Register

**An informalism in a formal register.** Judge a word by the document it
appears in. A plain unqualified comparative ("faster", "much smaller") is fine
as it stands, because a made-up or overly precise number reads worse than the
word it replaces.

**A precise number the reader cannot check.** "130,510 rows", "ranked 50th
of 9,444", "an index of 37,545 bytes against the old one's 20,622". A reader has
no way to verify a count like that, so its precision claims an authority the
page cannot back, and it goes out of date the next time the data or the code
changes, with nothing to flag it. Say which way the result went and let a
figure, a table or a script the page points at show how far. A round magnitude
("about a thousand"), a coordinate, an identifier and a published size name
something and stay.

> The new index is 37,545 bytes against the old one's 20,622 → The new index is
> nearly twice the size of the old one

**A goal with no quantity.** "To optimize rendering", "to improve
performance" and "to help with scale" name a direction but not what changes.
Name the quantity the design lowers or raises: bytes transferred, time to
first draw, memory per track.

> To optimize the rendering of alignments, we created an indexed format → To
> limit the data transferred when drawing alignments to the region in view, we
> created an indexed format

**A code-internal verb in prose.** A verb taken from the program's vocabulary
or from a metaphor the authors use among themselves: a loader "hydrates" a
record, a router "resolves" a path, a query "names" a column. Readers outside the codebase do
not say these, and the sentence reads as translated. Use the verb a user of the
tool would say, such as identify, label, look up or fill in, and keep the
internal word in code font where it is an identifier.

> The loader hydrates each record from the cache or the database. → The loader
> fills in each record from the cache or the database.
>
> The router resolves a path to a handler. → The router looks up a handler for
> a path.

**An undefined abbreviation.** A format or tool name ("WAL", "BGZF") at its
first use with no expansion or gloss. Gloss it at the first use in the
document, where a reader who does not know it will stop.

> The output is a WAL file → The output is a WAL file, the write-ahead log the
> database appends each change to

**The pitch register.** A sentence that sells the thing's capability or
standing where a description of what it does belongs. It uses plain vocabulary,
so the promotional word list below misses it, and the tell is a claim the
reader cannot check. Its forms:

- A capability boast: "does more than draw", "goes beyond rendering", "is not
  limited to alignments".
- An unquantified superlative: "the most modern GPU API", "state of the art",
  "industry-leading".
- A future-potential teaser: "they could do much more", "the possibilities are
  broad".
- A novelty or priority claim: "an early use of compute shaders in a map
  viewer", "the first tool to index CSV".

Write what the thing does. A superlative needs the measurement that ranks it,
and a priority claim needs the citation it comes before.

> The library is the most modern JSON toolkit, and it does more than parse: it
> validates against a schema, and it could do much more. → The library parses
> JSON and validates it against a schema.

**Promotional words and grandiose stakes.** `vibrant`, `groundbreaking`,
`boasts`, `flagship`, `crisp`, `seamless`, `robust`; the `delve` / `tapestry` /
`testament` / `showcase` / `pivotal` cluster; "This changes how we think about
configuration." Say what the thing does.

**Borrowed authority.** `industry reports`, `surveys show`, "a classic",
"famously", "the well-known". Cite it or drop the adjective.

**A sentence adverb as the transition.** "Additionally", "Furthermore",
"Moreover", "Notably", "Importantly", "Ultimately", "Overall" at the head of a
sentence. Each says the sentence relates to the last one without saying how.
Delete it, or write the relation as a clause.

> Additionally, the server clears the cache on restart. → The server clears
> the cache on restart.
>
> Ultimately, the index is the bottleneck. → The index is the bottleneck.

**The verb cluster.** `leverage`, `utilize`, `streamline`, `empower`, `unlock`,
`ensure`, `enable` where a plain verb exists: use, simplify, let, check, make.
The same for the filler adjectives `comprehensive`, `crucial`, `essential`,
`key` and the quantifiers "a variety of", "a range of". Use the plain verb and
drop the filler; don't add a count or a list the original didn't have.

> The tool leverages a comprehensive set of heuristics to ensure correctness.
> → The tool uses a set of heuristics to check correctness.

**Present-participle synthesis.** `…, highlighting how the two stages interact`
is a claim with nobody making it. Write the claim as its own sentence or drop
it.

> Scores drop after the tokenizer change because the tagger was trained on the
> old token boundaries, highlighting how the two stages interact. → Scores drop
> after the tokenizer change because the tagger was trained on the old token
> boundaries.

**An invented concept label.** "the staleness trap", "the dangerous shape",
"config creep", used as if the term were established. Describe the thing the
label stands for.

**Synonym cycling.** One referent called a track, then a lane, then a layer.
The reader assumes three words mean three things. Pick the noun and repeat it.

**Self-echo.** A distinctive word from earlier in the page reused as if paying it
off, such as "quietly" in two sections. Write the plain word each time. A
technical term is the exception, and should repeat (see synonym cycling).

**Small tics.** "serves as", "stands as", "represents" where "is" is meant;
"reads straight off", "tells a story", "shape" as an all-purpose noun,
"counterpoint", "actually", "genuinely", circular sentences ("an alignment is
an alignment").

> The cache serves as the source of truth → The cache is the source of truth

## What not to flatten

- The claim. A rewrite that changes what a sentence asserts is worse however
  plain it reads.
- Measurements. Numbers, identifiers, file paths and the names of mechanisms
  are the content. A prose pass moves sentences around them and changes none of
  them, except a precise number the reader cannot check, which is a trope of its
  own under [Register](#register). A rewrite can also add precision the original
  never claimed: "the absolute heights survive the trip" is not "the absolute
  heights round-trip exactly".
- The mechanism. A rewrite that adds "in the same way as tool X", "each record
  consists of" or "collapses into a single run" makes a new claim, and the
  spec may contradict it. Check the sentence against the spec or the code, or
  cut it.
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

`scan.sh` beside this file greps the Markdown, LaTeX, reStructuredText and
plain-text files under a path for the markers above, and labels each hit by the
section its marker comes from: `contrast`, `shape`, `agency`, `colon`,
`apposition`, `opening`, `passive`, `history`, `register`, `pitch`, `claim`,
`number`, `float`, `coldstart` and `staccato`. Read each hit in context. The `float` label marks an origin statement ("was created for") or a "where that work is largest" generality, the two common forms of a floating fact. The `claim` label marks a
comparison to another tool ("in the same way", "similar to"), which needs
checking against that tool's documentation. The `pitch` label marks a capability
boast, a superlative, a potential teaser or a priority claim; a superlative that
reports a measurement is fine. The `number` label marks a number grouped in thousands or with two or more decimal places; a coordinate after a colon or a dash, a version and a DOI do
not fire it. The
`coldstart` label marks a paragraph whose
first line opens on a pronoun, a demonstrative, a count such as "Both" or "The
two", or a sentence-initial "So"/"And"/"Hence". The `staccato` label marks a
paragraph or bullet with three sentences in a row of six words or fewer. The
`history` label's ALL-CAPS check matches common emphasis words such as NOT, ONLY
and SAME, so an acronym such as BGZF or CIGAR does not fire it. The `colon` and
`apposition` labels mark the two sentence shapes that split a sentence at its
punctuation. A paragraph that follows a list and opens on "These" is usually
fine.

```sh
# installed as a plugin
bash "$CLAUDE_PLUGIN_ROOT"/skills/anti-ai-writing-tropes/scan.sh docs/
# copied into ~/.claude/skills
bash ~/.claude/skills/anti-ai-writing-tropes/scan.sh docs/
```

`test/run.sh` checks the patterns against a fixture after an edit.
