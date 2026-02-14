---
description: Adversarial PRD review — find weaknesses, propose fixes
allowed-tools: Bash, Read, Write, Edit, Glob, Grep, AskUserQuestion, WebSearch, WebFetch, Task
---

# /critique — PRD Critique

You are performing a structured adversarial review of a PRD. This is NOT back-and-forth exploration — it's a teardown that finds specific weaknesses and proposes concrete fixes.

## Step 1: Locate product repo

Determine the product repo:
- If the current directory is a product repo (has `prd/` directory), use it
- If the current directory is a code repo, read `.factory-config.json` for `productRepo`
- If unclear, ask the user which product repo to use

## Step 2: Read conventions

Read `~/.claude/product-skill-conventions.md` for the shared conventions.

## Step 3: Which PRD?

Ask: **"Which PRD should I review?"**

Glob `prd/*.md` (excluding `README.md`). If only one exists, propose using it. Read the full PRD.

## Step 4: Run the teardown

Check for these specific weaknesses:

### Missing personas
Are there users who'd interact with this that aren't listed? Think about: admin users, new users vs power users, users who are affected but don't directly use the feature.

### Unstated assumptions
What does the PRD take for granted? Technical feasibility, user behavior patterns, market conditions, existing infrastructure, data availability.

### Vague outcomes
Any requirement that isn't observable? "Improved experience" is vague. "User sees confirmation within 2 seconds" is concrete. Check every "Then" clause and requirement for observability.

### Scope creep
Any requirement that feels like a v2 feature sneaking into v1? Look for words like "also," "additionally," "in the future," or features that aren't essential to the core JTBD.

### Missing edge cases
What happens when things go wrong? Check for: empty states, error states, permission boundaries, concurrent access, data limits, offline/degraded modes.

### Unclear success criteria
Could two people read this PRD and build different things? If yes, the ambiguity needs to be resolved.

### Contradictions
Do any requirements conflict with each other? Do personas have conflicting needs that aren't acknowledged?

### Missing non-goals
Are there obvious adjacent features that should be explicitly excluded?

## Step 5: Present findings by severity

Present findings in three tiers:

**Blocking** (must fix before `/prd-to-scenarios`):
- Contradictions between requirements
- Missing core personas
- Requirements that can't be implemented as written
- Ambiguities that would produce different implementations

**Worth discussing** (should fix):
- Vague outcomes that could be made concrete
- Unstated assumptions that should be explicit
- Potential scope creep items
- Missing edge cases

**Minor** (nice to fix):
- Style issues
- Missing non-goals
- Optional clarifications

For each finding, **propose a specific rewrite** — not just "this is vague" but "change X to Y."

## Step 6: Address findings

Ask: **"Which of these should we address now?"**

Let the user pick which findings to fix. They may defer some to later.

For each selected finding:
1. Present the proposed rewrite
2. Let the user approve or modify it
3. Use the Edit tool to update the PRD in-place

## Step 7: Report

Summarize:
- Total findings: N blocking, M worth discussing, K minor
- Changes made: list the specific edits applied
- Deferred items: list findings the user chose not to address

Recommend:
- If no blocking issues remain → "This PRD is ready for `/prd-to-scenarios`."
- If blocking issues were deferred → "Consider addressing [deferred blocking items] before generating scenarios."
- If scope seems large → "You might want to run `/scope-cut` to trim this to v1 essentials first."

Commit the updated PRD and report the file path.
