---
description: Map the opportunity space from primary research using the Opportunity Solution Tree framework
allowed-tools: Bash, Read, Write, Edit, Glob, Grep, AskUserQuestion, WebSearch, WebFetch, Task
---

# /opportunity-map — Opportunity Map

You are mapping the opportunity space from primary user research. This skill produces an Opportunity Solution Tree (Teresa Torres framework): a hierarchical map of user needs, pains, and desires organized by psychological depth — not by feature or workflow.

The resulting artifact is the bridge between "what did we learn from research?" and "what should we build?" It stops deliberately before solutions — per OST, you select a target opportunity before ideating.

**Quality drivers — hard rules for the entire skill:**

1. **Read primary sources, not summaries.** Interview snapshots and transcripts produce better opportunities than readout themes. Readouts compress individual voices into aggregate patterns, which erases the contradictions and emotional texture where the best insights live. Use readouts for cross-referencing, not as the synthesis input.
2. **Go one level deeper than feels natural.** For every opportunity, ask "what's the need behind this need?" Surface-level needs produce feature-shaped opportunities ("I need a portfolio view"). Deep needs produce insight-shaped opportunities ("the complexity of managing multiple teams threatens the thing I love about the game") that lead to novel solutions nobody else is building.
3. **Organize by psychological need, not by workflow or feature.** If your parent opportunities map to screens, tools, or features — you've gone wrong. Parent opportunities should describe human tensions that persist across contexts.
4. **Pressure-test against distinct personas.** Every opportunity should be evaluated for intensity per persona. Different personas experience the same opportunity with different intensity — or not at all. The heat map is where targeting decisions emerge.
5. **Map competitive reality.** Every sub-opportunity gets tagged with what currently serves it. This turns the opportunity map from "what users need" into "where we can win."

**Synthesis integrity — follows from `~/.claude/product-skill-conventions.md`:**
- Source-lock every claim with participant name or file reference
- No Frankenquotes — separate `> quote` blocks per source
- Flag cross-source inferences with `[cross-source inference]`
- Tag signal strength as N of M sources

## Step 1: Locate product repo

Determine the product repo:
- If the current directory is a product repo (has `prd/` directory), use it
- If the current directory is a code repo, read `.factory-config.json` for `productRepo`
- If unclear, ask the user which product repo to use

Ensure `strategy/` directory exists. If not, create it.

## Step 2: Read conventions

Read `~/.claude/product-skill-conventions.md` for the shared conventions. Follow all conversational mechanics throughout this skill.

## Step 3: Gather and read all primary sources

Scan the product repo for research artifacts:
- `research/uxr/interview-snapshots/*.md` — individual interview snapshots **(read these first, always)**
- `research/uxr/interview-transcripts/*` — raw transcripts (read when snapshots lack depth on a theme)
- `research/uxr/readouts/*.md` — UXR readouts (cross-reference, don't substitute for primaries)
- `research/discovery/*.md` — discovery briefs and competitive analyses
- `research/assumption-tests/*.md` — assumption test results
- `strategy/*.md` — existing strategy documents

**Read ALL interview snapshots.** This is the most important step. The quality of the opportunity map is directly proportional to the volume of primary source material held in context during synthesis. Each individual voice carries texture — contradictions, surprising framings, emotional weight — that readout themes compress away.

If there are more than ~15 interview snapshots, use subagents to extract key quotes, opportunities, and behavioral patterns per source — then synthesize in the main thread from those extractions. Below 15, read them all directly.

Tell the user what you found: "I found [N] interview snapshots, [N] readouts, and [N] other research artifacts. Reading them now."

## Step 4: Define the outcome

Ask: **"What's the desired outcome for the top of the tree? This should be a user behavior you want to drive — not a business metric."**

Present your recommendation based on what you've read. Per OST, the outcome should be:
- A behavior the product team can influence directly
- Observable and measurable
- Not a vanity metric (signups, page views) — a genuine behavioral indicator of value delivery

Help the user sharpen vague outcomes. "Users engage with the product" → "Users return to the product unprompted when making a [domain] decision."

## Step 5: Define personas from research

Propose personas grounded in the research — clustered by behavior and psychology, not demographics:

"Based on the research, I see [N] distinct personas: [list]. Does this match your mental model?"

For each persona, draft:
- **Archetype name** — a label that captures the psychology, not the demographics
- **Defining behavior** — what they do that makes them distinct
- **Core psychology** — 1-2 sentences on the emotional/cognitive driver underneath

Push past demographic or scale-based segmentation. "Power user / casual user" is a feature of the data; "over-informed and under-confident / systems thinker at the edge of chaos" is an insight about why they behave differently.

Validate with the user before proceeding.

## Step 6: Synthesize parent opportunities

This is the core synthesis step. Immerse yourself in the primary sources and identify **3-7 parent opportunities.** This is the step where the depth of reading pays off.

Parent opportunities must:
- **Describe a human tension, not a feature gap.** Test: could this opportunity be addressed by multiple very different solutions? If it maps to one obvious feature, it's too narrow.
- **Be stated in the user's voice.** First person, emotionally honest, specific.
- **Each have a distinct psychological root.** If two opportunities share the same underlying driver, they should be sub-opportunities of a single parent.
- **Collectively cover the breadth of decisions** relevant to the outcome. Mentally walk through every decision type in the domain and check that each maps to at least one parent.

For each parent, develop:

1. **The need in the user's voice** — first person, with the emotional truth attached
2. **"The insight behind the insight"** — ask: why is this persistent? Why hasn't it been solved? What structural or psychological force keeps it in place? This paragraph is where the real value lives. Push past the obvious explanation to the systemic one.
3. **3-5 sub-opportunities** — specific, observable manifestations grounded in verbatim quotes from primary sources
4. **Signal strength** — N of M sources, whether raised prompted or unprompted, emotional weight

**Validate parents before going deep.** Present the parent opportunity names, one-line framings, and insight-behind-the-insight paragraphs. Ask: **"These are the parent opportunities I see in the research. What's missing? What's framed wrong?"**

This checkpoint prevents wasted effort on a tree structure the user disagrees with.

## Step 7: Fill in sub-opportunities

For each validated parent, present the full branch: sub-opportunities with supporting quotes, signal strength, and persona intensity.

Present 1-2 parents at a time if the tree is large. Validate iteratively.

For each sub-opportunity:
- Ground it in at least one verbatim quote from a primary source
- Tag signal strength (N of M sources, prompted/unprompted)
- If evidence is thin (< 2 sources), flag it `[thin evidence]` — this is informational, not disqualifying

## Step 8: Map competitive coverage

For every sub-opportunity, assess:
- **Currently served by:** What existing tool, product, behavior, or workaround addresses this?
- **Gap level:**
  - **Open** — nothing serves it
  - **Nearly open** — single indie builder or hacky workaround only
  - **Partially served** — a product exists but is inadequate (wrong form factor, missing context, etc.)
  - **Served** — an adequate solution exists for most users

Present as a table. Ask: **"Does this match your read of the competitive landscape?"**

Draw from competitive analysis artifacts in `research/discovery/competitive-*.md` if they exist.

## Step 9: Persona × opportunity heat map

Rate every parent and sub-opportunity by intensity per persona:
- ●●● = primary pain, burning need, defines this persona's experience
- ●●○ = significant but not the primary driver
- ●○○ = present but not intense
- ○○○ = not relevant to this persona

Present the heat map and a narrative summary per persona: "For [persona], the primary opportunities are [X] and [Y], because [psychological reason]."

Clusters of ●●● across multiple personas reveal the highest-leverage opportunities. Opportunities that are ●●● for one persona but ○○○ for another suggest persona-specific solutions.

## Step 10: Verification pass

Before finalizing, silently verify:
1. **Quote accuracy.** Confirm quoted passages exist in the source material.
2. **Signal strength accuracy.** Verify N-of-M counts by checking each source attributed.
3. **Coverage completeness.** Walk through the major decision types in the domain and confirm each maps to at least one opportunity.
4. **Persona consistency.** Check that heat map ratings are consistent with evidence from each persona's interview.

Run silently. Only surface issues if problems are found.

## Step 11: Write the opportunity map

Write to `strategy/opportunity-tree-{topic}.md` where `{topic}` is a kebab-case slug.

Structure:
```markdown
# Opportunity Solution Tree: {Topic}

**Date:** {YYYY-MM-DD}
**Status:** draft
**Outcome:** {Product outcome from Step 4}
**Research base:** {Sources — N interviews, competitive analysis, etc.}
**Framework:** Opportunity Solution Tree (Teresa Torres)

---

## Framing
{The meta-insight — the deepest pattern connecting the opportunity space. This should reframe how the reader thinks about the problem domain. 1-2 paragraphs.}

### Personas
{Table: Persona | Archetype | Defining behavior | Core psychology}

---

## The Opportunity Space

### 1. {Parent opportunity — first person, emotional}
**{Short label}**

{2-3 sentence description}

> *The insight behind the insight:* {Why this is structural/persistent. The psychological or systemic driver underneath the surface-level need.}

**Sub-opportunities:**

**1a. {Sub-opportunity}**
{Description}
> "{Quote}" — {Source}
*Signal: {N/M, strength}*

...

**Persona intensity:** {Persona 1} ●●● | {Persona 2} ●●○ | {Persona 3} ●○○

---

## Competitive Coverage Map
| Opportunity | Currently served by | Gap |
|---|---|---|
| {Sub-opp} | {Tool/behavior} | {Open / Nearly open / Partially served / Served} |

---

## Persona × Opportunity Summary
{Per persona: which opportunities are primary, why, and what this implies for targeting}

---

*Solutions and assumption tests intentionally omitted — per OST, select a target opportunity before ideating solutions.*
```

Present the full artifact for approval before writing.

## Step 12: Report

Summarize:
- The framing insight (1 sentence)
- Number of parent opportunities and sub-opportunities identified
- Which opportunities are most competitively open
- Which personas have the most unserved primary needs
- Where the highest-leverage targeting zone appears (intersection of high persona intensity + open competitive space)

Recommend next skill:
- To design a solution for the target opportunity → "/write-prd"
- To validate a key belief before building → "/assumption-test"
- To sharpen strategic direction → "/strategy-brief"
- To decide between competing target opportunities → "/prioritize"

Commit the artifact and report the file path.
