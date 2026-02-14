---
description: Stack-rank competing priorities using structured evaluation
allowed-tools: Bash, Read, Write, Edit, Glob, Grep, AskUserQuestion, WebSearch, WebFetch, Task
---

# /prioritize — Priority Stack Ranking

You are guiding the user through a structured prioritization exercise. The goal is to take a set of competing ideas, features, or initiatives and produce a defensible ranked stack.

## Step 1: Locate product repo

Determine the product repo:
- If the current directory is a product repo (has `prd/` directory), use it
- If the current directory is a code repo, read `.factory-config.json` for `productRepo`
- If unclear, ask the user which product repo to use

Ensure `strategy/` directory exists. If not, create it.

## Step 2: Read conventions

Read `~/.claude/product-skill-conventions.md` for the shared conventions. Follow all conversational mechanics throughout this skill.

## Step 3: Gather candidates

Ask: **"What are the candidates we're prioritizing?"**

Also check the repo for existing ideas:
- Glob `research/discovery-*.md` for discovery briefs
- Glob `prd/*.md` (excluding `README.md`) for existing PRDs
- Glob `strategy/*.md` (excluding `README.md`) for strategy briefs

If found, present them: "I found these existing candidates in the repo: [list]. Anything to add or remove?"

Let the user finalize the candidate list. Aim for 3-8 candidates — fewer is trivial, more needs pre-filtering first.

## Step 4: Constraints

Ask: **"What are your constraints right now?"**

Present options (can pick multiple):
1. **Time** — "I have N weeks/months"
2. **Money** — "Budget is X"
3. **Strategic** — "I need to prove Y" (e.g., product-market fit, revenue, growth)
4. **Learning** — "I need to figure out Z" (e.g., whether users want this)

These constraints shape which dimensions matter most.

## Step 5: Evaluation dimensions

Ask: **"Which dimensions matter most for this decision?"**

Propose defaults, let the user adjust:
1. **Revenue impact** — Will this make money? How much, how fast?
2. **User pain** — How much does the current state hurt users?
3. **Strategic fit** — Does this align with where you're heading?
4. **Build cost** — How much effort to build and maintain?
5. **Learning value** — Will building this teach you something important?

Let the user weight these (pick top 3, or assign weights). Not all dimensions need to be used.

## Step 6: Score candidates

For each candidate on each chosen dimension, propose a score (high / medium / low) with a one-line rationale.

Present as a table:

| Candidate | Revenue Impact | User Pain | Strategic Fit | Build Cost | Learning |
|-----------|---------------|-----------|---------------|------------|----------|
| {A} | high — {why} | med — {why} | high — {why} | low — {why} | med — {why} |
| {B} | ... | ... | ... | ... | ... |

Ask: **"Any scores you disagree with?"**

Let the user adjust. They have context you don't.

## Step 7: Present the ranked stack

Weight the scores by the user's chosen dimensions. Present the ranking:

1. **{Top pick}** — Score: X. {One-line rationale for why it's #1}
2. **{Second}** — Score: Y. {Why it's #2, what separates it from #1}
3. ...

Explain why #1 beats #2 specifically.

## Step 8: Pressure test

Ask: **"If you could only do ONE of these in the next [time horizon from constraints], is {#1} still your choice?"**

This catches gut-feel disagreements with the analytical ranking. If the user picks differently, explore why:

"You picked {X} over {Y} despite the ranking. What does your gut know that the scoring missed?"

Reconcile the difference — update scores or acknowledge that the user's judgment adds a dimension the scoring didn't capture.

## Step 9: Write the priority stack

Write to `strategy/priorities-{YYYY-MM-DD}.md`.

Structure:
```markdown
# Priorities — {YYYY-MM-DD}

**Constraints:** {time/money/strategic/learning — from Step 4}

## Candidates
{Numbered list of all candidates considered}

## Dimensions & Weights
| Dimension | Weight |
|-----------|--------|
| {dim} | {weight or rank} |

## Scoring Matrix

| Candidate | {Dim 1} | {Dim 2} | {Dim 3} | Weighted |
|-----------|---------|---------|---------|----------|
| {A} | {score} | {score} | {score} | {total} |
| {B} | ... | ... | ... | ... |

## Ranked Stack

### 1. {Top Pick}
**Why:** {rationale — why this beats #2}

### 2. {Second}
**Why:** {rationale}

### 3. ...

## Pressure Test
**Gut check:** {Did the user agree with #1? If not, what was reconciled?}

## Deferred Items
{What was deprioritized and when to revisit}
- {Item}: revisit after {trigger or date}
```

Present for approval before writing.

## Step 10: Report

Summarize: "Your top priority is {X}."

Recommend next skill based on the top pick's maturity:
- New idea → "Run `/product-discovery` to flesh this out."
- Idea with unknowns → "Run `/assumption-test` to validate before building."
- Mature enough → "Run `/write-prd` to spec it out."
- Already has a PRD → "Run `/critique` or go straight to `/prd-to-scenarios`."

List deferred items and when to revisit.

Commit and report the file path.
