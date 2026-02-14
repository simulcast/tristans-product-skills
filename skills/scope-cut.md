---
description: Trim a PRD to v1 essentials by classifying capabilities
allowed-tools: Bash, Read, Write, Edit, Glob, Grep, AskUserQuestion, WebSearch, WebFetch, Task
---

# /scope-cut — Scope Cutting

You are guiding the user through scoping a PRD down to v1 essentials. The goal is to separate must-haves from nice-to-haves so the first version ships fast and focused.

## Step 1: Locate product repo

Determine the product repo:
- If the current directory is a product repo (has `prd/` directory), use it
- If the current directory is a code repo, read `.factory-config.json` for `productRepo`
- If unclear, ask the user which product repo to use

## Step 2: Read conventions

Read `~/.claude/product-skill-conventions.md` for the shared conventions. Follow all conversational mechanics throughout this skill.

## Step 3: Which PRD?

Ask: **"Which PRD should I scope?"**

Glob `prd/*.md` (excluding `README.md`). If only one exists, propose using it. Read the full PRD.

## Step 4: Extract capabilities

Read through the PRD and extract every distinct capability — every thing the user can do or the system provides.

Present the numbered list: **"I found N distinct capabilities. Does this look complete?"**

Let the user add or remove items.

## Step 5: Classify each capability

For each capability, ask: **"What's the cost of NOT having this in v1?"**

Present options:
1. **(a) Users can't use the product at all** — core dependency, everything breaks without it
2. **(b) Users can use it but will be frustrated** — important but not blocking
3. **(c) Users won't notice it's missing** — nice to have, not essential
4. **(d) It's a delight feature** — nice but not needed for the core value prop

You can batch related capabilities to move faster, but confirm each classification.

## Step 6: Propose the split

Based on the answers, propose a v1/v2/later split:
- **v1:** all (a) items + critical (b) items
- **v2:** remaining (b) items
- **Later:** all (c) and (d) items

Present with rationale for each placement. Let the user adjust.

## Step 7: Pressure test

Ask: **"If you could only ship 3 things from this list, which 3?"**

Compare the user's answer to the proposed v1 split. If there are differences, explore why: "You ranked [X] in your top 3 but it was classified as (b). Should it be in v1?"

Reconcile any differences.

## Step 8: Write the scope decision

Ask the user which format they prefer:
1. **Annotate inline** — Add `[v1]` / `[v2]` / `[later]` tags to the PRD requirements
2. **Separate scope doc** — Create `prd/{feature}-scope.md` with the split and rationale

For option 1: Use the Edit tool to add tags to the PRD in-place.
For option 2: Write a new scope document.

**Scope document structure** (if separate):
```markdown
# Scope: {Feature}

**Date:** {YYYY-MM-DD}
**PRD:** `prd/{feature}.md`

## v1 — Must Ship
{List with one-line rationale each}

## v2 — Next Iteration
{List with one-line rationale each}

## Later — Deferred
{List with one-line rationale each}

## Pressure Test
Top 3 if forced to choose: {list}
Reconciliation notes: {any adjustments made}
```

## Step 9: Report

Summarize: N items in v1, M in v2, K deferred.

Recommend: "Update the PRD to remove v2/later items (or mark them clearly), then run `/prd-to-scenarios` on the trimmed version."

If the PRD was annotated inline: "The PRD is annotated — `/prd-to-scenarios` should focus on `[v1]` items only."

Commit and report the file path.
