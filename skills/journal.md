---
description: Capture product insights, surprises, and decisions as structured journal entries for newsletter use
allowed-tools: Read, Write, Edit, Glob, Grep, AskUserQuestion
---

# /journal — Product Journal

You are capturing a journal entry — a structured record of what happened, what surprised the user, and what insight emerged. Journal entries are raw material for newsletter writing.

This skill has two modes:
- **Manual:** The user invoked `/journal` directly. Infer context from the current session.
- **Auto:** A product skill just finished and the conventions triggered this. You know which skill and what artifact was produced.

## Step 1: Locate product repo

Determine the product repo:
- If the current directory is a product repo (has `prd/` directory), use it
- If the current directory is a code repo, read `.factory-config.json` for `productRepo`
- If unclear, ask the user which product repo to use

Ensure `journal/` directory exists. If not, create it.

## Step 2: Gather context

Read the session context silently — do NOT dump a summary to the user. Note:
- What skills were used this session
- What files were created or modified
- What decisions were made
- What artifact was produced (if auto-triggered)

Optionally, check if `~/Documents/writing/zero-dependencies/docs/content-strategy-design.md` exists. If it does, read the content pillars (Discovery, Build, Operate, Reflect) to inform your pillar suggestion. If it doesn't exist, use these defaults:
- **discovery** — research, validation, deciding what to build
- **build** — development, technical decisions, shipping
- **operate** — time management, scope, process
- **reflect** — mistakes, surprises, belief updates

## Step 3: Ask what surprised you

Ask: **"What surprised you?"**

This is the one thing Claude cannot infer. Let the user answer freely. If the user says "nothing" or gives a short answer, accept it — don't push.

## Step 4: Ask what you'd do differently

Ask: **"What would you do differently?"**

Accept "nothing" as a valid answer. Don't press.

## Step 5: Draft the entry

Draft the full journal entry. Use the session context for "What happened" and "Raw material." Use the user's answers for "What surprised you" and "What I'd do differently." Draft "The insight" yourself — this is the transferable principle, the thing a newsletter reader would care about.

Choose a slug — a short kebab-case identifier for the entry (e.g., `competitive-landscape`, `prd-first-draft`, `trade-analyzer-scope`).

Suggest a pillar tag based on what happened:
- Research, validation, user interviews → `discovery`
- Implementation, technical choices, shipping → `build`
- Time management, scoping, process decisions → `operate`
- Mistakes, surprises, belief changes → `reflect`

Suggest 2-4 freeform tags based on content.

Determine the trigger:
- If auto-triggered by a product skill, use that skill name (e.g., `/product-discovery`)
- If manually invoked, use `/journal`

Present the full draft to the user:

```
---
date: {YYYY-MM-DD}
slug: {slug}
pillar: {pillar}
trigger: {trigger}
tags: [{tag1}, {tag2}]
---

## What happened
{Claude-drafted summary}

## What surprised you
{User's answer}

## The insight
{Claude-drafted transferable principle}

## What I'd do differently
{User's answer}

## Raw material
{Relevant quotes, numbers, rough thoughts from the session}
```

Ask: "Look good? I can adjust anything before saving."

## Step 6: Save the entry

After user approval, save to `journal/{YYYY-MM-DD}-{slug}.md`.

If a file with that name already exists, append a counter: `{YYYY-MM-DD}-{slug}-2.md`, `-3`, etc.

Do NOT git commit. Say: "Saved to `journal/{filename}`. Commit whenever you're ready."

If this was auto-triggered by a product skill, return control to the calling skill's wrap-up flow (next skill recommendation, etc.). If manual, you're done.
