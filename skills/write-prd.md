---
description: Guided PRD authoring with structured questioning and incremental validation
allowed-tools: Bash, Read, Write, Edit, Glob, Grep, AskUserQuestion, WebSearch, WebFetch, Task
---

# /write-prd — Guided PRD Authoring

You are guiding the user through writing a Product Requirements Document. You build the PRD incrementally, validating each section before moving on. The output follows the template in `prd/README.md`.

## Step 1: Locate product repo

Determine the product repo:
- If the current directory is a product repo (has `prd/` directory), use it
- If the current directory is a code repo, read `.factory-config.json` for `productRepo`
- If unclear, ask the user which product repo to use

Read `prd/README.md` for the PRD template.

## Step 2: Read conventions

Read `~/.claude/product-skill-conventions.md` for the shared conventions. Follow all conversational mechanics throughout this skill.

## Step 3: What are we building?

Ask: **"What are we building? Give me a name and a one-liner."**

Check for existing research:
- Glob `research/discovery-*.md` for discovery briefs
- Glob `research/competitive-*.md` for competitive analyses
- Glob `research/uxr-*.md` for UXR readouts
- Glob `strategy/*.md` for strategy briefs

If relevant docs exist, summarize findings and ask: "Should I incorporate these?"

## Step 4: Overview — why does this matter?

Ask: **"Why does this matter? What's the user problem?"**

Frame as JTBD (Jobs To Be Done): "When [situation], I want to [motivation], so I can [expected outcome]."

Draft the overview section using JTBD framing. Present it for validation.

## Step 5: Goals

Ask: **"What does success look like?"**

Propose 3-5 goals based on the overview. These should be measurable or at least observable. Present them and let the user add, remove, or modify.

## Step 6: Non-Goals

Ask: **"What are we explicitly NOT building?"**

Propose anti-goals based on what might be adjacent to the feature. This prevents scope creep downstream. Validate with the user.

## Step 7: Personas

Walk through each persona one at a time.

Ask: **"Who's the primary user?"**

For each persona, capture:
- Role and context
- Goals (what they're trying to accomplish)
- Pain points (what's hard today)
- Relevant characteristics

Present the persona card, validate, then ask: **"Anyone else?"**

Repeat for secondary personas. Stop when the user says no more.

## Step 8: Requirements

This is the bulk of the PRD. For each major capability:

Ask: **"What can the user do? Describe the observable behavior."**

For each capability:
1. What can the user do? (Actions/inputs)
2. What does the system do in response? (What the user sees)
3. What are the edge cases? (Empty states, errors, boundaries)

Present each capability section for validation before moving to the next.

Push back on implementation details: "That's a 'how' — what's the 'what' the user experiences?"

Continue until the user says all capabilities are covered.

## Step 9: Open Questions

Ask: **"What are we still unsure about?"**

Explicitly flag anything unresolved. These MUST be resolved before `/prd-to-scenarios` can run effectively. If you noticed ambiguities during the conversation, list them here.

## Step 10: Write the PRD

Write to `prd/{feature}.md` where `{feature}` is a kebab-case slug.

Follow the template from `prd/README.md`. The PRD should contain:
- Overview (JTBD framing)
- Goals
- Non-Goals
- Personas
- Requirements (organized by capability area)
- Open Questions

Present the complete PRD for final approval before writing.

## Step 11: Report

Summarize:
- Number of personas defined
- Number of capability areas covered
- Number of open questions flagged

Recommend: "Run `/critique` to stress-test this PRD before generating scenarios."

If open questions exist: "Resolve the open questions first — they'll cause ambiguous scenarios if left unaddressed."

Commit the PRD and report the file path.
