---
description: Explore and validate a product idea through structured discovery
allowed-tools: Bash, Read, Write, Edit, Glob, Grep, AskUserQuestion, WebSearch, WebFetch, Task
---

# /product-discovery — Product Discovery

You are guiding the user through structured product discovery. The goal is to take a raw idea, hunch, or observation and turn it into a crisp discovery brief that can feed into the factory pipeline.

## Step 1: Locate product repo

Determine the product repo:
- If the current directory is a product repo (has `prd/` directory), use it
- If the current directory is a code repo, read `.factory-config.json` for `productRepo`
- If unclear, ask the user which product repo to use

Ensure `research/` directory exists. If not, create it.

## Step 2: Read conventions

Read `~/.claude/product-skill-conventions.md` for the shared conventions. Follow all conversational mechanics throughout this skill.

## Step 3: What's the spark?

Ask the user: **"What's the spark? What observation, frustration, or hunch brought this to mind?"**

This is open-ended — let the user ramble. This is raw input. Listen for:
- Pain points (frustration with existing tools/processes)
- Opportunities (untapped market, new technology)
- Hunches (gut feel that something could be better)

Summarize what you heard back to the user in 2-3 sentences. Let them correct you.

## Step 4: Who has this problem?

Ask: **"Who has this problem?"**

Sketch a persona. If you can infer one from the spark, propose it:
- Role / context
- How often they encounter this pain
- What matters to them

Present the persona card and let the user refine it.

## Step 5: What do they do today?

Ask: **"What do they do today? How do they cope without your solution?"**

This reveals the real competition — often spreadsheets, manual processes, or nothing at all. The current workaround is the baseline your solution must beat.

## Step 6: What would solved look like?

Ask: **"What would 'solved' look like? Describe the observable outcome, NOT the solution."**

Push back if the user jumps to features. Say: "That's a solution — what's the outcome the user experiences?" You want the end state, not the mechanism.

## Step 7: How big is this?

Ask: **"How big is this?"**

Present options:
1. **Personal tool** — solving your own problem
2. **Small audience** — a niche group you understand well
3. **Broad market** — lots of people have this problem

This determines the appropriate level of investment in validation.

## Step 8: Known vs unknown

Ask: **"What do you already know for sure vs. what are you assuming?"**

Help the user separate validated knowledge from assumptions. This directly feeds `/assumption-test`. Present the split:
- **Known:** things backed by evidence or direct experience
- **Assumed:** things that feel true but haven't been tested

## Step 9: Optional competitive scan

Ask: **"Want me to do a quick competitive scan of this space?"**

If yes:
1. Use the Task tool to spawn a subagent with WebSearch to research the competitive landscape
2. The subagent should search for existing products/tools in the space
3. Present a brief summary of what exists: key players, their approach, obvious gaps
4. Ask: "Does this change your thinking about the idea?"

If no, skip to Step 10.

## Step 10: Write the discovery brief

Write the discovery brief to `research/discovery-{topic}.md` where `{topic}` is a kebab-case slug derived from the idea.

Structure:
```markdown
# Discovery: {Topic}

**Date:** {YYYY-MM-DD}
**Status:** draft

## Spark
{What brought this to mind}

## Persona
{Who has this problem — role, context, frequency}

## Current State
{How they cope today}

## Desired Outcome
{What "solved" looks like — observable outcomes}

## Scale
{Personal tool / small audience / broad market}

## Known vs Unknown

### Known
{Validated knowledge}

### Unknown
{Assumptions to test}

## Competitive Context
{What exists in this space — if scanned}
```

Present the brief to the user for final approval before writing.

## Step 11: Report

Summarize the discovery brief in 3-4 bullet points.

Recommend the next skill based on the idea's maturity:
- High uncertainty (many unknowns) → "I'd suggest running `/assumption-test` next to de-risk the key assumptions."
- Clear enough for a PRD → "This seems well-understood. Ready for `/write-prd`?"
- Need market context → "Consider running `/competitive-analysis` to understand the landscape better."
- Big-picture strategic bet → "This feels like a strategic bet. `/strategy-brief` would help articulate the thesis."

Commit the discovery brief and report the file path.
