---
name: user-guide-audit
description: Audit and tighten a product's user-facing docs, such as a user guide, a getting-started page, a FAQ or feature pages. Use when asked to review, shorten, restructure or consolidate a user guide, add or retake screenshots, or make the docs read as a walk through the product. Pairs with anti-ai-writing-tropes for sentence-level prose.
allowed-tools: Bash(bash *walls.sh*)
---

# User guide audit

A user guide follows a person through the product in the order they meet it,
and lets screenshots do most of the explaining. An audit cuts first, then
merges pages, then adds the few sentences and pictures that make the flow
read.

## Workflow

1. **Map the pages.** Run `walls.sh` beside this file on the docs folder. It
   prints words and figures per page, then the leads below. Write down who
   each page is for and what question it answers.
2. **Consolidate.** Give each reader question one page. See
   [Consolidate](#consolidate).
3. **Cut.** Delete what the interface already says. See [Cut](#cut).
4. **Order the flow.** Arrange sections the way a newcomer uses the product.
   See [Flow](#flow).
5. **Show it.** Replace a paragraph that describes the screen with a picture
   of the screen. See [Screenshots](#screenshots).
6. **Check claims.** Read every number, default, limit, shortcut and button
   label against the source. Correct a claim the source contradicts, and cut one it cannot
   back.
7. **Scan the prose** with
   [anti-ai-writing-tropes](../anti-ai-writing-tropes/SKILL.md) and its
   `scan.sh`.

Report word counts before and after in the commit message, with what went
and why.

## Consolidate

- Merge two pages that answer the same question. Keep the page the app or
  the README links to, fold the other into it, and fix every link.
- Link to a fact on the page that owns it. A FAQ answer that restates a guide
  section becomes one line and a link, or goes.
- Keep working notes, design rationale and postmortems out of the guide. Move
  them to `docs/` or the commit history; the guide links there only when a
  reader asks "why".
- Keep reference pages (every control, every flag, every shortcut) as tables
  with no walkthrough prose. The guide links into them.
- A heading that appears on two pages (`[overlap]`) usually means the pages
  cover one topic twice.
- An `[orphan]` page with no inbound link is either missing from the index or
  ready to delete.

## Cut

- Cut the tour of every button the screen already labels. Name a control
  only where it behaves in a way its label does not say, such as a
  requirement, a surprise or a setting that persists.
- Cut instructions the reader does not need: "make sure to", "you will want
  to", "note that". Write the action.
- Cut the reason behind an interface decision. A reader wants what the
  control does.
- Cut a feature that does not exist yet, and the answer "not yet" padded to a
  paragraph.
- Keep the surprise that has nothing in the interface to warn about it, even
  when it is one sentence on a page you are cutting hard. Reread the deleted
  lines for one before committing a large cut.
- Keep every keyboard shortcut, URL parameter and code span that leaves the
  page somewhere else, usually a reference table. Check the diff for any that
  vanished.

## Flow

Narrative in a guide is a line or two between a heading and a figure that
tells the reader where they are and what comes next. Leave the explaining to
the figure.

- Order the sections by what a person does: open it, try a thing, change it,
  keep it, share it. A section ordered by the code's modules reads as
  reference.
- Name each section by the task: "Making it move", "Keeping what you find".
- Open a section on the action and its result in one or two sentences, then
  the figure.

  > This section describes the modulation system, which provides several
  > ways to animate parameters. → **+ mod** on a row patches a slow drift onto
  > that control.

- Bridge two sections only where the reader needs to know why the next one
  follows, as in "The loops are the exception to working left to right". Cut
  "Now let's look at sound".
- Start the guide with a two-minute path a newcomer can follow: open the
  app, change one thing, see the result. Link the rest.
- Break a `[wall]` into a short bullet list, or cut it. Split a long bullet
  into two, or move its detail to the reference page.

## Screenshots

- A picture replaces the paragraph that described the screen. Delete that
  paragraph when the picture goes in.
- Look for stills the project already makes, such as a landing page tour or a
  store listing, before shooting new ones. Link the same files so the two
  pages cannot drift apart, and compare their labels with the source first,
  because a still can be a rename behind.
- Rebase before retaking a shared still. Another branch may have retaken or
  deleted it.
- Shoot the whole window with a box round the subject. A tight crop of one
  panel reads as a screenshot of some other program, and the reader loses
  where the panel sits and what it does to the rest of the screen. Follow it
  with a readable-size crop when the subject is small.
- Put one sentence above the picture saying what to look at, and the detail
  in the alt text: what is in frame, the labels it reads, the state it is in.
  The alt text is the caption for a reader who cannot see the image.
- Shoot every picture in the same state, with the same sample data and the
  same window size, so the pages read as one session.
- Declare each shot as a spec in a script: a URL and the fewest actions that
  reach the state. A URL parameter or seeded storage is sturdier than a click
  sequence, because the app's own parser checks it.
- Stamp each capture with the app version and fail a check when a shot with
  interface chrome falls a release behind. A shot of content alone, such as a
  rendered picture, does not date.
- Read the built page at phone width. Three portrait stills in a row shrink
  to thumbnails there, so the alt text has to carry the detail.
- Use a short looping clip for anything that moves, with a poster frame so
  the page shows a frame before the clip loads.
- A `[bare]` section is 150 words or more of prose with no figure. Either a
  picture belongs there, or the section is reference that belongs in a table.

## Leave alone

- The voice of a tagline or an author's personal note.
- Reference tables and the numbers in them.
- A contrast the reader needs to choose correctly between two similar
  controls.
- Generated pages. Fix the generator.

## walls.sh

`walls.sh` reads the Markdown files under a path and prints a table of words
and figures per page, then:

- `[wall]` a paragraph or bullet over four lines
- `[bare]` a section of 150 or more words of prose with no figure
- `[alt]` an image with empty alt text
- `[orphan]` a page no other page in the set links to
- `[overlap]` a heading on more than one page

```sh
# installed as a plugin
bash "$CLAUDE_PLUGIN_ROOT"/skills/user-guide-audit/walls.sh docs/
# copied into ~/.claude/skills
bash ~/.claude/skills/user-guide-audit/walls.sh docs/
```

Every hit is a lead to read in context. A reference page will show `[bare]`
on every section, and that is fine.
