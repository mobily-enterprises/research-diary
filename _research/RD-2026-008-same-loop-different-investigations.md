---
title: Does the same agent loop produce the same investigation?
id: RD-2026-008
record_id: RD-2026-008
project: agent-reliability
core_activity: CA-01
activity_type: core
status: concluded
result: inconclusive
summary: >-
  Three non-frontier coding models reviewed the same pre-fix software through
  a common agent loop. Their execution histories exposed different evidence
  choices, missed boundaries and unsupported conclusions, showing why tool
  availability alone does not establish investigative reliability.
tax_year: "2026-27"
started: "2026-09-19"
ended: "2026-09-20"
duration_days: 2
research_hours: 12
research_hours_basis: estimated
record_basis: retrospective
recorded_on: "2026-09-20"
hypothesis_recorded: "2026-09-20"
investigators:
  - Tony Mobily
tags:
  - ai
  - coding-agents
  - non-frontier-models
  - verification
  - instruction-following
  - vibe64
example: false
evidence:
  - label: Experiment record and source checksums
    type: YAML
    url: /evidence/RD-2026-008/experiment-record.yml
  - label: Defect-discovery comparison
    type: CSV
    url: /evidence/RD-2026-008/results.csv
  - label: Guidance and verification ledger
    type: CSV
    url: /evidence/RD-2026-008/guidance-and-verification.csv
next_experiment: >-
  Repeat the comparison with identical request payloads, repository and
  dependency snapshots, fixed budgets and no discretionary follow-up prompts.
  Predeclare the defect rubric and repeat each model condition. Then vary
  mandatory scoped lint and verification gates separately from model choice.
---

## Research question

The tools were available. The decisions were different.

We asked three coding models to review the same day's changes in Vibe64. Each
could inspect the repository, read its instructions and run checks through the
same basic agent loop. One constructed diagnostic probes. Another repeatedly
ran existing tests. A third inspected source and produced increasingly forceful
conclusions without running tests or lint.

This gave us a practical research question:

> When coding agents share a repository and tool-loop design, how consistently
> do they select the evidence needed to discover and substantiate defects?

**Frontier models were not included in the candidate comparison.** The three
selected non-frontier candidates were recorded as `deepseek-flash`, `glm-5.3`
and `grok-4.6`. These identifiers are taken from the session metadata. The
cohort designation records this study's scope, rather than a claim about a
permanent industry-wide definition of the frontier.

An earlier Astra-assisted review supplied a reference set of reproduced
failures. Astra was not rerun as a matched candidate. Consequently this study
does not measure a frontier-versus-non-frontier performance gap.

This diary entry was assembled retrospectively on 20 September from retained
conversations, tool outputs and source. The request to replay the review with
another model was recorded at 22:34 AWST on 19 September. The formal question,
rubric and limitations below were consolidated after the runs; they were not
a preregistered benchmark protocol.

## Intended new knowledge

We wanted to distinguish four things that are easily conflated in an agent
evaluation: access to a tool, choosing to use it, interpreting its result and
recognising when the investigation remains incomplete.

The intended knowledge concerned the investigation itself. Which agents
followed an anomalous result? Which accepted existing tests as sufficient?
Which crossed from a changed file into the account or execution boundary that
gave the change its meaning? Could a convincing final report contain both
correct findings and unsupported allegations?

The practical application is a more dependable review workflow for Vibe64.
Routine repair, release and deployment work are separate from the comparative
investigation recorded here.

## Existing knowledge

The starting material was a real software incident and an earlier defect
investigation. Nine public-editor implementation commits and five companion
editor-pointer commits had been reviewed. Existing focused tests passed while
targeted probes exposed failures in summarisation, account selection, child
command execution and resource cleanup.

That established a useful test case: defects existed which ordinary passing
tests did not reveal. It did not establish which other models would discover
them or which evidence they would choose to collect.

During interpretation on 20 September, we consulted Anthropic's
[description of model-directed agents](https://www.anthropic.com/engineering/building-effective-agents)
and the [DeepSeek-R1 research paper](https://arxiv.org/abs/2501.12948).
The former distinguishes an agent's model-selected actions from a fixed
workflow. The latter supplies an example of training influencing verification
and strategy adaptation. Neither establishes why a particular candidate made
a particular choice in these runs. These were explanatory sources consulted
afterward, not a literature search completed before the experiment.

No systematic prior-art survey or formal advance assessment of worldwide
knowledge was recorded for this exploratory study.

## Technical uncertainty

A common harness could plausibly reduce differences between models by giving
each the same source, shell and instructions. It could also leave the decisive
differences untouched: deciding what to inspect, recognising contradictions,
constructing a discriminating probe and knowing when to stop.

We could not infer those choices from tool availability. Nor could we infer
review quality from the number of commands or the length of the final report.
The experiment needed to expose the sequence of actions and compare each
claim with source or executable evidence.

## Competent professional assessment

The relevant fields are software verification, developer tooling and
evaluation of language-model agents. Familiarity with code review can suggest
useful checks, but cannot determine in advance which checks a probabilistic
agent will choose on a particular repository.

This record documents an investigator-led empirical comparison. It does not
claim that a formal competent-professional or eligibility assessment was
performed before the runs. Its useful contribution is a traceable case and a
more precise design for subsequent controlled experiments.

## Hypothesis

The working proposition examined retrospectively was:

> If a common tool loop, repository state and written guidance are sufficient
> to make these coding agents interchangeable as reviewers, then their
> investigations should recover the important reference defects and support
> their findings with relevant evidence.

No numeric success threshold was registered before execution. We therefore
report finding-level observations rather than manufacture a retrospective
pass rate. A stronger causal claim—that model training alone explains the
differences—remains unresolved by this design.

## Experiment design

The investigation used independent pre-fix checkouts, with the public editor
fixed at `9fd9abc0b62313251bfae32be6b71ed8704b839c` and its companion checkout
at `5e777eae09cefe9b57c578c64592de47081314ae`. Pre-existing identity-display
and logging edits were preserved. Comparison instructions prohibited reading
the repaired originals, later history or another agent's repair reports.

The candidate sessions used the same CLI version, `0.133.3`, with recorded
reasoning effort `high`. Their task was the same in substance, but the complete
request payloads were not identical. Follow-up prompts, dependency state and
available base instructions differed. Each run also encountered initial
sandbox difficulties before substantive work continued with tool access.

We examined the retained histories for source reads, instruction reads,
commands, actual check results and final claims. An attempted file read that
failed did not count as a completed read. Truncated output did not count as
proof that the complete document had reached the model. A concern mentioned
during investigation was distinguished from a clear finding in the report.

### Variables and controls

| Role | Measure |
| --- | --- |
| Varied | Candidate model and the investigation it selected |
| Shared | Pre-fix repository revisions, substantive review task, common CLI/tool-loop design and available repository instructions |
| Not fully controlled | Exact prompts, follow-ups, dependency preparation, request assembly, sampling and effective interpretation of reasoning effort |
| Observed | Defects identified, unsupported claims, instruction reads, verification actions and interpretation of test results |
| Success threshold | Not preregistered; reference-finding coverage and evidentiary support were assessed descriptively afterward |
| Failure evidence | Important known defects missed, a claimed defect contradicted by source, or a test conclusion undermined by its setup |

There was one review session per candidate. No repeated-trial statistics,
blinded scoring or complete defect oracle were established. The original
reference review used a different CLI version and reasoning setting and was
not treated as an equivalent experimental arm.

## Work performed

### 19 September 2026 — preparing and replaying the review

- Preserved independent copies of the pre-fix repository state and the
  pre-existing edits, then adjusted their instructions to keep comparison work
  isolated from the repaired repositories.
- Replayed the review task with DeepSeek and GLM and retained their complete
  session records.
- Compared their reported findings with the reference failures and inspected
  the tool histories to determine what each conclusion actually rested on.

### 20 September 2026 — tracing decisions and checking the evaluation

- Added the Grok run, including its initial report and the second pass prompted
  by “Look harder”.
- Inspected all three histories for instruction reads, verification choices,
  missed boundaries and unsupported claims.
- Investigated GLM's claimed historical terminal-reuse failure. Module
  resolution showed that its temporary worktree and shared dependencies loaded
  separate copies of the terminal registry.
- Ran the disputed terminal-reuse test in the normal pre-fix checkout. It
  passed: one test, zero failures, approximately 698 ms.
- Recorded source-backed corrections to the Grok report and compiled the
  comparison and guidance ledgers linked below.

The investigator supplied **12 hours** for this research activity. This entry
records that figure as an aggregate estimate; it is not a duration derived
from model-session timestamps or a reconstructed allocation to individual
steps. Separate time records remain necessary for any financial use.

## Observations

### A broken feature survived passing tests

The summariser submitted a model request and then called an undefined
`wait(400)`. Its error handler silently selected a mechanical headline.
Existing tests could pass without ever consuming the model's answer.

DeepSeek investigated an unexpectedly fast completion, supplied the missing
function in a diagnostic probe, observed the model summary appear and
confirmed the undefined symbol with lint. GLM read the offending call twice
but neither checked its declaration nor exercised a successful summary path.
Grok found it through source inspection only after the follow-up request.

### Command count was a poor proxy for verification

The histories contained 96 DeepSeek tool calls, 77 GLM calls and 36 Grok calls.
Those totals include unsuccessful attempts and are not comparable effort or
quality scores.

DeepSeek constructed three custom probes and ran lint. GLM ran existing tests
at multiple revisions but did not create the missing successful-summary
check. Grok ran no tests, lint or runtime probes. Its second pass nonetheless
correctly identified that an initial incomplete reasoning fragment could
prevent later live updates.

### The most important omissions crossed subsystem boundaries

None of the three candidates identified the personal-account exposure or the
native child-session command failure established by the reference probes.
They inspected whether provider subagents were configured, but did not
complete the path from the caller's entitlement to the provider made
available, or from a native child session to its command environment.

The reference account probe demonstrated generated exposure, not a live
charged-provider call. That distinction remains part of the result.

| Reference finding | DeepSeek | GLM | Grok |
| --- | --- | --- | --- |
| Personal-account boundary bypass | Missed | Missed | Missed |
| Undefined polling function | Found and probed | Missed | Found on second pass |
| Duplicate summary requests | Found and probed | Recognised but weakened | Recognised; final report imprecise |
| Saved final answer can remain busy | Not established | Not established | Recovery delay noticed; busy-state finding not established |
| First fragment suppresses later live headline | Not isolated | Related concern; wrong threshold explanation | Found by source inspection |
| Native child cannot execute commands | Missed | Missed | Missed |
| Native helpers leak and cleanup keys mismatch | Found | Key errors found; native leak not established | Found by source inspection |

### Reading instructions did not ensure their application

All three received root agent instructions and expanded Genesis guidance in
their prompts. DeepSeek fully read the project skill and Online Blueprint.
GLM's combined context read was substantially truncated. Grok received almost
all of the skill but did not read the Blueprint or Stack.

None read the required platform architecture document. Only GLM ran
`genesis context`, and that output was also truncated. DeepSeek had received
the Blueprint's personal-account restriction but did not test its implications.
The result distinguishes unavailable context from available context that was
not applied.

### A baseline experiment could itself be defective

GLM reproduced a terminal-reuse failure on both the current and an earlier
commit and called it pre-existing. However, its historical worktree shared
`node_modules` with another checkout. Relative and package imports resolved to
different physical copies of a module with an in-memory registry.

The clean-checkout control passed. The evidence points to a test-setup
artifact; reproducing a failure twice under the same compromised setup did not
establish a historical product defect.

### Confidence and precision diverged

Grok combined correct diagnoses with claims that exceeded its evidence. It
treated visible tool-capable delegates as if they were required to share the
hidden summariser's deny-all permissions. It described a fresh helper session
per block despite a within-turn cache. Its abort allegation did not account
for cancellation checks in both callers. A larger timeout was presented as a
latency concern without measuring hook execution.

These were useful hypotheses to investigate. They were not all established
defects.

## Evaluation

The observations do not support treating the tested candidates as
interchangeable reviewers merely because they share a tool loop. Their
evidence selection, boundary coverage and verification discipline differed
materially. DeepSeek provided the strongest experimental support in this
case; Grok contributed useful source findings with more unsupported claims;
GLM missed a deterministic failure despite substantial testing activity.

This is not a general ranking. The candidates were not repeated, the rubric
was assembled after the runs, follow-up prompts differed and the reference
set may itself be incomplete. GLM and Grok recorded empty base-instruction
metadata, while DeepSeek did not; actual provider request bodies were not
examined. These differences prevent attributing the outcome to model training
alone.

The result is therefore marked **inconclusive** for the causal research
question. The narrower operational observation is clear: making a check
available did not make the agent perform it, and a green test result did not
ensure that the relevant behaviour had been exercised.

## Logical conclusion

A common agent loop preserved the ability to investigate. It did not preserve
the investigation itself.

The study identified concrete failure modes for the next experiment:
incomplete context consumption, unsupported confidence, insufficient success-
path testing, missed authorization and execution boundaries, and contaminated
historical test environments. It also identified a useful candidate control:
require scoped verification evidence before allowing a review to conclude.

Whether that control improves coverage across repeated non-frontier model
runs, and how much additional benefit comes from explicit boundary-oriented
prompts, remains to be tested. Frontier-model performance was outside this
candidate comparison.

## Supporting activities

Preparing isolated checkouts, preserving pre-existing edits, extracting trace
evidence, checking module resolution and maintaining the comparison ledgers
were directly connected to this investigation. The production repairs,
package publication, deployment and unrelated product work are outside this
entry's experimental scope.

The record describes work and its limitations. It does not itself determine
the eligibility or financial treatment of any activity or expenditure.
