# Product Skill Conventions

Shared conventions for all product management skills in this repo.
Every product skill (`/product-discovery`, `/write-prd`, `/critique`, etc.)
references this document.

## Conversational Mechanics

These rules govern how product skills interact with the user:

1. **One question at a time.** Never ask multiple questions in one message.
   Break complex topics into sequential questions.
2. **Multiple choice preferred.** When you can reasonably anticipate the
   answer space, present 2-4 options. The user can always say something
   different. This forces the skill to do the thinking.
3. **Lead with your recommendation.** When proposing options, put your
   recommended option first and explain why. Don't be neutral when you
   have a view.
4. **Interpret, don't clarify.** When the user says something vague,
   propose a specific interpretation rather than asking "what do you mean?"
   Let them correct you — it's faster than open-ended clarification.
5. **Validate incrementally.** Present each section/finding for approval
   before moving on. Don't dump a complete artifact at the end.
6. **YAGNI ruthlessly.** Actively resist scope creep. If the user adds
   something that feels like a v2 feature, say so.

## Output Locations

All artifacts go to the product repo. Determine the product repo using:
- If in a product repo → use it directly
- If in a code repo → read `.factory-config.json` for `productRepo`
- If unclear → ask the user

| Artifact Type | Directory | Naming Convention |
|--------------|-----------|-------------------|
| PRDs | `prd/` | `{feature}.md` |
| Strategy briefs | `strategy/` | `{topic}.md` |
| Priority stacks | `strategy/` | `priorities-{YYYY-MM-DD}.md` |
| Discovery briefs | `research/` | `discovery-{topic}.md` |
| Assumption tests | `research/` | `assumption-test-{topic}.md` |
| Competitive analysis | `research/` | `competitive-{space}.md` |
| Interview snapshots | `research/interview-snapshots/` | `{participant-name}.md` |
| UXR readouts | `research/` | `uxr-{topic}.md` |
| Engagement analysis | `research/` | `engagement-{YYYY-MM-DD}.md` |
| Revenue analysis | `research/` | `revenue-{YYYY-MM-DD}.md` |
| Decisions (ADRs) | `decisions/` | `ADR-{NNN}-{short-kebab-title}.md` |
| Journal entries | `journal/` | `{YYYY-MM-DD}-{slug}.md` |

## Subagent Patterns

Use the Task tool to spawn subagents for parallel research. Guidelines:
- **When to use:** Competitive research (one agent per competitor), data
  analysis (crunching files), synthesizing large volumes of text
- **When NOT to use:** Back-and-forth with the user (subagents can't do this),
  simple file reads, anything that needs user input
- **Structure:** Give subagents a focused research question and specific
  output format. They return findings; the main thread interprets with
  the user.
- **Parallelism:** Launch multiple subagents in a single message when
  researching independent topics (e.g., 4 competitors simultaneously)

## Pipeline Connections

After each product skill, recommend the logical next step:

```
/product-discovery ──→ /assumption-test ──→ /write-prd ──→ /critique ──→ /prd-to-scenarios
                  └──→ /competitive-analysis                         └──→ /scope-cut
                  └──→ /strategy-brief

/interview-snapshot (per transcript) ──→ /uxr-readout ──┐
/analyze-engagement ─────────────────────────────────────┤──→ /prioritize ──→ /product-discovery or /write-prd
/analyze-revenue ────────────────────────────────────────┘

/decide ──→ decisions/ (resume current work)
```

Skills should end with: "Based on what we produced, I'd suggest running
`/{next-skill}` next. Would you like to do that now?"

## Journal Capture

After completing the skill's primary artifact (the PRD, the discovery brief,
the competitive analysis, etc.), invoke the `/journal` skill to capture a
journal entry. This is not optional — every completed skill lifecycle should
produce a journal entry. The journal skill will ask the user 1-2 questions
and write the entry to `journal/` in the current product repo.

If the skill was abandoned mid-conversation (no primary artifact produced),
skip the journal step.

## The Iteration Loop

After shipping, enter a feedback loop:

1. **Collect signals** — Set up analytics, monitor revenue, gather feedback
2. **Analyze** — Run `/analyze-engagement`, `/analyze-revenue`, `/uxr-readout`
   at regular cadence (weekly or monthly)
3. **Prioritize** — When you have competing next steps, run `/prioritize`
4. **Build next** — Top priority feeds back into the discovery → PRD pipeline

Signals that trigger the loop:
- Engagement dropping on a key flow → investigate → PRD to fix
- Revenue plateauing → analyze → strategy brief on growth levers
- Users requesting the same thing repeatedly → validate assumption → PRD
- New hunch or opportunity → discovery → assumption test → PRD

## Anti-Patterns

- **Don't skip the questioning phase.** Even if the user gives a detailed
  brief upfront, probe for what's missing. The value is in the questions,
  not just the artifact.
- **Don't generate placeholder content.** Every line in the output should
  reflect a real decision made during the conversation. No "[TBD]" or
  "describe your approach here."
- **Don't present the full artifact at the end.** Build it incrementally,
  section by section, with validation at each step.
- **Don't assume.** If something is ambiguous, interpret and propose —
  but let the user confirm before proceeding.
- **Don't over-structure.** If a question has an obvious answer in context,
  skip it. The question flow is a guide, not a script.

## Evidence Integrity

These rules apply to any skill that synthesizes, analyzes, or interprets source material (research data, analytics, transcripts, etc.).

### Hallucination Guards for Synthesis

When combining evidence from multiple sources:

1. **Source-lock every claim.** Every factual assertion must include a parenthetical source reference (participant name, file name, data row). No floating claims.
2. **No Frankenquotes.** Never splice words from different sources into a single quote block. Use separate `> quote` blocks per source, even when they support the same theme.
3. **Distinguish frequency from unanimity.** Always state N of M (e.g., "4 of 6 participants"). Never say "users want X" when 3 of 7 mentioned it.
4. **Flag cross-source inferences.** When a finding requires connecting dots across sources rather than being stated directly, mark it `[cross-source inference]` with the supporting quotes from each source.

### Few-Shot Calibration

Before qualitative or quantitative analysis:

1. **Offer a scoring rubric.** Ask the user if they have existing categories/thresholds, or if you should propose defaults.
2. **Present 3-5 categories** with a one-line definition and one concrete example each (e.g., "Strong signal — user describes this as a blocker: 'I literally can't do my job without this'").
3. **Apply consistently.** Once calibrated, tag every data point against the rubric. Note ambiguity (`[ambiguous — could be X or Y]`) rather than force-fitting.

### Verification Pass

Before presenting final output, silently run a verification pass:

1. **Quote accuracy.** Confirm every quoted passage exists verbatim in the source material. Drop or fix any misquoted text.
2. **Within-source contradictions.** Check whether the same source supports contradictory claims. If so, surface both claims with context.
3. **Thin-evidence warnings.** Flag any finding supported by fewer than 2 sources with `[thin evidence]`. This is informational, not disqualifying.
4. **Silent execution.** Run this pass before presenting results. Only surface issues to the user if problems are found. Proceed silently if clean.

## Downstream Pipeline (Advanced)

These product skills can feed into an engineering pipeline for autonomous implementation:
- **Scenarios:** PRDs can be converted to structured Given/When/Then scenarios
- **Implementation specs:** Scenarios can be expanded into full architecture documents
- **Autonomous agents:** Implementation specs enable agents to build without human involvement
- **Satisfaction scoring:** Implementations can be scored against scenarios

These capabilities require additional tooling beyond the product skills in this repo.
