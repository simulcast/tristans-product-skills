---
description: "Use when designing a feature, system, or internal process before building. Thinks through the idea collaboratively, makes consequential decisions, and produces a design doc the engineer can build from autonomously."
allowed-tools: Bash, Read, Write, Edit, Glob, Grep, AskUserQuestion, WebSearch, WebFetch, Task
---

# /design — Collaborative Feature Design

## Overview

Think through what to build and how, collaboratively. The output is a single design document in `designs/` that the engineer can build from autonomously — goals, architecture, decisions, and build order in one artifact.

This skill replaces the old two-step process (thought-partner + write-prd). One invocation, one artifact.

<HARD-GATE>
Do NOT invoke any implementation skill, write any code, scaffold any project, or take any implementation action until you have presented a design and the user has approved it. This applies to EVERY idea regardless of perceived simplicity.
</HARD-GATE>

## When to Use

- Designing a new feature before building it
- Setting up internal structures (processes, frameworks, systems)
- Clarifying thinking on a fuzzy idea
- Anything where the shape isn't obvious yet

## Anti-Pattern: "This Is Too Simple To Need A Design"

Every idea goes through this process. "Simple" ideas are where unexamined assumptions cause the most wasted work. The design can be short (Overview + Goals + Requirements + Decisions for truly simple ideas), but you MUST present it and get approval.

## Checklist

You MUST create a task for each of these items and complete them in order:

1. **Explore context** — check files, docs, prior decisions for relevant background
2. **Ask clarifying questions** — one at a time, understand purpose/constraints/success criteria
3. **Propose 2-3 approaches** — with trade-offs and your recommendation
4. **Present design** — scale to feature size, get user approval
5. **Self-critique** — before writing, critique the design from the engineer's perspective
6. **Write design doc** — save to `designs/<topic>.md` and commit
7. **Write journal entry** — capture what was decided in `journal/YYYY-MM-DD-<topic>.md`

## Process Flow

```
Explore context → Ask questions → Propose approaches → Present design → Self-critique → Write doc
                                                             ↑                |
                                                             └── revise ──────┘
                                         (at any point: break out to /playground)
```

**The terminal state is the design doc.** This skill ends with a written, committed design document. What happens next is up to the user — they may say "build it" or sit with it.

## Conversational Mechanics

1. **One question at a time.** Never ask multiple questions in one message. Break complex topics into sequential questions.
2. **Multiple choice preferred.** When you can reasonably anticipate the answer space, present 2-4 options. The user can always say something different. This forces the skill to do the thinking.
3. **Lead with your recommendation.** When proposing options, put your recommended option first and explain why. Don't be neutral when you have a view.
4. **Interpret, don't clarify.** When the user says something vague, propose a specific interpretation rather than asking "what do you mean?" Let them correct you — it's faster.
5. **Validate incrementally.** Present each section for approval before moving on. Don't dump a complete artifact at the end.
6. **YAGNI ruthlessly.** Actively resist scope creep. If something feels like a v2 feature, say so.
7. **Push back.** If the idea is vague or the reasoning is shaky, say so.
8. **Match the user's energy.** Sometimes this is a focused 5-question session, sometimes it's a long winding conversation. Both are fine.

## The Process

### 1. Explore context

Before asking any questions, read relevant files:
- `context/product.md` — current product state
- `MEMORY.md` — settled decisions and open questions
- Any existing designs in `designs/` that relate to the topic
- Relevant research in `research/` or strategy in `strategy/`

Summarize what you found that's relevant. Ask if there's context you're missing.

### 2. Ask clarifying questions

One at a time. Focus on understanding:
- **Purpose** — what problem does this solve? For whom?
- **Constraints** — what's fixed vs. flexible? Timeline, tech, scope?
- **Success criteria** — how do we know this worked?
- **Edge cases** — what's the weird stuff?

Push back on implementation details during this phase: "That's a 'how' — what's the 'what'?"

### 3. Propose approaches

- Propose 2-3 different approaches with trade-offs
- Lead with your recommended option and explain why
- Present options conversationally, not as a formal matrix

### 4. Present design

Scale to the feature's complexity:

**Small features** (theme toggle, bug fix pattern, internal process): present the full design in one pass. Overview + Goals + Requirements + Decisions. Ask "does this look right?"

**Large features** (new capability, system architecture, multi-component work): present section by section, get approval on each before moving on.

At any point during this phase, either party can say "let's playground this" and break out to `/playground` to make an interaction model tangible. Playgrounds go in `designs/playgrounds/<topic>.html` and get referenced in the design doc.

### 5. Self-critique

Before writing the design doc, critique it from the engineer's perspective:
- What would trip me up during build?
- Are there ambiguous edge cases?
- Are there decisions that feel decided but aren't in the Decisions table?
- Is the build order clear — do I know what to build first?
- Are load-bearing decisions distinguished from flexible ones?

Present the critique. Incorporate feedback. This step is what makes designs buildable on the first shot.

### 6. Write the design doc

Save to `designs/<topic>.md` (no dates — designs are living documents). Commit.

### 7. Write journal entry

Capture what was decided in `journal/YYYY-MM-DD-<topic>.md`. What happened, key decisions, what surprised you. Commit.

## The Artifact Template

```markdown
# <Feature Name>

## Overview
One paragraph: who, what, why. The user problem and why it matters now.

## Goals
What success looks like. Observable or measurable.

## Non-Goals
What this deliberately isn't. Prevents scope creep during build.

## Requirements
What the system does. Adapts to the feature:
- User-facing behavior for UI features (what the user can do, what the system shows)
- System behavior for backend work (inputs, outputs, triggers)
- Edge cases inline with each requirement

## Architecture
How the pieces connect. Diagram for anything non-trivial.

## Schema
Data model. Precise — hardest thing to change later. (Skip if N/A.)

## Component Tree
What the pieces are and how they nest. (Skip if N/A.)
- UI components for frontend work
- Services/routes/modules for backend work

## Build Order
Dependency chain. 3-5 lines. What to build first and why.

## Decisions
| Decision | Choice | Rationale | Weight |
|---|---|---|---|
| ... | ... | ... | load-bearing / flexible |

Load-bearing = requires approval to change during build.
Flexible = engineer can adapt without checking in.

## References
Links to playground HTML, research, strategy docs that informed the design.
```

**Sections scale to complexity.** A small feature might be just Overview + Goals + Requirements + Decisions. The Decisions table is always present — even simple features have choices worth recording.

## Design Lifecycle

- **During build:** living document. Engineer updates when deviating, with a note about why.
- **After ship:** frozen. Becomes a record of what was actually built.

## Anti-Patterns

- **Don't skip the questioning phase.** Even if the user gives a detailed brief upfront, probe for what's missing. The value is in the questions, not just the artifact.
- **Don't generate placeholder content.** Every line in the output should reflect a real decision made during the conversation. No "[TBD]" or "describe your approach here."
- **Don't present the full artifact at the end.** Build it incrementally, section by section, with validation at each step.
- **Don't over-structure.** If a question has an obvious answer in context, skip it. The process is a guide, not a script.
- **Don't skip the self-critique.** The engineer reading this design is also you. If you wouldn't be able to build from it autonomously, it's not done.

## Evidence Integrity

When the design draws on research (UXR, competitive analysis, analytics):

1. **Source-lock claims.** Every factual assertion includes a source reference (participant name, file name). No floating claims.
2. **Distinguish frequency from unanimity.** State N of M (e.g., "4 of 6 participants"). Never say "users want X" when 3 of 7 mentioned it.
3. **Flag cross-source inferences.** When connecting dots across sources, mark it and show the supporting evidence.
