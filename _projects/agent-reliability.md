---
title: Evidence-Seeking Behaviour in Coding Agents
id: PRJ-2026-004
record_id: PRJ-2026-004
slug: agent-reliability
summary: >-
  Research into how coding agents select evidence, verify hypotheses and
  recognise software boundaries when given a common repository and tool loop.
status: running
tax_year: "2026-27"
started: "2026-09-19"
ended: "2026-09-20"
field_of_research: "4602: Artificial intelligence"
example: false
core_activities:
  - id: CA-01
    name: Investigative reliability under a common agent harness
benefit:
  effective_ownership: >-
    The work uses Mobily Enterprises' Vibe64 software and investigator-owned
    experimental records. The resulting evaluation method and observations
    can inform its development workflow; third-party models remain the
    property of their providers.
  control: >-
    Tony Mobily selected the review task, requested isolated pre-fix checkouts,
    chose the candidate models and directed the subsequent trace comparison.
  financial_burden: >-
    The investigator supplied an aggregate estimate of 12 research hours.
    Detailed time and expenditure records are maintained separately. This
    study did not measure provider charges or infer expenditure from the
    presence of an API request.
---

## Project objective

Determine which parts of a coding agent's reliability come from the common
execution environment, which depend on the model's choice of investigation,
and which can be made more dependable through explicit verification steps.

The initial study compares three non-frontier candidates reviewing the same
pre-fix Vibe64 repository state. Frontier models were excluded from the
candidate comparison. An earlier frontier-assisted review supplied reference
findings for evaluation; it was not a matched experimental arm.

## Why experimentation is required

Providing a shell, repository, tests and written instructions establishes what
an agent can access. It does not establish which evidence it will seek, whether
it will notice a failed assumption, or whether its final report distinguishes
a reproduced defect from an untested concern.

Those decisions can be inspected in execution traces. A complete evaluation
also needs independent checks of reported failures, missed requirements and
the experimental setup itself.

## Core activity CA-01

**Investigative reliability under a common agent harness** examines defect
discovery, instruction use, verification choices, false positives and stopping
behaviour during repository review. The initial record is an exploratory,
retrospective case study. It does not establish a population-level model
ranking or isolate a particular training mechanism.

## Records retained

- the isolated repository revisions and restoration instructions;
- candidate prompts, model identifiers, tool calls, outputs and final reports;
- reference defect probes and subsequent source checks;
- structured finding and instruction-adherence comparisons;
- an independent control test of a disputed historical failure; and
- source-record identifiers and checksums, with complete transcripts private.

## Current position

The first comparison found materially different investigative behaviour despite
a common tool-loop design. None of the three candidates recovered both the
personal-account authorization defect and the native child-command defect.
Existing tests and persuasive reports were insufficient indicators of review
completeness. Repeated trials with an identical request envelope and a
predeclared scoring procedure remain necessary.
