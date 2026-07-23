---
title: File City and the Vibe64 System Model
id: PRJ-2026-003
record_id: PRJ-2026-003
slug: file-city
summary: >-
  Research into whether a large software system can be reconstructed from
  implementation evidence and made understandable as a navigable three-
  dimensional world, without requiring the user to read source code.
status: running
tax_year: "2026-27"
started: "2026-07-11"
ended: "2027-06-30"
field_of_research: "4609: Information and computing sciences"
example: false
core_activities:
  - id: CA-01
    name: Evidence-backed spatial representation of software systems
benefit:
  effective_ownership: >-
    Mobily Enterprises developed the System model and File City prototype in
    its Vibe64 codebase and can use, modify, publish and integrate the resulting
    open-source work. Supporting company records retain the relevant
    contractual and IP details.
  control: >-
    Mobily Enterprises selected the research questions, chose Vibe64 as the
    trial codebase, designed the visual and evidence rules, directed the
    iterations and decided when a proposed representation was rejected.
  financial_burden: >-
    Mobily Enterprises bore the researchers' time and model-compute costs for
    the work recorded here. Detailed remuneration, expenditure and
    apportionment records are retained privately rather than on this public
    site.
---

## Project objective

Determine whether the physical and logical structure of a substantial software
system can be extracted from its implementation and presented as a stable,
interactive spatial model which helps a systems-minded person understand
ownership, boundaries, dependencies and code concentration without first
reading the source.

The immediate subject is Vibe64 itself. The proposed **System** tool sits beside
Files and Diff inside an active Vibe64 session. It is intended to show the same
working tree from another altitude: files and directories as physical evidence;
subsystems, contracts and connections as the architecture those files realise.

## Why experimentation is required

Static analysis can recover imports, declarations and framework registrations.
Diagramming systems can display nodes and edges. Neither fact establishes that
several hundred files, a directory hierarchy, logical subsystem ownership and
different kinds of dependency can coexist in one spatial representation which
remains truthful, legible and responsive.

The central difficulty is representational rather than merely cosmetic. A
filesystem view is exact but says little about purpose. An architecture diagram
can explain purpose but may conceal the evidence and become an attractive
fiction. Showing every relationship produces a web; hiding relationships can
erase the very architectural problem the user needs to see. Three-dimensional
space adds useful axes, but also adds navigation, occlusion and performance
failure modes.

## Core activity CA-01

**Evidence-backed spatial representation of software systems** tests whether a
small common model, populated by Vibe64-owned framework adapters, can project a
real working tree into an interactive visual world where every displayed claim
has a known evidentiary basis.

The activity includes the common ontology, the JSKIT extraction trial, spatial
encodings for directories, files and subsystems, rendering at repository scale,
and methods for reducing dense relationships without inventing structure.
Routine product integration and visual polishing are recorded separately where
they do not test a technical uncertainty.

## Records retained

- the dated design and implementation conversation;
- the evolving implementation guide and rejected visual approaches;
- the isolated `system-world-v1` worktree and Git history;
- the generated source, subsystem and relationship model;
- screenshots and live human-evaluation notes for renderer revisions;
- focused layout, model, route and browser tests; and
- private time, remuneration, compute and expenditure records.

## Current position

File City exists as a working Vibe64 prototype and has been merged into the
main codebase. The work established several useful mechanisms, including
repository-scale instanced rendering, evidence-typed connections and
subsystem-aware bundling. Five discrete architectural levels were implemented,
but their usability was not established. The project did not prove that the
world improves human understanding compared with a conventional tree, map or
source browser. That requires repeatable performance measurements and
controlled comprehension tasks rather than the inventor's own live evaluation.
