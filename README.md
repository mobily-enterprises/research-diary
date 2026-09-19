# AI Research Diary

A Jekyll site for publishing dated AI research records. It separates project information, core activities and individual experiments. Git history records when hypotheses, methods, results and conclusions were added.

Records marked as illustrative examples are fictional and say so explicitly.
Published research records describe work performed by Mobily Enterprises. Their
publication does not establish that an activity or expenditure qualifies for
the Australian R&amp;D Tax Incentive.

## Run locally

```bash
bundle install
bundle exec ruby scripts/validate_entries.rb
bundle exec jekyll build
python3 -m http.server 4000 --directory _site
```

Open <http://localhost:4000>.

This serves the completed static build. It does not watch or regenerate source
files.

## Authoring instructions

See [`_internal/ADDING_ENTRIES.md`](_internal/ADDING_ENTRIES.md). This guide and the source templates are excluded from the generated public site.

## Add a real project

1. Copy `_projects/context-systems.md` to a new file in `_projects/`.
2. Replace every illustrative statement with facts supported by company records.
3. Give the project an immutable ID and short `slug`.
4. Record the project objectives, core activities, expected duration and the factual basis for effective ownership, control and financial burden.

## Add an experiment

```bash
cp _templates/research-entry.md _research/RD-2026-009-short-question.md
```

Complete the prior-knowledge search, uncertainty, hypothesis, protocol and evaluation plan before running the experiment. Commit the plan, then add observations, evidence, evaluation and conclusions as the work occurs.

Run the validator before committing:

```bash
bundle exec ruby scripts/validate_entries.rb
```

The validator checks structure, identifiers, dates, project relationships and local evidence links. It does not determine truth or eligibility.

## Evidence files

Small text evidence can be stored under `evidence/<ENTRY-ID>/`. Large, private or sensitive evidence should live in an appropriate durable system. Record a stable link and checksum without exposing customer information, credentials, personal remuneration or confidential agreements.

The public IDs should also appear in the company’s private time, payroll, expenditure, contract and apportionment records.

## Deploy to GitHub Pages

The workflow in `.github/workflows/pages.yml` validates, builds and deploys pushes to `main`.

On GitHub:

1. Open **Settings → Pages**.
2. Set **Source** to **GitHub Actions**.
3. Push or manually run the “Validate and deploy Jekyll site” workflow.

GitHub Pages sites are public. Review every committed file before pushing.

## Content model

```text
_projects/       Project-level objectives, core activities, benefit/control/risk
_research/       Dated experiment and iteration records
_templates/      Copyable source templates; not published by Jekyll
evidence/        Public protocols, results and supporting artefacts
scripts/         Structural validation
```

## R&DTI limitation

The site is designed to help maintain contemporaneous technical records. It is not an official government template, does not establish eligibility and does not replace accounting records, contracts, annual registration or professional advice. The schema was checked against guidance published as at 22 July 2026 and should be checked again before each claim.

## Licensing before publication

No licence has been selected automatically. Before inviting reuse, choose an appropriate software licence for the site code and a separate content/data licence for the published research. Confirm that the company has the right to publish all material first.
