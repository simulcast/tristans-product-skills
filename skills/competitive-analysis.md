---
description: Research and compare competitors in a product space
allowed-tools: Bash, Read, Write, Edit, Glob, Grep, AskUserQuestion, WebSearch, WebFetch, Task
---

# /competitive-analysis — Competitive Analysis

You are guiding the user through a structured competitive analysis. The goal is to map a product space, identify gaps, and surface opportunities.

## Step 1: Locate product repo

Determine the product repo:
- If the current directory is a product repo (has `prd/` directory), use it
- If the current directory is a code repo, read `.factory-config.json` for `productRepo`
- If unclear, ask the user which product repo to use

Ensure `research/` directory exists. If not, create it.

## Step 2: Read conventions

Read `~/.claude/product-skill-conventions.md` for the shared conventions. Follow all conversational mechanics throughout this skill.

## Step 3: What space?

Ask: **"What space are we looking at? Describe the category or problem domain, not specific products."**

For example: "dynasty fantasy football tools" not "KeepTradeCut." The space defines the boundaries of the analysis.

## Step 4: Known players

Ask: **"Who are the obvious players you already know about?"**

The user usually knows 2-3. List them. The research will find more.

## Step 5: Comparison dimensions

Ask: **"What dimensions matter for comparison?"**

Propose defaults based on the space:
1. **Features/capabilities** — what they do
2. **Pricing** — how much, what model
3. **Target audience** — who they serve
4. **UX approach** — how they do it
5. **Data sources** — where their data comes from

Let the user add or remove. Keep to 4-6 dimensions max — more than that dilutes the analysis.

## Step 6: Research competitors

Launch subagents using the Task tool — one per competitor (up to 5-6 in parallel).

Each subagent should:
- Use WebSearch and WebFetch to research the competitor
- Answer: What do they do? Who's it for? How much does it cost? What's their approach? What do users praise/complain about?
- Return structured findings

If more competitors are discovered during research, ask the user if they should be included.

## Step 7: Synthesize the landscape

Present a comparison table (competitors x dimensions).

Highlight three categories:
- **Table stakes:** What every player does — you need this too
- **Differentiators:** Where players diverge — your opportunity to choose a lane
- **Gaps:** What nobody does well or at all — your potential wedge

Ask: **"Does this match your understanding? Anything surprising?"**

Let the user react and refine the analysis.

## Step 8: Write the analysis

Write to `research/competitive-{space}.md` where `{space}` is a kebab-case slug.

Structure:
```markdown
# Competitive Analysis: {Space}

**Date:** {YYYY-MM-DD}
**Dimensions:** {list of comparison dimensions}

## Landscape Overview
{2-3 paragraph summary of the competitive landscape}

## Competitor Profiles

### {Competitor 1}
- **What they do:** {one-liner}
- **Target audience:** {who}
- **Pricing:** {model and range}
- **Strengths:** {what they do well}
- **Weaknesses:** {where they fall short}
- **User sentiment:** {what users say — praise and complaints}

### {Competitor 2}
...

## Comparison Matrix

| Dimension | Comp 1 | Comp 2 | Comp 3 | ... |
|-----------|--------|--------|--------|-----|
| {dim 1} | ... | ... | ... | |
| {dim 2} | ... | ... | ... | |

## Gaps & Opportunities
- **Table stakes:** {what everyone does}
- **Differentiators:** {where players diverge}
- **Gaps:** {what nobody does well}

## Implications
{What this means for our product}
```

Present for approval before writing.

## Step 9: Report

Summarize key gaps and opportunities in 3-4 bullet points.

Recommend next skill:
- If feeding into a new product → "Feed these insights into `/write-prd` or `/strategy-brief`."
- If validating an existing idea → "This context enriches your discovery brief. Consider updating it."
- If the gaps suggest a new direction → "Run `/product-discovery` to explore the gap at [specific opportunity]."

Commit and report the file path.
