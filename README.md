# Product Management Skills for Claude Code

12 interactive skills that turn Claude Code into a PM partner.

These skills guide you through structured product management workflows — from initial discovery through PRD authoring, competitive analysis, and prioritization. Each skill is a conversational protocol: it asks you questions, challenges your thinking, and produces a concrete artifact.

## Skills

| Skill | What it does |
|-------|-------------|
| `/product-discovery` | Take a raw idea and turn it into a structured discovery brief |
| `/assumption-test` | Design tests to de-risk assumptions, or interpret test results |
| `/strategy-brief` | Articulate a strategic thesis with key bets and kill conditions |
| `/write-prd` | Guided PRD authoring with incremental validation |
| `/critique` | Adversarial PRD review — find weaknesses, propose fixes |
| `/scope-cut` | Trim a PRD to v1 essentials by classifying capabilities |
| `/decide` | Record architecture or product decisions as ADRs |
| `/competitive-analysis` | Research and compare competitors in a product space |
| `/uxr-readout` | Synthesize user research data into themes and actions |
| `/analyze-engagement` | Analyze product engagement data and surface health signals |
| `/analyze-revenue` | Analyze revenue data, identify growth levers |
| `/prioritize` | Stack-rank competing priorities using structured evaluation |

## How they work

Each skill is a structured conversation, not a template generator. When you run `/write-prd`, Claude doesn't dump a PRD template — it asks you questions one at a time, challenges vague answers, and builds the document incrementally with your approval at each step.

Key mechanics:
- **One question at a time** — no overwhelming multi-part prompts
- **Multiple choice when possible** — the skill does the thinking, you react
- **Opinionated recommendations** — Claude leads with its view, you adjust
- **Incremental validation** — each section is approved before moving on
- **Concrete artifacts** — every skill produces a file you can use downstream

## Install

```bash
git clone https://github.com/simulcast/tristans-product-skills.git
cd tristans-product-skills
./install.sh
```

This symlinks the skills into `~/.claude/commands/` so they show up as slash commands in Claude Code. Updates pull through automatically via `git pull`.

Use `./install.sh --copy` if you prefer copies over symlinks.

**Requirements:** [Claude Code](https://docs.anthropic.com/en/docs/claude-code/overview) (Claude Pro, Max, or Team plan).

## Set up a product repo

Skills write artifacts to a **product repo** — a directory with a standard structure for product work. Create one:

```bash
mkdir my-project-product
cd my-project-product
mkdir prd strategy research decisions
```

| Directory | What goes here |
|-----------|---------------|
| `prd/` | Product Requirements Documents |
| `strategy/` | Strategy briefs and priority stacks |
| `research/` | Discovery briefs, competitive analysis, UXR readouts, analytics |
| `decisions/` | Architecture Decision Records (ADRs) |

Then open Claude Code in that directory and start using skills.

## Quick start

```
cd my-project-product
claude

> /product-discovery
```

Claude will walk you through structured discovery: what's the spark, who has the problem, what do they do today, what would solved look like. At the end you get a discovery brief in `research/discovery-{topic}.md`.

## The workflow

Skills connect into a natural product development pipeline:

```
/product-discovery ──→ /assumption-test ──→ /write-prd ──→ /critique ──→ /scope-cut
                  └──→ /competitive-analysis
                  └──→ /strategy-brief

                                        Feedback loop:
/analyze-engagement ─┐
/analyze-revenue ────┤──→ /prioritize ──→ back to /product-discovery or /write-prd
/uxr-readout ────────┘

/decide ──→ record a decision at any point, resume current work
```

**Starting fresh?** Begin with `/product-discovery` to structure your idea.

**Have data?** Start with `/analyze-engagement`, `/analyze-revenue`, or `/uxr-readout` and let insights drive what to build next.

**Need to choose?** `/prioritize` helps when you have competing ideas.

**Making a call?** `/decide` records the decision so future-you remembers why.

## Uninstall

```bash
cd tristans-product-skills
./uninstall.sh
```

Only removes symlinks pointing back to this repo. Your other Claude Code commands are untouched. If the installer backed up any existing files, they'll be restored.

## FAQ

**What Claude plan do I need?**
Claude Pro, Max, or Team — anything that includes [Claude Code](https://docs.anthropic.com/en/docs/claude-code/overview).

**Can I customize the skills?**
Yes. If you installed with `--copy`, edit the files directly in `~/.claude/commands/`. If you used symlinks (the default), either switch to `--copy` mode or fork this repo and modify your fork.

**What's a product repo?**
A directory with `prd/`, `strategy/`, `research/`, and `decisions/` subdirectories. Skills auto-detect it and write artifacts to the right place. It's just a convention — no config files or special tooling required.

**Do I need the full factory pipeline?**
No. These skills work standalone. The full pipeline (scenario generation, implementation specs, autonomous agents, satisfaction scoring) requires additional tooling not included here.

**Can I use these with other AI coding tools?**
These skills are designed for Claude Code's slash command system. They use Claude Code-specific features like the `Task` tool for parallel research. They won't work directly in other tools, but the underlying methodology (structured questioning, incremental validation) applies anywhere.

---

Built by [Tristan](https://github.com/simulcast). Part of the [Zero Dependencies](https://zerodependencies.com) newsletter.
