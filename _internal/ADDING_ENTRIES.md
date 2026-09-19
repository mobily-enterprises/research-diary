# Adding research records

This file is for repository authors. Jekyll excludes `_internal/` from the public site.

## Before adding an entry

Confirm which project and core activity the work belongs to. Create the project record first if it does not exist. Do not use a diary entry to decide whether work qualifies for the R&D Tax Incentive; document the facts and have eligibility assessed separately.

## Core experiment

Copy the core experiment template and assign the next unused identifier:

```bash
cp _templates/research-entry.md _research/RD-2026-009-short-question.md
```

Complete these sections before running the experiment:

- project and core-activity identifiers;
- start and expected end dates;
- research hours and whether they are taken from records or estimated;
- intended new knowledge;
- existing-knowledge searches and retained sources;
- technical uncertainty;
- competent-professional assessment;
- falsifiable hypothesis;
- variables, controls and success/failure thresholds;
- experimental protocol and planned evaluation.

Set `hypothesis_recorded` to the actual time the hypothesis was recorded. Commit the file before experimental work starts. Git history supports the record but does not replace accurate dates or underlying evidence.

For a retrospective account of completed work, use the same sections but add
`record_basis: retrospective` and an actual `recorded_on` date no earlier than
the activity's end. Keep `started` and `ended` as the dates of the work. Record
the actual date of any retrospective hypothesis formulation in
`hypothesis_recorded`; do not backdate it. Explain which questions were present
at the time and which hypotheses, thresholds or evaluations were assembled
later. The site labels this formulation as retrospective, and validation
permits its later date only with this explicit record basis. Such an account
does not substitute for a contemporaneous experimental plan.

During the work, append dated actions, investigators, observations, failed runs, deviations, commits, datasets, configurations and logs. Record time and expenditure references in the private company ledger.

After evaluation, record the analysis against the original thresholds, the result, limitations, logical conclusion and any next experiment. Do not rewrite the original hypothesis to fit the result.

Use `research_hours_basis: recorded` when the figure is supported by the
company's contemporaneous time records. Use `estimated` only when it is a
good-faith reconstruction, and reconcile it against the private time, payroll
and expenditure records before relying on it for a claim. The number shown on
the public site is not a substitute for those records.

Required core headings:

```markdown
## Research question
## Intended new knowledge
## Existing knowledge
## Technical uncertainty
## Competent professional assessment
## Hypothesis
## Experiment design
### Variables and controls
## Work performed
## Observations
## Evaluation
## Logical conclusion
## Supporting activities
```

## Supporting activity

Use the separate supporting-activity template. Do not invent a hypothesis for work that is not a core experimental activity.

```bash
cp _templates/supporting-entry.md _research/RD-2026-006-supporting-activity.md
```

The supporting template records the related core activity, direct relationship, production or exclusion assessment, dominant purpose where applicable, and retained evidence.

## Status and result values

Statuses:

- `planned`: hypothesis and protocol recorded; execution not started;
- `running`: experimental work or data collection underway;
- `concluded`: results evaluated and conclusion recorded;
- `abandoned`: stopped, with the reason and knowledge gained recorded.

Core results: `pending`, `supported`, `rejected` or `inconclusive`.

Supporting activities use `not-applicable` because they do not have an experimental result.

## Evidence

Put small public artefacts under `evidence/<ENTRY-ID>/`. Keep large, private or sensitive evidence in a durable private system and record a stable reference and checksum. Never publish credentials, customer data, personal remuneration or confidential agreements.

Use the same project, core-activity and entry IDs in time, payroll, accounting, contract and apportionment records.

## Validate and preview

```bash
bundle exec ruby scripts/validate_entries.rb
bundle exec jekyll build
python3 -m http.server 4000 --directory _site
```

The validator checks file structure, identifiers, dates, project relationships
and local evidence links. It does not determine whether the recorded facts are
true or whether an activity or expenditure is eligible. The preview serves only
the completed static build; it does not watch or regenerate source files.
