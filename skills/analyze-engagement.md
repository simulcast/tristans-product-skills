---
description: Analyze product engagement data and surface health signals
allowed-tools: Bash, Read, Write, Edit, Glob, Grep, AskUserQuestion, WebSearch, WebFetch, Task
---

# /analyze-engagement — Engagement Analysis

You are analyzing product engagement data to surface health signals, usage patterns, and actionable insights. This skill takes raw analytics data and produces an opinionated health assessment.

## Step 1: Locate product repo

Determine the product repo:
- If the current directory is a product repo (has `prd/` directory), use it
- If the current directory is a code repo, read `.factory-config.json` for `productRepo`
- If unclear, ask the user which product repo to use

Ensure `research/` directory exists. If not, create it.

## Step 2: Read conventions

Read `~/.claude/product-skill-conventions.md` for the shared conventions. Follow all conversational mechanics throughout this skill.

## Step 3: What data?

Ask: **"What data is this? What tool/source, what time range, what product?"**

Understand the data source: PostHog, Mixpanel, custom analytics, raw logs, spreadsheet export, etc.

## Step 4: Load the data

Ask: **"Point me at the data."**

User provides file path(s). Read and assess the schema/format. Summarize what you see: "I found [N rows/events] covering [date range] with fields [list]. Does this look right?"

## Step 5: What questions?

Ask: **"What questions do you have about this data?"**

Present options:
1. **"What's the overall health?"** — retention, activity trends, session patterns
2. **"Why is [metric] dropping?"** — investigate a specific decline
3. **"Which features are people actually using?"** — feature adoption analysis
4. **"Just tell me what's interesting."** — open exploration

Let the user pick one or more.

## Step 6: Analyze

Launch subagent(s) using the Task tool for analysis, depending on the question:

- **Overall health:** retention curves, DAU/WAU/MAU trends, session frequency
- **Feature adoption:** feature usage rates, feature-to-retention correlation
- **Drop investigation:** cohort comparison, funnel analysis, before/after
- **Open exploration:** all of the above

The subagent reads the data files and computes/summarizes metrics.

## Step 7: Present findings

Present findings with context:
- Key metrics with trend direction (up/down/flat)
- Comparisons (this week vs last, this cohort vs that)
- Anomalies or surprises

Format as tables where possible for clarity.

## Step 8: Interpret

Be opinionated — don't just present data, tell the user what it means:

"Here's what looks healthy / concerning / needs investigation."

Connect metrics to product health. A number is just a number; an interpretation is actionable.

## Step 9: Recommend product action

"Based on this data, I'd suggest [action]. Here's why."

Connect recommendations to specific metrics. Be concrete: "The onboarding funnel drops 40% at step 3 — simplify that step" not "improve onboarding."

## Step 10: Write the analysis

Write to `research/engagement-{YYYY-MM-DD}.md`.

Structure:
```markdown
# Engagement Analysis

**Date:** {YYYY-MM-DD}
**Data source:** {tool/source}
**Time range:** {start} to {end}
**Product:** {product name}

## Key Metrics

| Metric | Current | Previous | Trend |
|--------|---------|----------|-------|
| {metric} | {value} | {value} | {up/down/flat} |

## Findings

### {Finding 1}
{What the data shows, with supporting numbers}

### {Finding 2}
...

## Health Assessment
{Opinionated summary: what's healthy, what's concerning, what needs investigation}

## Recommended Actions
1. {Action with data-backed rationale}
2. {Action with data-backed rationale}
3. ...
```

Present for approval before writing.

## Step 11: Report

Summarize health signals and top recommendation.

Recommend next skill:
- If a feature needs fixing → "Run `/write-prd` to spec the fix for [issue]."
- If engagement is healthy → "No urgent action needed. Run this analysis again in [timeframe]."
- If trends are concerning → "Run `/product-discovery` to investigate why [metric] is declining."
- If competing fixes → "Run `/prioritize` to decide which engagement issue to tackle first."

Commit and report the file path.
