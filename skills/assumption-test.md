---
description: Design and interpret assumption tests to de-risk product ideas
allowed-tools: Bash, Read, Write, Edit, Glob, Grep, AskUserQuestion, WebSearch, WebFetch, Task
---

# /assumption-test — Assumption Testing

You are guiding the user through designing or interpreting assumption tests. This skill has TWO modes:
- **Planning mode** — before tests: extract assumptions, design tests, set thresholds
- **Interpreting mode** — after tests: tag results, recommend next steps

Determine which mode by asking the user.

## Step 1: Locate product repo

Determine the product repo:
- If the current directory is a product repo (has `prd/` directory), use it
- If the current directory is a code repo, read `.factory-config.json` for `productRepo`
- If unclear, ask the user which product repo to use

Ensure `research/` directory exists. If not, create it.

## Step 2: Read conventions

Read `~/.claude/product-skill-conventions.md` for the shared conventions. Follow all conversational mechanics throughout this skill.

## Step 3: Determine mode

Ask: **"Are we designing tests for assumptions (planning), or interpreting results from tests you've already run?"**

Present options:
1. **Planning** — I have an idea/brief and want to figure out what to test
2. **Interpreting** — I ran the tests and have results to analyze

---

## Planning Mode

### Step 4P: What are we testing?

Ask: **"What are we testing? Point me at a discovery brief, strategy brief, or describe the idea."**

If they point at a file, read it. If they describe the idea, capture it.

### Step 5P: Extract assumptions

Read the input and list ALL assumptions — both stated and unstated. Present them grouped:

**Desirability assumptions** ("Users want X")
- Tag each as `stated` (explicitly in the doc) or `unstated` (inferred by you)

**Feasibility assumptions** ("We can build Y")
- Tag each as `stated` or `unstated`

**Viability assumptions** ("Users will pay Z")
- Tag each as `stated` or `unstated`

Present the full list and ask: "Did I miss anything? Are any of these wrong?"

### Step 6P: Rank by risk

Ask: **"Which of these feel riskiest to you?"**

Present the list and let the user react. Then propose a force-ranking using this lens: "If this assumption is wrong, does the whole idea collapse (critical) or just a feature (moderate)?"

Present the ranked list for validation. Focus on the top 2-3 critical assumptions.

### Step 7P: Design tests

For each of the top 2-3 riskiest assumptions, design a test:

**What evidence would confirm or kill this?**
Be specific: "3 of 5 users mention this pain unprompted" not "users like it."

**What's the cheapest test?** Present options per test:
1. **User conversations** — 5 interviews with target users
2. **Landing page** — fake door test to gauge interest
3. **Data analysis** — mine existing data for signals
4. **Prototype** — clickable mock to test interaction
5. **Competitive proxy** — does someone else already solve this?

**Decision threshold** — What result means GO vs KILL vs PIVOT?
Force a concrete number or criterion, not "feels right."

### Step 8P: Plan test materials

Help plan the test based on the chosen method:
- **Interviews:** Draft an interview script (5-7 questions, open-ended, no leading questions)
- **Landing page:** Draft the copy and CTA
- **Data analysis:** Describe the query or data pull needed
- **Prototype:** Describe what to mock up and what to observe
- **Competitive proxy:** Identify which competitors to study

### Step 9P: Write the test plan

Write to `research/assumption-test-{topic}.md`.

Structure:
```markdown
# Assumption Test: {Topic}

**Date:** {YYYY-MM-DD}
**Status:** planned
**Source:** {link to discovery/strategy brief if applicable}

## Assumptions

### Critical
1. {Assumption} — `stated` / `unstated`
2. ...

### Moderate
1. {Assumption} — `stated` / `unstated`
2. ...

## Tests

### Test 1: {Assumption being tested}
- **Method:** {interviews / landing page / data analysis / prototype / competitive proxy}
- **Evidence threshold:** {specific, measurable criterion}
- **GO if:** {concrete result}
- **KILL if:** {concrete result}
- **PIVOT if:** {concrete result}

### Test 2: ...

## Test Materials
{Interview scripts, landing page copy, data queries, etc.}

## Results
(To be filled in after running tests)
```

Present for approval before writing.

### Step 10P: Report

Summarize: what's being tested, how, and what the decision thresholds are.

Recommend: "Go run these tests, then come back and run `/assumption-test` again in interpreting mode."

Commit and report the file path.

---

## Interpreting Mode

### Step 4I: Load the test plan

Ask: **"Which assumption test should I look at?"**

Glob `research/assumption-test-*.md` and present options. Read the test plan.

### Step 5I: Collect results

For each test in the plan, ask: **"What happened with [test name]? What did you learn?"**

One test at a time. Capture the raw results.

### Step 6I: Tag assumptions

For each assumption that was tested, tag it:
- **Validated** — evidence supports the assumption
- **Invalidated** — evidence contradicts the assumption
- **Inconclusive** — the test wasn't sharp enough or results were mixed

Present the tagged list for validation.

### Step 7I: Interpret and recommend

For each tag:

**Validated:** "This de-risks the idea. Ready to move forward on this dimension."

**Invalidated:** "This is a pivot point. Options:"
1. Pivot the idea (reframe around what IS true)
2. Narrow the scope (maybe the assumption holds for a subset)
3. Kill it entirely (the core bet is wrong)

**Inconclusive:** "The test wasn't sharp enough. Here's a better test:" — propose a redesigned test with clearer thresholds.

### Step 8I: Update the test plan

Use the Edit tool to update `research/assumption-test-{topic}.md`:
- Fill in the Results section with findings and tags
- Update status to `completed`
- If a discovery brief exists for this topic, update its Known/Unknown section

### Step 9I: Report

Summarize: validated / invalidated / inconclusive counts.

Recommend next skill:
- All critical assumptions validated → "This is de-risked. Run `/write-prd` to spec it out."
- Key assumption invalidated → "Time to reframe. Run `/product-discovery` to explore a different angle, or consider killing this idea."
- Inconclusive → "Redesign the test and try again. The current test plan has been updated with suggestions."

Commit and report the file path.
