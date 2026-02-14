---
description: Articulate a strategic thesis with key bets and kill conditions
allowed-tools: Bash, Read, Write, Edit, Glob, Grep, AskUserQuestion, WebSearch, WebFetch, Task
---

# /strategy-brief — Strategy Brief

You are guiding the user through creating a strategy brief — a compressed, high-conviction document that captures a strategic bet. This is for big-picture thinking, not feature specs.

## Step 1: Locate product repo

Determine the product repo:
- If the current directory is a product repo (has `prd/` directory), use it
- If the current directory is a code repo, read `.factory-config.json` for `productRepo`
- If unclear, ask the user which product repo to use

Ensure `strategy/` directory exists. If not, create it.

## Step 2: Read conventions

Read `~/.claude/product-skill-conventions.md` for the shared conventions. Follow all conversational mechanics throughout this skill.

## Step 3: Check for existing context

Glob `research/discovery-*.md` and `strategy/*.md` in the product repo. If relevant documents exist, read them and summarize: "I found these related documents: [list]. Should I incorporate any of this context?"

## Step 4: What's the thesis?

Ask: **"What's the thesis? Force it into one sentence: 'We believe [X] because [Y].'"**

This is the hardest and most valuable step. If the user can't compress it, help them:
- Listen to their explanation
- Propose a compressed version
- Iterate until they agree it captures the core belief

The thesis must be falsifiable — you should be able to imagine evidence that would disprove it.

## Step 5: What's the key bet?

Ask: **"What's the ONE assumption that, if wrong, kills this? Not a list — the single riskiest belief."**

If they list multiple, ask: "Which one would you test first?" Force a single answer. The key bet is the assumption where being wrong means the whole strategy collapses, not just a feature.

## Step 6: What are you NOT doing?

Ask: **"What are you explicitly NOT doing? What adjacent things might someone expect you to build that you're choosing to skip?"**

Propose some anti-goals if you can infer them from the thesis. Anti-goals prevent scope creep and signal strategic clarity.

## Step 7: Time horizon

Ask: **"How long before you know if this is working?"**

Present options:
1. **1 week** — quick experiment, can validate fast
2. **1 month** — needs some usage data
3. **1 quarter** — strategic initiative, needs time to play out
4. **Longer** — foundational bet, won't know for a while

## Step 8: Success indicator

Ask: **"How will you know it worked? Give me one leading indicator — not a lagging metric. Not 'revenue' — something you can observe in the first week/month."**

Push back on vanity metrics (page views, signups without activation). Push toward behavioral indicators (users doing X, returning to Y, completing Z).

## Step 9: Kill condition

Ask: **"What kills this? Not 'everything goes wrong' — the specific, most likely failure mode."**

This should pair with the key bet from Step 5. If the key bet is wrong, this is how you'd notice. Make it specific and observable.

## Step 10: Write the strategy brief

Write to `strategy/{topic}.md` where `{topic}` is a kebab-case slug.

Structure:
```markdown
# Strategy: {Topic}

**Date:** {YYYY-MM-DD}
**Status:** active

## Thesis
{One sentence: "We believe [X] because [Y]."}

## Key Bet
{The single riskiest assumption}

## Anti-Goals
{What we are explicitly NOT doing}
- {Anti-goal 1}
- {Anti-goal 2}
- ...

## Time Horizon
{How long before we know}

## Success Indicator
{One leading indicator}

## Kill Condition
{The specific failure mode that would make us stop}
```

Present the brief to the user for final approval before writing.

## Step 11: Report

Summarize the strategy brief: thesis, key bet, time horizon.

Recommend next skill:
- If the key bet needs validation → "I'd suggest `/assumption-test` to test the key bet before building."
- If ready to build → "This is clear enough for a PRD. Run `/write-prd` to spec out the highest-priority bet."
- If the landscape is unclear → "Consider `/competitive-analysis` to see who else is making similar bets."

Commit the brief and report the file path.
