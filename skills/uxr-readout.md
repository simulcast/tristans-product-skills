---
description: Synthesize user research data into themes and product implications
allowed-tools: Bash, Read, Write, Edit, Glob, Grep, AskUserQuestion, WebSearch, WebFetch, Task
---

# /uxr-readout — UXR Readout

You are synthesizing user research data into actionable themes and product implications. This skill takes raw research data (interviews, surveys, tickets, reviews) and produces a structured readout.

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

## Step 6: Synthesize themes

Launch subagents using the Task tool depending on data volume:
- **Small (5-10 interviews):** One agent reads all, clusters themes
- **Large (100+ tickets/reviews):** Split across multiple agents, each handles a chunk
- Each agent extracts: themes, supporting quotes, sentiment, frequency

## Step 7: Present themes

Present themes ranked by frequency/strength:

For each theme:
- **Theme name** + one-line summary
- **Supporting quotes** — 2-3 quotes with source attribution
- **Strength** — how many sources support this theme (e.g., "4 of 6 interviews")

Ask: **"Do these themes match your intuition? What surprises you?"**

Let the user validate and push back. They were in the room (or read the tickets) — they have context you don't.

## Step 8: Extract implications

For each validated theme, propose a concrete product action:

"This suggests we should [specific action]."

Be concrete: "Add a bulk import feature" not "improve the onboarding experience." Connect each implication to the theme that supports it.

Let the user react and refine.

## Step 9: Write the readout

Write to `research/uxr-{topic}.md` where `{topic}` is a kebab-case slug.

Structure:
```markdown
# UXR Readout: {Topic}

**Date:** {YYYY-MM-DD}
**Method:** {interviews / survey / tickets / reviews / social}
**Sample size:** {N sources}
**Research question:** {What we were trying to learn}

## Themes

### 1. {Theme Name}
{One-line summary}

**Strength:** {N of M sources}

**Supporting evidence:**
> "{Quote 1}" — {Source}
> "{Quote 2}" — {Source}
> "{Quote 3}" — {Source}

### 2. {Theme Name}
...

## Implications

| Theme | Suggested Action | Priority |
|-------|-----------------|----------|
| {Theme 1} | {Concrete product action} | {high/medium/low} |
| {Theme 2} | {Concrete product action} | {high/medium/low} |

## Raw Data Reference
{Where the source data lives for future reference}
```

Present for approval before writing.

## Step 10: Report

Summarize top themes and their implications in 3-4 bullet points.

Recommend next skill:
- If themes suggest a new feature → "Run `/write-prd` to spec out [highest-priority implication]."
- If themes are strategic → "Run `/strategy-brief` to frame the strategic response."
- If themes need validation → "Run `/assumption-test` to validate [key assumption from themes]."
- If competing implications → "Run `/prioritize` to stack-rank the implied actions."

Commit and report the file path.
