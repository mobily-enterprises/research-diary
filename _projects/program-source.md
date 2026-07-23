---
title: Program as Human-Readable Source
id: PRJ-2026-002
record_id: PRJ-2026-002
slug: program-source
summary: >-
  Research into whether a Markdown description of a program can become a
  readable source representation from which AI can build and maintain a
  working implementation.
status: running
tax_year: "2026-27"
started: "2026-07-21"
ended: "2027-06-30"
field_of_research: "4602: Artificial intelligence"
example: false
core_activities:
  - id: CA-01
    name: Reconstructing software from human-readable Program modules
benefit:
  effective_ownership: >-
    Mobily Enterprises developed the prototype in its Vibe64 codebase and can
    use, modify, publish and integrate the resulting open-source work. The
    supporting company records retain the relevant contractual and IP details.
  control: >-
    Mobily Enterprises selected the research questions, designed the trials,
    set the acceptance tests and decided when to reject, revise or continue an
    experiment.
  financial_burden: >-
    Mobily Enterprises bore the researchers' time and model-compute costs for
    the work recorded here. Detailed remuneration, expenditure and any
    apportionment records are retained privately rather than on this public site.
---

## Project objective

Determine whether ordinary software can be expressed as readable Markdown that preserves its meaningful algorithms, data structures, public functions and cross-file data flow while leaving target-language syntax and private implementation mechanics to an AI translator.

The immediate application is Vibe64. Vibe64 already lets a person ask an AI to build software, but the result is still conventional source code. This project asks whether the lasting source can instead be something that a non-specialist can read, review and change.

## Why experimentation is required

Natural language is not a formally defined programming language, and current language models do not behave like deterministic compilers. A concise description may be readable but omit information needed to reconstruct the program; a sufficiently complete description may become as difficult to read as source code. It was not possible to determine in advance where that boundary would fall, whether generated implementations would retain observable behaviour, or whether failures could be corrected without turning the Markdown into pseudocode.

## Core activity CA-01

**Reconstructing software from human-readable Program modules** tests whether file-level Markdown modules contain enough meaning for isolated AI translators to create or update conventional implementations that satisfy independent behavioural checks.

The work covers the Program format, bounded translation context, shared types, deterministic interface projections, candidate validation, incremental synchronization and clean reconstruction. Ordinary Vibe64 product integration is recorded separately from this experimental activity.

## Records retained

- dated hypotheses, design decisions and experiment transcripts;
- versioned Program, prompt and compiler changes;
- source and Program repositories used for clean-room reconstruction;
- generated candidates, rejection diagnostics and accepted checkpoints;
- independent and generated test suites;
- complete test results and failure-cluster notes;
- commits and private time and expenditure records.

## Current position

The v2 experiment has demonstrated one complete source-free reconstruction from
four production Program modules and one shared type registry. The mature and
independently generated ProgSync implementations passed the same 55-case public
oracle, and the generated compiler converged with Codex unavailable.

The experiment also found a clear synthesis defect despite sufficient Program.
The verified managed implementation must therefore remain durable source
alongside Program, reconciled against their last accepted pair rather than
treated as disposable compiler output. Repeated clean reconstruction,
generality beyond ProgSync and direct testing with the people expected to read
and edit Program remain unproven.
