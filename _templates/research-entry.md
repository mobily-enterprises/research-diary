---
title: "[Specific question this experiment tests]"
id: RD-2026-000
record_id: RD-2026-000
project: your-project-slug
core_activity: CA-00
activity_type: core
status: planned
result: pending
summary: >-
  In one or two plain-language sentences, describe the uncertainty and the
  experiment. Do not describe the intended commercial feature.
tax_year: "2026-27"
started: "2026-07-22"
ended: "2026-07-24"
duration_days: 3
research_hours: 0
research_hours_basis: recorded
hypothesis_recorded: "2026-07-22 09:00 +0800"
investigators:
  - Researcher name
tags:
  - ai
  - replace-me
example: false
evidence:
  - label: Experimental protocol
    type: YAML
    url: /evidence/RD-2026-000/protocol.yml
next_experiment: >-
  Do not complete this field until the results identify further work.
---

## Research question

State one technical or scientific question that requires an experiment to answer. Do not frame it as a product feature or implementation task.

## Intended new knowledge

State the technical knowledge the company is seeking. Keep it separate from the broader commercial objective.

## Existing knowledge

Record the searches performed **before the experiment**. Include dates, queries, literature, patents, documentation, public implementations and expert enquiries. For each relevant source, note what it established and why it did not answer the research question. Retain links or copies.

## Technical uncertainty

Explain precisely what a competent professional could not know or determine in advance. State why multiple outcomes were technically plausible and why implementation difficulty alone is not the uncertainty.

## Competent professional assessment

Identify the relevant field. Explain why a competent professional, after reviewing worldwide reasonably accessible knowledge, would still need to run the experiment. Retain the evidence for this assessment.

## Hypothesis

Write this before experimental work starts. Use a testable form:

> If [independent variable or proposed mechanism], then [measurable result] will [meet threshold], because [technical reasoning informed by background research].

State the result that would support or reject the hypothesis.

## Experiment design

Describe the procedure in enough detail for a technically informed reader to understand and repeat it. Explain how it tests the hypothesis and how the design limits bias, leakage and confounding factors.

### Variables and controls

| Role | Measure |
| --- | --- |
| Varied | [Independent variable] |
| Held constant | [Models, versions, prompts, datasets, runtime, seeds and other controls] |
| Observed | [Dependent variables and measurement method] |
| Success threshold | [Numeric or otherwise objectively assessable threshold chosen in advance] |
| Failure threshold | [Condition that rejects or fails to support the hypothesis] |

## Work performed

Append dated material actions as they occur. Identify who performed them and link to commits, tickets or run artefacts. Separate experimental work from routine development.

## Observations

Record observations separately from conclusions. Include unexpected behaviour, unsuccessful runs and deviations from the protocol. Link to the complete results, not only favourable output.

## Evaluation

Analyse the observations using the method recorded before the experiment. Compare the results with the thresholds. Explain anomalies, limitations and any supported causal relationship between the varied and measured parameters.

## Logical conclusion

State whether the results support, reject or leave the hypothesis inconclusive, and why. Do not rewrite the original hypothesis to match the result.

## Supporting activities

Identify any activities directly related to this core activity. If an activity produced goods or services, was excluded from being core R&D, or directly related to production, record the evidence for assessing its dominant purpose. Keep routine product work separate.
