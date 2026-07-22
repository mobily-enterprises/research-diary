---
layout: page
title: The method
eyebrow: Record-keeping method
intro: >-
  The workflow used to plan an experiment, record the work and retain the
  resulting technical evidence.
permalink: /method/
---

{% include disclaimer.html %}

## The central rule

Start the record **before** the experiment. Current Australian Government guidance says records should be created when an activity is conducted and should link activities to their associated expenditure. Git history can support the chronology. It cannot make an activity eligible.

## 1. Define the unit of research

A project may contain several technical uncertainties. Give each discrete core activity a stable identifier such as `CA-01`. Give each experiment or meaningful iteration its own identifier such as `RD-2026-004`.

Several experiments may belong to the same core activity when they address the same technical uncertainty. Record a different uncertainty separately, even when it concerns the same product.

## 2. Search existing knowledge

Before experimenting, investigate knowledge reasonably accessible anywhere in the world:

- scientific, technical and professional literature;
- patents and patent applications;
- documentation, standards and public implementations;
- internet searches with recorded terms and dates;
- relevant advice from competent professionals.

Keep the search terms, dates, relevant results and remaining gaps. A statement that “nothing was found” is not enough. Explain why the available information did not determine the outcome.

## 3. Record a falsifiable hypothesis

The hypothesis should state the proposed mechanism, measurable outcome, threshold and technical reason. Record it before running the experiment. Use this structure where it fits:

> If **X** is changed while **Y** is controlled, then **Z** will meet **threshold T**, because **technical reason R**.

Decide in advance what would support, reject or leave the hypothesis inconclusive.

## 4. Design the experiment

Record the independent variable, dependent measures, controls, datasets, models, versions, prompts, seeds, runtime conditions, scoring process and known confounders. Design the comparison to answer the hypothesis. Showing that the software runs is not sufficient.

## 5. Preserve observations

Keep raw results, failed runs, deviations and unexpected behaviour. Commit small text artefacts directly; store larger artefacts in an appropriate durable location and record checksums and links. Avoid retaining only favourable output.

## 6. Evaluate and conclude

Separate observations from interpretation. Apply the pre-recorded analysis, compare results against thresholds and explain relevant causal relationships and limitations. State whether the evidence supports, rejects or leaves the hypothesis unresolved.

## 7. Link technical and financial records

The public diary contains the technical record. Maintain a separate private ledger containing:

- people and actual time allocated to each activity;
- salary, superannuation and other expenditure actually incurred;
- cloud, software, contractor and asset costs;
- the apportionment method and supporting calculations;
- contracts, IP rights, approvals and evidence of control and financial risk.

Do not publish personal remuneration, customer information or confidential agreements in the public diary.

## 8. Preserve amendments

Correct errors transparently. Add an amendment with its date and reason instead of silently rewriting the original hypothesis or thresholds after results are known. Git history is useful supporting evidence, but repositories can be rewritten; protected branches, reviewed pull requests and signed tags can strengthen provenance.

## Official references

- [R&DTI record keeping](https://business.gov.au/grants-and-programs/research-and-development-tax-incentive/check-if-you-are-eligible-for-the-randd-tax-incentive/record-keeping-for-the-rd-tax-incentive)
- [Conducting core R&D activities](https://business.gov.au/grants-and-programs/research-and-development-tax-incentive/check-if-you-are-eligible-for-the-randd-tax-incentive/conducting-core-activities)
- [Current registration application questions](https://business.gov.au/-/media/grants-and-programs/rdti/rdti-registration-application-form-questions-pdf.pdf)
- [Software-related activities guidance](https://business.gov.au/-/media/grants-and-programs/rdti/sectors/software-activities-and-the-rdti-pdf)

The schema was checked against guidance published as at **22 July 2026**. Questions and guidance can change. Review the current official material before preparing each annual registration.
