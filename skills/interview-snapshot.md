---
description: Create a structured interview snapshot from a single UXR transcript
allowed-tools: Bash, Read, Write, Edit, Glob, Grep, AskUserQuestion, Task
---

# /interview-snapshot — Interview Snapshot

You are processing a single UXR transcript into a structured interview snapshot based on the Product Talk interview snapshot format. This skill sits upstream of `/uxr-readout`: you process individual transcripts into snapshots, then later synthesize across snapshots.

**Hallucination guard — hard rules for the entire skill:**
1. **Transcript reference required.** Every extracted fact, quote, and timeline event must include a `> quote` block with verbatim text from the transcript.
2. **Self-check before presenting.** Before showing any extraction to the user, verify each item's source text exists verbatim in the transcript. Drop any item that can't be sourced.
3. **Inference flagging.** Anything not directly stated must be flagged `[inferred]` with the closest supporting quote. Pure extractions get no flag — the asymmetry makes inferences visually obvious.

## Step 1: Locate product repo

Determine the product repo:
- If the current directory is a product repo (has `prd/` directory), use it
- If the current directory is a code repo, read `.factory-config.json` for `productRepo`
- If unclear, ask the user which product repo to use

Ensure `research/interview-snapshots/` directory exists. If not, create it.

## Step 2: Get transcript

The transcript file path may be passed as an argument to this skill. If not, ask:

**"Which transcript should I process? Point me at a file."**

Glob `research/interview-transcripts/*.md` and present any matches as options. Read the full transcript once located.

## Step 3: Extract Quick Facts

Read through the transcript and extract factual details about the participant: occupation, experience level, league count, tools used, platform preferences, and any other demographic or behavioral facts.

For each fact:
- Include a verbatim quote block as evidence
- Flag anything not directly stated with `[inferred]` and include the closest supporting quote

Present the Quick Facts list to the user for confirmation. One question: **"Here are the Quick Facts I extracted. Anything to add, change, or remove?"**

## Step 4: Select Memorable Quote

Propose 3-5 candidate quotes from the transcript that evoke strong emotion, highlight unique behavior, or capture something essential about this participant.

Present them numbered and ask: **"Which of these best captures this participant? Or suggest a different one."**

## Step 5: Extract Overall Journey

Map key moments in the participant's history with the problem space, ordered chronologically by their life (not by interview order). Each event must include a supporting verbatim quote.

Present the journey to the user: **"Here's the journey I mapped. Anything to reorder, add, or cut?"**

## Step 6: Extract Current Workflow

Map the steps in the participant's current day-to-day process for the relevant activity. Each step must include a supporting verbatim quote.

Present the workflow: **"Here's their current workflow as I understood it. Anything to adjust?"**

## Step 7: Opportunities — user first

Ask: **"What opportunities or unmet needs did you notice in this interview?"**

Take the user's input, then find supporting verbatim quotes from the transcript for each opportunity they mention. Present the opportunities with quotes for confirmation.

## Step 8: Opportunities — skill fills gaps

After the user's opportunities are confirmed, propose additional opportunities you spotted in the transcript, **one at a time**. Each must include a supporting verbatim quote.

For each: **"I also noticed this opportunity: {opportunity}. Want to include it?"**

After presenting all candidates (or the user says enough), ask: **"Anything else I missed?"**

## Step 9: Insights — same pattern

Ask: **"Any other insights or notable learnings from this interview that aren't opportunities?"**

Take the user's input and find supporting quotes. Then propose additional insights one at a time with quotes, same pattern as Step 8.

## Step 10: Check for contradictions

Before assembling, scan the extracted data for internal contradictions:

- **Stated preferences vs. described behavior** — e.g., "I always check rankings" but workflow shows they skip that step
- **Inconsistent timeline events** — e.g., conflicting dates or sequences
- **Confidence followed by hedging** — e.g., strong assertion in one section undermined by qualifiers elsewhere

If contradictions are found, present them to the user: **"I noticed [X] here but [Y] here. Which reflects their actual situation?"**

Resolve each contradiction before proceeding:
- If the user clarifies, update the relevant extraction
- If the contradiction is genuine ambiguity (the participant truly holds both views), flag it with `[contradictory]` and include both quotes

## Step 11: Write snapshot

Assemble the full snapshot and present it for final review. Then write to `research/interview-snapshots/{participant-name}.md` where `{participant-name}` is a lowercase kebab-case name derived from the participant's name.

Output format:

```markdown
# Interview Snapshot: {Participant Name}

**Date:** {interview date}
**Transcript:** {relative path to source transcript}

## Quick Facts
- **{Label}:** {Value}
  > "{verbatim quote}" — transcript
- **{Label}:** {Value} [inferred]
  > "{supporting quote}" — transcript

## Memorable Quote
> "{Single powerful quote that captures something essential about this participant}"

## Experience Map

### Overall Journey
1. {Key moment in their history with the problem space}
   > "{supporting quote}" — transcript
2. ...

### Current Workflow
1. {Step in their current day-to-day process}
   > "{supporting quote}" — transcript
2. ...

## Opportunities

1. **{Opportunity}**
   > "{supporting quote}" — transcript
   {Brief context if needed}

## Insights

1. **{Insight}**
   > "{supporting quote}" — transcript
   {Brief context if needed}

## Contradictions
{Include this section only if contradictions were found in Step 10}

1. **{Contradiction summary}**
   > "{Quote A}" — transcript
   > "{Quote B}" — transcript
   **Resolution:** {How the user resolved it, or `[contradictory]` if genuine ambiguity}
```

Commit the file. Summarize the snapshot in 3-4 bullets.

Recommend next step:
- If more transcripts exist in `research/interview-transcripts/` that don't have snapshots yet → "Run `/interview-snapshot` on the next transcript."
- If enough snapshots have accumulated (3+) → "You have {N} snapshots. Run `/uxr-readout` to synthesize themes across them."
