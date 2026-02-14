---
description: Record architecture or product decisions as ADRs
allowed-tools: Bash, Read, Write, Edit, Glob, Grep, AskUserQuestion, WebSearch, WebFetch, Task
---

# /decide — Decision Recording

You are guiding the user through making and recording a decision as an Architecture Decision Record (ADR). This skill helps structure the decision, evaluate trade-offs, and produce a durable record.

## Step 1: Locate product repo

Determine the product repo:
- If the current directory is a product repo (has `prd/` directory), use it
- If the current directory is a code repo, read `.factory-config.json` for `productRepo`
- If unclear, ask the user which product repo to use

Read `decisions/README.md` for the ADR template.

## Step 2: Read conventions

Read `~/.claude/product-skill-conventions.md` for the shared conventions. Follow all conversational mechanics throughout this skill.

## Step 3: What's the decision?

Ask: **"What's the decision?"**

Frame it as a question. If the user gives a statement ("I need to choose a database"), reframe: "Which database should we use for [context]?"

## Step 4: What are the options?

Ask: **"What are the options?"**

If the user has options, list them. If not, propose 2-3 based on context. Never more than 4 options — more than that means the decision isn't scoped enough.

## Step 5: What are the constraints?

Ask: **"What limits this decision?"**

Present options (can pick multiple):
1. **Timeline** — need to ship by a date
2. **Budget** — cost constraints
3. **Existing tech** — must integrate with current stack
4. **Team skills** — what the team knows
5. **Reversibility** — how hard to change later

## Step 6: Evaluate trade-offs

For each option, present a structured trade-off analysis:

| Dimension | Option A | Option B | ... |
|-----------|----------|----------|-----|
| Strengths | ... | ... | |
| Weaknesses | ... | ... | |
| Risks | ... | ... | |
| Reversibility | easy/medium/hard | ... | |

Present this table and let the user react.

## Step 7: Recommend

**Lead with your recommendation:**

"I'd go with [X] because [primary reason]. The main risk is [Y], but [mitigation]."

Be opinionated. Don't present options as equally valid if they aren't.

## Step 8: Record the decision

Let the user decide. If they pick a different option than your recommendation, don't argue — record their choice.

Find the next ADR number by globbing `decisions/ADR-*.md` and incrementing.

Write to `decisions/ADR-{NNN}-{short-kebab-title}.md`:

```markdown
# ADR-{NNN}: {Title}

**Date:** {YYYY-MM-DD}
**Status:** accepted

## Context
{What motivated this decision — the question and constraints}

## Decision
{What was chosen and why}

## Alternatives Considered
- **{Alternative A}:** {Strengths and weaknesses}
- **{Alternative B}:** {Strengths and weaknesses}

## Consequences
- {What becomes easier}
- {What becomes harder}
- {New constraints introduced}
```

Present for approval before writing.

## Step 9: Report

Summarize: "Recorded as ADR-{NNN}: {title}. Decision: {one-liner}."

If this decision was prompted by other work in progress: "Resuming — this decision unblocks [whatever prompted it]."

Commit and report the file path.
