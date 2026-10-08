---
name: anti-ai-writing-tropes
description: Checklist of prose habits that make technical writing read as generated, each with a before/after rewrite. Use when writing or editing docs, READMEs, tutorials, code comments, commit messages, PR descriptions, release notes, manuscripts, figure captions, agent instruction files (CLAUDE.md) or an explanation written in a chat, and when asked to review or clean up writing for AI tropes.
allowed-tools: Bash(bash *scan.sh*)
---

# Anti-AI writing tropes

Write plain technical English in ordinary declarative sentences. Each entry
below pairs a habit with a rewrite, so the fix is a pattern to copy. The text
before each arrow is the habit, and the text after it is the sentence to write.

## Workflow

- Writing: draft normally, then reread against the checklist. Rewrite the
  whole sentence around a trope, because a synonym in the same sentence pattern
  is the same trope.
- Reviewing a file or repo: run the `scan.sh` beside this file on the target,
  then read each hit in context. A hit is a lead, and some em-dashes are fine.
- Fixing: keep every fact, number and claim. Reread the diff for a fact the
  rewrite deleted and for a detail it added to make a sentence concrete. See
  [Preserve](#preserve).
- Shortening: delete the sentences and clauses the page can do without, and
  keep the rest as full sentences. Compressing every sentence yields a
  [staccato run](#sentence-shapes) or a
  [compressed noun phrase](#sentence-shapes).
- Improving a document: start by cutting. Two passes that kept every paragraph
  and fixed each sentence grew a docs set from 1,391 to 1,460 lines, and a pass
  that cut brought it to 814. Keep the tables, numbers and examples a reader
  looks up, and delete the prose that walks through them.
- Rewording a paragraph: rewrite the whole paragraph and reflow it. A clause
  spliced into the old line leaves two dependent ideas in one sentence with no
  word to connect them.

  > The process limit caps the batch size, where the server renders each
  > report in a separate process because each report is an independent job →
  > Each report is an independent job, so the server renders each one in a
  > separate process. The operating system caps the processes per user, so a
  > batch with more reports than that would exceed the cap

- Answering in a chat: apply the same checklist. An explanation of a system
  invites agency tropes ("the cache hands us every request's entry", "the cache
  earns its place"). Make a program or a person the subject, and describe data
  with contains, lists or records.
- Reviewing for someone else: report every instance, then triage. Write one
  line per finding: `file:line`, the trope name, the quoted phrase, the
  rewrite. Group lines by file and put the tropes that recur across the
  document at the top, because one habit fixed at the source clears many lines.
- Delegating a review: name every section of this checklist in the brief with
  one example each. Agents mostly return the sections `scan.sh` finds (clefts,
  pronoun openings, "used to"), so run a second pass for the sections the scan
  cannot find, such as Stance and agency, and quote misses from the files as
  its examples. Read each returned diff for changed claims before accepting it.
- Instruction files: fix `CLAUDE.md`, `AGENTS.md` and similar files first,
  because agents copy their prose into everything they write. Write each style
  rule in the style it asks for, and pair it with the rewrite to copy: a model
  follows a positive example more reliably than a prohibition.

## State what a thing is or does

Describe a thing by what it is and does. The positive half of a sentence
usually carries the whole fact, so delete the clause that defines the thing
against an alternative the reader never raised.

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
> The question isn't speed. The question is correctness. → The question is
> correctness.
>
> The CLI doesn't just fetch the page, it caches it. → The CLI fetches the page
> and caches it.
>
> Not X. Not Y. Just Z. → Z.

The same fix covers "not because X but because Y", "is not X's job", "is not
the point" and a negative question-word clause ("records what the build
contains, not who requested it").

**A bare negative sentence.** Write the fact the negative points at, which is
usually where the missing thing comes from, or delete the sentence. State a
limitation as what the thing accepts.

> A record from a shard does not store its sample name. The sample table adds
> the names. → Sample names come from the sample table.
>
> The `fetch` and `count` functions do not accept a region on a sample. A
> region is a range on the reference path. → A region in `fetch` and `count` is
> a range on the reference path.

**"Only" against a complement nobody raised.** "X reads only the header"
leaves the reader to supply what else there was. State what happens to each case
the reader cares about, or drop "only".

> The exporter names only the primary sample and labels every other sample
> `unknown#N`. → The exporter labels each sample other than the primary one
> `unknown#N`.
>
> The importer reads the headers, then loads only the selected files. → The
> importer reads the headers, then loads the selected files.

Keep "only" where the restriction is the fact: "the pager reads only the 64 KiB
blocks a query touches" answers a bandwidth question the reader has.

**When a contrast stays.** Keep the negative half when a reader who never saw
it would make a wrong choice or hold a wrong belief:

- An option the reader would otherwise pick: "Use `--force-with-lease`, not
  `--force`" names the flag people type by mistake.
- A choice whose alternative gives a different result: "Median, not mean"
  matters when outliers make the two differ.
- A design record naming the option it declined, which is the record's
  purpose.

Judge one sentence at a time, because a decision record or an API reference
still contains contrasts written for rhythm. API documentation often holds the
one behavior that separates two functions in the negative half: "The strict
runner propagates a throw to the caller instead of logging it" is the whole
difference between the strict and the plain runner. Keep that sentence, or
write one positive statement per function. A plain sentence usually states a
kept contrast better: "Latency is the median, because the mean is skewed by
timeouts."

Two shapes get the plain rewrite even when the fact passes the test: the
question-word clause ("not who has what", "not where it came from") and two
contrasts stacked in one sentence. Give the absence its own sentence and say
what is missing.

> The manifest records what the build contains, not who requested it, because
> the `owner` field is the build host and not the user. → The manifest records
> what the build contains. Who requested the build is absent, because the
> `owner` field holds the build host.

## Stance and agency

**Give an action to something that can perform it.** A component acts: the
parser rejects a file, the CLI warns. A value, column, file or figure has no
knowledge and takes no action. The test: could the subject perform the verb if
you ran the program? When it could not, name the actor that does the thing, or
use a verb of description (marks, contains, shows, lists, is).

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

**Describe having with "has", "contains", "lists" or "holds".** A sequence, a
file, a record or a config has its contents. "Carry" casts that relation as an
action, and "carriage" casts it as a quantity. Name a count by what it counts:
"samples with the inversion" for "the inversion's carriers". The clinical
"carrier of a recessive allele" stays.

> each haplotype that carries the allele → each haplotype with the allele
>
> the config carries the track → the config holds the track
>
> a lane colored by carriage → a lane colored by how many haplotypes have each
> segment

Pick a verb of description, because "names", "shows", "takes", "keeps", "sends"
and "stores" leave the same inanimate actor. Where no such verb fits, make the
component or person that acts the subject.

> CD8A is carried by the CD8 rows → the CD8 rows have signal at CD8A
>
> every record carries the result as its `svType` field → each record's
> `svType` field holds the result
>
> the allele rose and carried its neighbours with it → the allele rose in
> frequency, and its neighbouring variants rose with it

In idioms, "carries on" becomes "continues", and "carries over" becomes "stays"
or "applies".

**Describe an artifact by what it contains or does.** "The choice it exists to
offer" and "the failure this layer exists to avoid" give a purpose or a will to
a thing that has neither. State what the thing does or contains.

> which is the tree saying it cannot resolve them → the support values are too
> low to resolve them

**Name the relation a possessive stands for.** "Its own", "their own", "the
haplotype's walk" and "the track's genes" credit a lane, file or column with
ownership. Say which input the thing came from, what it is annotated on, or how
many there are per what. "Its own X" nearly always means one X per Y.

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

A possessive for a literal relation is fine: "each library bundles its own
copy", "a module addresses only its own linear memory". The tell is "own"
beside a verb of action on a drawn or displayed thing.

**Describe a technical term by its behavior.** Keep the term the tools use and
fix the sentence around it.

> `useEffect` is eager to re-run → `useEffect` re-runs whenever a dependency
> changes

**Write the literal word.** For each verb or noun that is not literally true of
its subject, ask what literal word it stands for, and write that word. Keep a
figure when no literal phrase exists or the field has adopted it as a term
("memory leak", "race condition"), and use it once, because an image repeated
through a page ("doors", "walls") becomes a dead metaphor.

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

**Name the actor in the active voice.** Write "The parser leaves the field
unset" for "The field is left unset", and "We measured it and rejected it" for
"It was measured and rejected". Keep an idiomatic passive ("is required", "is
deprecated") and a passive whose actor does not matter. Keep the passive when
the actor is unknown too, because "the service keys requests" or "a cleanup
step collapses the calls" invents a component the reader will look for.

> The arena sizes itself up front → The record pass sizes the arena up front
> (invents a component the reader will look for) → The arena is sized up front

## Sentence shapes

**The cleft: "X is what does Y".** Use the plain verb.

> column-locking is what stacks them → the overlay places domains by column,
> which lines them up
>
> Rounding is what buys the room → Rounding shrinks the file

After removing "is what", check the verb against
[Stance and agency](#stance-and-agency).

> What each accessor costs is what says which are worth tuning → The cost of
> each accessor on first access shows which are worth tuning

**The significance announcement.** "The point", "the whole point", "the honest
answer", "the payoff", "the key insight" and "worth naming" announce a fact
without stating it. Start on the fact.

> The linter checks only syntax, and the syntax is valid. It accepts the file,
> which is the honest answer to the question it was asked. → The linter checks
> only syntax, and the syntax is valid, so it accepts the file.
>
> The key insight is that the index is sorted, which lets lookups use binary
> search. → The index is sorted, so lookups can use binary search.

**The floating fact.** A sentence that states something true about a thing and
draws no consequence leaves the reader guessing why it is there. The common
form glues two facts with "and", one about where the thing came from and one
about what it does. End the sentence on the consequence, and put a fact the
compared things share (both are lightweight) first, since it explains no
difference.

> The tool was created for lightweight deployments and redraws every item to a
> canvas after a zoom. → The tool redraws every item to a canvas after a zoom,
> so its redraw time grows with the number of items in view.

When the cause is the writer's own work, name it with "we" and "because". A
generality in its place reads as evasion.

> The margin is widest at high coverage, where that work is largest. → The
> margin is widest at high coverage, because we put our optimization work into
> the parsers, and more reads mean more parsing.

**Narrated deliberation.** Write the change or the point itself.

> what it changes is worth being precise about → The change moves validation
> from the client to the server.

**The self-answered question.** "The result? A 3x speedup." becomes "The result
is a 3x speedup."

**Dramatic negation.** A sentence whose subject is "nothing", "no one" or
"none", or a "not X's job", reads as a pronouncement. Say what does happen.

> Nothing is prepared for the viewer → The example loads the published URL as
> is.
>
> Producing the file is not the viewer's job → The CLI produces the file.

**A which-ladder.** One relative clause per fact, with the chain split into
sentences.

> a different file, which is a new model, which React spells `key` → A new file
> needs a new model, so change the component's `key`.

**Two conclusions stacked on "so".** Give the second conclusion its own
sentence.

> The key includes the path, so a rename misses the cache, so the first load
> after a rename is slow. → The key includes the path, so a rename misses the
> cache. The first load after a rename is therefore slow.

**A mannered inversion or dropped subject.** Open on the subject and its verb.

> Known now is which latency the number reports: the queue's own. → The number
> reports the queue's own latency.
>
> Hence the second pass. → The parser makes a second pass to resolve forward
> references.

**A fragment standing in for a sentence.** A caption or bullet gets a subject
and a verb.

> Nine load paths, no unit test that can reach them. → There are nine load
> paths, and no unit test reaches any of them.
>
> A file in, a filter applied, a PNG out. → The command reads the file, applies
> the filter and writes a PNG.

**Staccato, or telegraphic, sentences.** Each full stop in a run of short
sentences drops the "so", "and" or "because" that links one fact to the next.
Join sentences that share a subject or where one causes the next, and keep a
short sentence for a single step or a standalone fact.

> The parser reads the header. It checks the version. It rejects old files. →
> The parser reads the version from the header and rejects old files.
>
> The key includes the path. A rename changes the key. The cache misses. → The
> key includes the path, so a rename changes the key and misses the cache.

**A false range.** "From parsing to rendering to export" becomes a list of the
items, or the one that matters.

**A colon lead-in.** Start on the facts. A colon that introduces a list or an
example ("four sets of measurements: ...") is fine; a generalization before
the colon with specifics after it makes the reader match the abstract half to
the concrete half.

> Each cache invalidates where a stale read costs most: the session cache
> invalidates on logout → The session cache invalidates on logout

**A comma-hung appositive.** A noun phrase, a comma, then "one that" or "a
design that" restates the subject, and the comma does a semicolon's work. Fold
the appositive into a relative clause on the noun, or split the sentence.

> Version 2 is an editor without that limit, one that opens files in tabs →
> Version 2 is an editor that removes that limit by opening files in tabs
>
> Version 1 opens one file, a design that cannot compare two → Version 1 opens
> one file, so it cannot compare two
>
> A graph stores each haplotype as a walk, its path through the nodes → A graph
> stores each haplotype as a walk that lists, in order, the nodes it passes
> through

The appositive can open on a possessive ("a walk, its path through ..."). Fold
it into a relative clause that says what the noun contains. "A walk which
represents its path" swaps the pause for an abstract verb and leaves the term
undefined. A comma gloss that names a new term for the first time ("Ribbons,
the bands drawn between aligned regions, join ...") is fine.

**A fronted "So that" clause.** Open on "To" with the goal, or put the purpose
after the main clause.

> So that the page loads faster, we added an index → To make the page load
> faster, we added an index

**A comma-clipped tail.** End the sentence at its last fact. "It rebuilds on
every keystroke, every time" becomes "It rebuilds on every keystroke."

**A compressed noun phrase.** A noun phrase packs a clause into its modifiers:
an option or a verb becomes an adjective ("a dirty half", "the named half of
each record", "private bytes"), or a chain of prepositions stands in for a
subject and a verb ("a page with no entry at the root"). The test: could a
reader who has not seen the code expand the phrase? If so, keep it. Otherwise
write the sentence, or delete it when the page can do without it.

> The flush writes the dirty half of each page. → The flush writes the half of
> each page that has unsaved changes.
>
> The reader then trims to the kept set. → The reader then removes the rows the
> filter rejects.
>
> `maxSkip` caps the cold bytes a read skips → `maxSkip` caps the bytes a read
> skips in blocks that no other read touches

A term the page defines, or an API name in code font such as `keep`, is fine.
See also [An invented concept label](#register).

**Density.** Fixing the tropes above adds clauses, so after a pass split a
sentence that states unrelated facts, and break a paragraph where the subject
changes. Keep facts that depend on each other in one sentence.

**Em-dash asides.** One per paragraph is punctuation, and three signal a writer
avoiding sentence boundaries. A ` -- ` in a code comment is the same habit.
Promote one aside to a sentence, demote another to a comma, and keep a dash
around a parenthetical remark.

## Openings and closings

**An aphorism closing or opening a section.** End the section on a fact.

> The rate limit counts retries. A retry is still a request. → The rate limit
> counts retries as requests.
>
> The snapshot is the API. Every field below is a property of the model. →
> Every field below is a property of the model.

**A conclusion standing in for the mechanism.** Write what the machine does and
name the actor.

> A marker that does not parse stops the build. → The generator exits with an
> error on a marker it cannot parse, so the build fails.

**Silently, quietly, invisibly.** Name what the reader observes.

> The second bug silently writes the wrong value. → The second bug writes the
> wrong value and raises no error.

**A refrain.** State a project rule ("the viewer computes nothing", "no external
services") once, in the design doc, and link to it. Restated as the closer of
every caption or section intro, it reads as boilerplate by the second
appearance.

**An announcer.** "Here's the thing", "Here's where it gets interesting",
"Let's break this down" and "Think of it as" promise content. Start on the
sentence after the announcer. A preview that names its parts is fine: "The
design has two constraints: it must run offline and fit under 50MB."

**The claim first.** Put the claim ahead of its evidence, start at the first
observation, and stop a section at the last one. Premises before the claim, an
opening that argues for the page's importance, and a wrong inference named only
to refute it delay the content.

**A term defined where it is introduced.** When an opening sentence mentions a
feature in passing ("stores each record at two resolutions") and a later
paragraph defines it, move the two together, or introduce the feature in the
paragraph that defines it.

**A closing that ends with the last fact.** "In summary", "As we've seen", a
paragraph restating each section, a tie-back to the opening question ("So, to
answer the original question: yes") and a final sentence that stacks clause
after clause all restate. A reference page ends when its last fact does.

**Length matched to substance.** An overview that repeats the headings, a
summary per section and a boilerplate "Future work" pad a document. A report or
PR description leads with the outcome, meaning what changed or what was found,
and puts supporting detail after it.

**A subject named at the start of a paragraph.** A reader arriving by search hit
or deep link has no antecedent for "It", "This", "That" or "that limit". Name
the subject, even when the previous paragraph named it.

> It runs the same engine as the app. → The renderer runs the same engine as the
> app.
>
> That limit is why we wrote a second parser. (after a paragraph on the 2 GB
> file limit) → The 2 GB file limit is why we wrote a second parser.

**Nouns in place of a count.** "Both", "neither", "either", "the two" or "all
three" as a subject works when the sentence before names the things as nouns
side by side. Elsewhere the reader finds only steps, a figure or a paragraph
further back, and often more than one pair that could fit. Point to the noun
phrases the count replaces; if none exist, write the nouns.

> In the web app, click **Share** and copy the JSON. In the desktop app, save
> the session to a file. *(video)* Both hold the same JSON. → The JSON from the
> Share dialog and the saved session file contain the same session.

"Linux and macOS ship `tar`. Both accept `-z`." is fine, because the count
directly follows the sentence that names the pair.

"The same X" opening a paragraph compares against a first X that a heading or
code block may hide. Name the thing.

> The same track feeds the graph view. → The `coverage` track also feeds the
> graph view.

## Paragraph transitions

A paragraph that introduces a design or a project states the problem with the
prior state in one sentence and gives the response in the next.

**State the limitation as a limitation.** The pattern: *A is limited to X. B
removes that limit by doing Y, so it can Z.*

> Version 1 opens one file at a time. Version 2 opens several, in tabs →
> Version 1 is limited to one open file at a time. Version 2 removes that limit
> by opening several files in tabs

**Cite or cut the narrative bridge.** A sentence about how the field moved
("teams have since shifted to monorepos", "that design fit its era") written to
motivate the turn is a claim the reader will test. Start at the limitation.

> Build tools have since moved toward incremental compilation. Our build
> recompiled every file on each change. We added a dependency graph, so it now
> recompiles only the files a change affects. → Our build recompiled every
> file on each change. We added a dependency graph, so it now recompiles only
> the files a change affects.

**State the general limitation, then the features.** A limitation worded in
exactly the terms of the new tool's headline features reads as back-formed. The
features follow from the general limitation in the next sentence.

> Version 1 cannot show a diff between two files. Version 2 opens files in tabs
> and shows diffs → Version 1 is limited to one open file at a time. Version 2
> opens files in tabs, so it shows diffs

**Make the new thing the subject.** A paragraph introducing a new format or
tool names it in the first sentence. Keep the old tool's limitation to a clause
or fold it into the goal, and mention the old format where it enters the
mechanism, such as the file the new one is converted from.

> A viewer that reads a log file downloads the whole file to show any line
> range. We created a chunked format, which `make-chunks` generates from a log
> file. → To limit the data transferred to the line range in view, we created a
> chunked format, which `make-chunks` generates from a log file.

**Rewrite the paragraph as a unit.** A clause or sentence pushed into an
existing paragraph to keep the change small breaks the sequence the host
sentences were written in: a new subject arrives with no backward link, a
three-item list gains an example on two items, a citation lands on the second
mention of a name. Moving a sentence verbatim carries its old defects along.
Rewrite the paragraph, then read the rules against the whole.

> There is a need to visualize cohorts such as Project A [1], comparisons, and
> graphs such as Graph B [2]. Tool C draws a cohort of hundreds of samples [3].
> Unfortunately, our earlier design ... → Researchers now need to inspect a
> whole cohort or a set of genomes at once, such as Project A [1] or Graph B
> [2]. Tool C draws such a cohort on the GPU from a specification [3], and its
> authors set it apart from track-based browsers such as ours. Our earlier
> design ...

## Headings and labels

**Name the subject.** A teaser heading withholds it.

> The one setting nobody else has → Offline mode

**Use a noun.** Keep a phrase only where the section answers a question the
reader asks in those words, such as an FAQ entry or a `Why ...` section.

> Where the file goes → Output
>
> What you need before starting → Requirements

**Name what the section contains.** A heading that gives its subject agency, or
says what a thing is not, tells a scanning reader little.

> What a database answers → Contents and limitations
>
> What it does not do → Limitations

**Sentence case.** Capitalize the first word and proper nouns.

**Plain labels in a reference table.** A flag table is read by someone looking
one thing up.

> `--seed=<n>` | the dice → `--seed=<n>` | random seed

**Plain bullets.** Bold marks a term being defined, as in a glossary. Keep a
list, table or heading wherever the content has several parallel parts a reader
will scan or look up.

## Comments and history

**A comment states the constraint the code satisfies,** with the measurement if
there is one. History ("used to", "the previous version", "found while
debugging") belongs in the commit message.

> reset() used to leave the Cancel button showing → reset() also hides the
> Cancel button

**Documentation describes the current behavior.** The history goes in commits
and release notes ("we switched to X after Y broke"). When a passage is wrong,
rewrite or delete it, because a new paragraph that corrects the one above
leaves both for the reader to reconcile. Replace the history with the current
fact, and keep the claim it made.

> a lot of machinery for what used to be a `for` loop → a lot of machinery for
> what a `for` loop could do instead (now claims the loop would work) → the
> largest piece of machinery in the library, in place of a sequential `for` loop

**A clause carries the rationale.** Keep the measurement and the non-obvious
constraint, and put repeated rationale in one place with pointers to it.

> // We considered leaving the keys in fetch order, but the diff output has to
> // be stable across runs and fetch order is not, so we sort them first. →
> // Sort the keys so the diff output is stable across runs.

**Lowercase emphasis.** Put the emphasis in the wording: "the ONLY difference"
becomes "the only difference".

## Register

**Match the register of the document.** Judge a word by the document it appears
in. A plain unqualified comparative ("faster", "much smaller") is fine, because
a made-up or overly precise number reads worse than the word it replaces.

**Round numbers and checkable figures.** "130,510 rows", "ranked 50th of
9,444" and "an index of 37,545 bytes against the old one's 20,622" claim an
authority the page cannot back, and they go out of date when the data or code
changes, with nothing to flag it. Say which way the result went, and point at a
figure, a table or a script that shows how far. A round magnitude ("about a
thousand"), a coordinate, an identifier and a published size name something and
stay.

> The new index is 37,545 bytes against the old one's 20,622 → The new index is
> nearly twice the size of the old one

**A goal with a quantity.** "To optimize rendering", "to improve performance"
and "to help with scale" name a direction. Name the quantity the design lowers
or raises: bytes transferred, time to first draw, memory per track.

> To optimize the rendering of alignments, we created an indexed format → To
> limit the data transferred when drawing alignments to the region in view, we
> created an indexed format

**The verb a user of the tool would say.** A verb from the program's vocabulary
or from the authors' private metaphors ("hydrates" a record, "resolves" a path,
"names" a column) reads as translated. Use identify, label, look up or fill in,
and keep the internal word in code font where it is an identifier.

> The loader hydrates each record from the cache or the database. → The loader
> fills in each record from the cache or the database.
>
> The router resolves a path to a handler. → The router looks up a handler for
> a path.

**An abbreviation glossed at first use.** Expand a format or tool name ("WAL",
"BGZF") where a reader who does not know it will stop.

> The output is a WAL file → The output is a WAL file, the write-ahead log the
> database appends each change to

**The description in place of a pitch.** A pitch sells the thing's capability or
standing, and its plain vocabulary slips past the promotional word list. The
tell is a claim the reader cannot check. Its forms:

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

**Plain words for promotion and authority.** Replace `vibrant`,
`groundbreaking`, `boasts`, `flagship`, `crisp`, `seamless`, `robust`, the
`delve` / `tapestry` / `testament` / `showcase` / `pivotal` cluster, and "This
changes how we think about configuration" with what the thing does. Cite
`industry reports`, `surveys show`, "a classic", "famously" and "the
well-known", or drop the adjective.

**A transition that is a clause.** "Additionally", "Furthermore", "Moreover",
"Notably", "Importantly", "Ultimately" and "Overall" at the head of a sentence
say the sentence relates to the last without saying how. Delete the adverb, or
write the relation as a clause.

> Additionally, the server clears the cache on restart. → The server clears
> the cache on restart.
>
> Ultimately, the index is the bottleneck. → The index is the bottleneck.

**The plain verb.** Write use, simplify, let, check and make for `leverage`,
`utilize`, `streamline`, `empower`, `unlock`, `ensure` and `enable`. Drop the
filler adjectives `comprehensive`, `crucial`, `essential` and `key` and the
quantifiers "a variety of" and "a range of". Supply the plain verb alone, with
no added count or list.

> The tool leverages a comprehensive set of heuristics to ensure correctness.
> → The tool uses a set of heuristics to check correctness.

**The claim as its own sentence.** `…, highlighting how the two stages interact`
is a claim with nobody making it. Write it as a sentence or drop it.

> Scores drop after the tokenizer change because the tagger was trained on the
> old token boundaries, highlighting how the two stages interact. → Scores drop
> after the tokenizer change because the tagger was trained on the old token
> boundaries.

**A description for an invented label.** "The staleness trap", "the dangerous
shape" and "config creep" read as established terms. Describe the thing the
label stands for.

**One noun per referent.** A track called a lane, then a layer, suggests three
things. Pick the noun and repeat it, along with any distinctive word reused
from earlier in the page ("quietly" in two sections).

**"Is" for "serves as".** Write "is" for "serves as", "stands as" and
"represents", and say the literal thing for "reads straight off", "tells a
story", "shape" as an all-purpose noun, "counterpoint", "actually" and
"genuinely". A circular sentence ("an alignment is an alignment") gets a
definition.

> The cache serves as the source of truth → The cache is the source of truth

## Preserve

- The claim. A rewrite that changes what a sentence asserts is worse however
  plain it reads.
- Measurements. Numbers, identifiers, file paths and the names of mechanisms
  are the content. A prose pass moves sentences around them. The exception is a
  precise number the reader cannot check, covered under [Register](#register).
  A rewrite can also add precision the original never claimed: "the absolute
  heights survive the trip" becomes "the absolute heights round-trip exactly"
  only when the code says so.
- The mechanism. A rewrite that adds "in the same way as tool X", "each record
  consists of" or "collapses into a single run" makes a new claim the spec may
  contradict. Check the sentence against the spec or the code, or cut it.
- Terms the tools use. The reader needs the word the manual uses for a flag or
  a field.
- An established idiom. A device an author uses deliberately and consistently
  across a corpus stays, even when one instance gets flagged.
- The author's voice in a README tagline or a personal note.
- The distinctions a design record is about. A record that names the option it
  declined needs both halves.
- Generated prose. Fix the generator, since an edit to the output lasts until
  the next build.

## Quick scan

`scan.sh` beside this file greps the Markdown, LaTeX, reStructuredText and
plain-text files under a path for the markers above and labels each hit by its
section: `contrast`, `negative`, `aphorism`, `shape`, `agency`, `colon`,
`apposition`, `opening`, `passive`, `history`, `register`, `pitch`, `claim`,
`number`, `float`, `coldstart` and `staccato`. Read each hit in context.

- `float` marks an origin statement ("was created for") or a "where that work
  is largest" generality.
- `claim` marks a comparison to another tool ("in the same way", "similar to"),
  which needs checking against that tool's documentation.
- `pitch` marks a capability boast, superlative, potential teaser or priority
  claim. A superlative that reports a measurement is fine.
- `number` marks a number grouped in thousands or with two or more decimal
  places. A coordinate after a colon or a dash, a version and a DOI pass.
- `coldstart` marks a paragraph whose first line opens on a pronoun, a
  demonstrative, a count such as "Both" or "The two", or a sentence-initial
  "So", "And" or "Hence". A paragraph that follows a list and opens on "These"
  is usually fine.
- `staccato` marks a paragraph or bullet with three sentences in a row of six
  words or fewer.
- `history` matches ALL-CAPS emphasis words such as NOT, ONLY and SAME, and
  passes acronyms such as BGZF or CIGAR.
- `colon` and `apposition` mark the two sentence shapes that split a sentence
  at its punctuation.

```sh
# installed as a plugin
bash "$CLAUDE_PLUGIN_ROOT"/skills/anti-ai-writing-tropes/scan.sh docs/
# copied into ~/.claude/skills
bash ~/.claude/skills/anti-ai-writing-tropes/scan.sh docs/
```

`test/run.sh` checks the patterns against a fixture after an edit.
