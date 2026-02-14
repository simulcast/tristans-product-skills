---
description: Analyze revenue data, identify growth levers, and assess business health
allowed-tools: Bash, Read, Write, Edit, Glob, Grep, AskUserQuestion, WebSearch, WebFetch, Task
---

# /analyze-revenue — Revenue Analysis

You are analyzing revenue and business metrics to assess financial health, identify growth levers, and recommend product actions that impact the bottom line.

## Step 1: Locate product repo

Determine the product repo:
- If the current directory is a product repo (has `prd/` directory), use it
- If the current directory is a code repo, read `.factory-config.json` for `productRepo`
- If unclear, ask the user which product repo to use

Ensure `research/` directory exists. If not, create it.

## Step 2: Read conventions

Read `~/.claude/product-skill-conventions.md` for the shared conventions. Follow all conversational mechanics throughout this skill.

## Step 3: Business model

Ask: **"What's the business model?"**

Present options:
1. **Subscription (MRR)** — monthly/annual recurring revenue
2. **One-time purchase** — pay once, use forever
3. **Usage-based** — pay per unit of consumption
4. **Freemium** — free tier + paid upgrades
5. **Marketplace** — take a cut of transactions

This determines which metrics matter most.

## Step 4: Load the data

Ask: **"Point me at the data."**

Stripe export, spreadsheet, database dump, CSV — whatever format. Read and assess.

Summarize what you see: "I found [N records] covering [date range] with [fields]. Does this look right?"

## Step 5: What's the question?

Ask: **"What time range, and what are you worried about? Or should I just give you the full picture?"**

## Step 6: Analyze

Launch subagent(s) using the Task tool for analysis, depending on business model:

**Subscription:**
- MRR and MRR growth rate
- Churn rate (monthly/annual)
- Expansion revenue (upgrades, add-ons)
- Cohort LTV
- Payback period

**One-time:**
- Revenue trend
- Average order value
- Repeat purchase rate

**Usage-based:**
- Revenue per user
- Usage trends
- Top accounts and concentration

**All models:**
- Conversion funnel (free → paid)
- Revenue concentration (what % comes from top 10% of customers)

## Step 7: Present findings

Present findings as tables:
- Revenue trajectory with trend (growing/flat/declining, rate)
- Key metrics with benchmarks where possible
- Risk indicators (churn acceleration, revenue concentration, declining LTV)

## Step 8: Interpret trajectory

Be direct about the trajectory:

"You're [growing/plateauing/declining] at [rate]. At this pace, [projection]."

Don't soften bad news — the user needs honest assessment to make good decisions.

## Step 9: Identify levers

"The highest-impact thing you could do is [X] because [data-backed reason]."

Rank 2-3 levers:
- **Reduce churn** — if churn is high relative to benchmarks
- **Increase conversion** — if the free-to-paid funnel leaks
- **Raise prices** — if LTV supports it and you're underpriced
- **Expand to new segment** — if current market is saturating
- **Increase usage** — if usage-based and consumption is flat

Each lever should reference specific numbers from the analysis.

## Step 10: Write the analysis

Write to `research/revenue-{YYYY-MM-DD}.md`.

Structure:
```markdown
# Revenue Analysis

**Date:** {YYYY-MM-DD}
**Data source:** {Stripe / spreadsheet / etc.}
**Time range:** {start} to {end}
**Business model:** {subscription / one-time / usage-based / freemium / marketplace}

## Key Metrics

| Metric | Current | Previous | Trend |
|--------|---------|----------|-------|
| {metric} | {value} | {value} | {up/down/flat} |

## Revenue Trajectory
{Growth rate, projection, comparison to benchmarks}

## Risk Indicators
- {Risk 1 with supporting data}
- {Risk 2 with supporting data}

## Growth Levers (ranked)

### 1. {Lever}
**Impact:** {estimated impact}
**Why:** {data-backed rationale}
**How:** {concrete next step}

### 2. {Lever}
...

## Detailed Findings
{Supporting analysis, cohort breakdowns, funnel data}
```

Present for approval before writing.

## Step 11: Report

Summarize trajectory and top lever in 2-3 sentences.

Recommend next skill:
- If a product change is needed → "Run `/write-prd` to spec [the product change that addresses the top lever]."
- If strategic pivot needed → "Run `/strategy-brief` to reframe the business approach."
- If need to understand users better → "Run `/uxr-readout` to understand why [metric] is [trending]."
- If multiple levers compete → "Run `/prioritize` to decide which lever to pull first."

Commit and report the file path.
