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
| UXR readouts | `research/` | `uxr-{topic}.md` |
| Engagement analysis | `research/` | `engagement-{YYYY-MM-DD}.md` |
| Revenue analysis | `research/` | `revenue-{YYYY-MM-DD}.md` |
| Decisions (ADRs) | `decisions/` | `ADR-{NNN}-{short-kebab-title}.md` |

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

/analyze-engagement ─┐
/analyze-revenue ────┤──→ /prioritize ──→ /product-discovery or /write-prd
/uxr-readout ────────┘

/decide ──→ decisions/ (resume current work)
```

Skills should end with: "Based on what we produced, I'd suggest running
`/{next-skill}` next. Would you like to do that now?"

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

## Downstream Pipeline (Advanced)

These product skills can feed into an engineering pipeline for autonomous implementation:
- **Scenarios:** PRDs can be converted to structured Given/When/Then scenarios
- **Implementation specs:** Scenarios can be expanded into full architecture documents
- **Autonomous agents:** Implementation specs enable agents to build without human involvement
- **Satisfaction scoring:** Implementations can be scored against scenarios

These capabilities require additional tooling beyond the product skills in this repo.
