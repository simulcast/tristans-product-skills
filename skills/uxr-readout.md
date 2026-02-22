---
description: Synthesize user research data into themes and product implications
allowed-tools: Bash, Read, Write, Edit, Glob, Grep, AskUserQuestion, WebSearch, WebFetch, Task
---

# /uxr-readout — UXR Readout

You are synthesizing user research data into actionable themes and product implications. This skill takes raw research data (interviews, surveys, tickets, reviews) and produces a structured readout.

**Synthesis integrity guard — hard rules for the entire skill:**
1. **Source-lock every claim.** Every theme, finding, and factual assertion must include a parenthetical source reference (participant name, file name, snapshot title). No floating claims.
2. **No Frankenquotes.** Never splice words from different sources into a single quote block. Use separate `> quote` blocks per source, even when they support the same theme.
3. **Flag cross-source inferences.** When a finding requires connecting dots across sources rather than being stated directly, mark it `[cross-source inference]` with the supporting quotes from each source listed separately.

## Step 1: Locate product repo

Determine the product repo:
- If the current directory is a product repo (has `prd/` directory), use it
- If the current directory is a code repo, read `.factory-config.json` for `productRepo`
- If unclear, ask the user which product repo to use

Ensure `research/` directory exists. If not, create it.

## Step 2: Read conventions

Read `~/.claude/product-skill-conventions.md` for the shared conventions. Follow all conversational mechanics throughout this skill.

## Step 3: What kind of research?

Ask: **"What kind of research is this?"**

Present options:
1. **User interviews** — transcripts or notes from 1:1 conversations
2. **Survey results** — structured responses from many users
3. **Support tickets** — customer support conversations
4. **App reviews** — App Store, Play Store, or similar
5. **Social media feedback** — Reddit, Twitter, forums, etc.

## Step 4: Where's the data?

Ask: **"Where's the raw data? Point me at files in the repo, or paste the content."**

Read all source material. Assess volume to determine if subagents are needed.

## Step 5: Research question

Ask: **"What were you trying to learn?"**

If the user doesn't have a specific research question, propose one: "It looks like you were exploring [X]. Does that sound right?"

## Step 6: Calibrate interpretation

Ask: **"Do you have a categorization scheme or scoring rubric for this analysis, or should I propose one?"**

- **If user has one:** Adopt it. Confirm by restating the categories with examples.
- **If user says propose one:** Present 3-5 categories with a one-line definition and one concrete example each. For example:
  - **Strong signal** — user describes this as a blocker or top priority: _"I literally can't do my job without this"_
  - **Moderate signal** — user mentions it unprompted but not as a top concern: _"It would be nice if..."_
  - **Weak signal** — user agrees when prompted but didn't raise it themselves
- **If user wants to skip:** Proceed with open thematic analysis. Note in the readout that no rubric was applied.

Let the user adjust categories before proceeding.

## Step 7: Synthesize themes

Launch subagents using the Task tool depending on data volume:
- **Small (5-10 interviews):** One agent reads all, clusters themes
- **Large (100+ tickets/reviews):** Split across multiple agents, each handles a chunk
- Each agent extracts: themes, supporting quotes, sentiment, frequency

**Subagent instructions (include in every subagent prompt):**
- Source-lock every quote with the file name or participant name (e.g., `— Matt, interview snapshot`)
- Never combine quotes from different sources into a single block
- If a calibration rubric was defined in Step 6, tag each data point against it (e.g., `[strong signal]`, `[moderate signal]`)

## Step 8: Present themes

Present themes ranked by frequency/strength:

For each theme:
- **Theme name** + one-line summary
- **Confidence:** `[strong]` (3+ sources), `[moderate]` (2 sources), `[thin evidence]` (1 source)
- **Supporting evidence** — 2-3 quotes in separate `> quote` blocks, each attributed to its source (e.g., `— Matt, interview snapshot`). Never combine quotes from different sources into a single block.
- **Strength** — how many sources support this theme (e.g., "4 of 6 interviews")

Ask: **"Do these themes match your intuition? What surprises you?"**

Let the user validate and push back. They were in the room (or read the tickets) — they have context you don't.

## Step 9: Extract implications

For each validated theme, propose a concrete product action:

"This suggests we should [specific action]."

Be concrete: "Add a bulk import feature" not "improve the onboarding experience." Connect each implication to the theme that supports it.

Let the user react and refine.

## Step 10: Verification pass

Before presenting the readout, silently run a verification pass:

1. **Quote accuracy.** Confirm every quoted passage exists verbatim in the source material. Drop or fix any misquoted text.
2. **Within-source contradictions.** Check whether the same source supports contradictory claims across different themes. If so, note both claims with context.
3. **Thin-evidence warnings.** Confirm that any finding supported by fewer than 2 sources is flagged `[thin evidence]`.

Run this silently. Only surface issues to the user if problems are found. Proceed without comment if clean.

## Step 11: Write the readout

Write to `research/uxr-{topic}.md` where `{topic}` is a kebab-case slug.

Structure:
```markdown
# UXR Readout: {Topic}

**Date:** {YYYY-MM-DD}
**Method:** {interviews / survey / tickets / reviews / social}
**Sample size:** {N sources}
**Research question:** {What we were trying to learn}

## Themes

### 1. {Theme Name} `[strong]`
{One-line summary}

**Strength:** {N of M sources}

**Supporting evidence:**
> "{Quote 1}" — {Source 1}

> "{Quote 2}" — {Source 2}

> "{Quote 3}" — {Source 3}

### 2. {Theme Name} `[moderate]`
...

## Implications

| Theme | Suggested Action | Priority |
|-------|-----------------|----------|
| {Theme 1} | {Concrete product action} | {high/medium/low} |
| {Theme 2} | {Concrete product action} | {high/medium/low} |

## Raw Data Reference
{Where the source data lives for future reference}

## Verification Notes
{Any issues found during verification pass: misquoted text, contradictions, thin-evidence flags. If verification passed clean, state "Verification pass clean — all quotes confirmed, no contradictions found."}
```

Present for approval before writing.

## Step 12: Report

Summarize top themes and their implications in 3-4 bullet points.

Recommend next skill:
- If themes suggest a new feature → "Run `/write-prd` to spec out [highest-priority implication]."
- If themes are strategic → "Run `/strategy-brief` to frame the strategic response."
- If themes need validation → "Run `/assumption-test` to validate [key assumption from themes]."
- If competing implications → "Run `/prioritize` to stack-rank the implied actions."

Commit and report the file path.
