---
title: Can software architecture become the primary view of a codebase?
id: RD-2026-005
record_id: RD-2026-005
project: file-city
core_activity: CA-01
activity_type: core
status: concluded
result: rejected
summary: >-
  We tried to reconstruct Vibe64 as an evidence-backed 3D system of
  responsibilities, interfaces and connections. The model was viable, but the
  first visual world was too abstract to serve as the primary way into the
  software.
tax_year: "2026-27"
started: "2026-07-11"
ended: "2026-07-14"
duration_days: 4
research_hours: 28
research_hours_basis: estimated
hypothesis_recorded: "2026-07-11 14:21 +0800"
investigators:
  - Tony Mobily
tags:
  - ai
  - software-architecture
  - visualisation
  - system-model
  - vibe64
  - jskit
example: false
evidence:
  - label: Experiment record
    type: YAML
    url: /evidence/RD-2026-005/experiment-record.yml
  - label: Architecture-first pivot ledger
    type: YAML
    url: /evidence/RD-2026-005/architecture-pivot-ledger.yml
  - label: Recorded decisions
    type: CSV
    url: /evidence/RD-2026-005/results.csv
next_experiment: >-
  Retain the filesystem as the stable spatial ground truth and test whether
  architecture can be added as an evidence-backed overlay rather than being
  the first abstraction the user encounters.
---

## Research question

Can software architecture become the primary view of a codebase?

The question began with a fairly ordinary observation. AI is becoming very good
at writing code. It can write a function, repair a test and move a responsibility
from one file to another. It is not infallible, but neither is the average human
programmer at the end of a long Friday.

This does not make engineering disappear. Somebody still has to decide what the
program is, where a responsibility belongs, which part is allowed to know about
which other part, what an interface promises, and whether a change has quietly
turned a clean subsystem into a kitchen drawer.

If machines increasingly deal with the syntax, perhaps humans should stop
pretending that syntax is the only honest way to see a program.

Vibe64 already had a file browser and a diff. Both were useful. Both led back to
code. What I wanted was a view which led back to the *system*: the parts, the
contracts between them, the functions they expose, the data they require and
produce, and the places where their boundaries have become dubious.

The user I had in mind was not somebody who knew nothing about software. It was
somebody who could reason about responsibilities and consequences without
wanting to spend the afternoon reading JavaScript punctuation. That increasingly
describes the job I expect human developers to do.

## Intended new knowledge

The immediate objective was to find out whether Vibe64 could reconstruct an
understandable architectural model from a real working tree and make that model
the principal navigational surface.

The model needed to answer questions such as:

- What are the important subsystems?
- What does each subsystem provide?
- Which client asks for a particular server operation?
- Which provider performs it?
- What crosses a subsystem boundary?
- Which claim came directly from the implementation, and which part is only an
  interpretation?
- Where has the actual system diverged from the structure we think it has?

The last question matters most. A diagram which merely looks pleasant is a
poster. A useful system view must show awkward facts: a cycle, an unexplained
dependency, a huge concentration of code, an endpoint with no identifiable
provider, or a component sitting outside the subsystem which supposedly owns it.

The proposed loop was:

```text
human decides the intended structure
             ↓
AI changes the implementation
             ↓
Vibe64 reconstructs the actual structure
             ↓
the difference becomes visible
             ↓
human makes the next engineering decision
```

That is more ambitious than documentation. It is an attempt to move the object
of engineering work from source files to the system represented by them.

## Existing knowledge

We reviewed the closest established approaches before implementing the first
world.

The [C4 model](https://c4model.com/diagrams) demonstrates the value of looking at
software at several levels: system, container, component and, only where useful,
code. Its maps are designed to tell different stories to different audiences.
That supported the decision not to dump symbols and files into one diagram. C4
does not, by itself, continuously reconstruct the architecture of a live working
tree or prove each architectural statement from implementation evidence.

The [Backstage Software Catalog](https://backstage.io/docs/features/software-catalog/)
shows that components, systems, resources, ownership and relationships can form
a practical catalogue of a software estate. Its normal source is maintained
metadata stored with the code. We wanted to derive much more of the model from
the implementation and work at a finer level than a service catalogue.

[Kythe](https://kythe.io/docs/kythe-overview.html) provides a language-neutral
graph for semantic source information. One of its most useful principles is
that partial information is acceptable and incorrect information is not. That
became central to the experiment: the view was allowed to say “unknown”; it was
not allowed to draw a convincing connection because one would look nice.

[Sonar Architecture](https://docs.sonarsource.com/sonarqube-cloud/design-and-architecture/overview)
can derive current structure and relationships from code and compare them with
an intended architecture. This established that automated architectural
inspection is practical. It did not answer whether the result could become a
non-code, spatial control surface for an active AI-assisted development session.

Runtime systems such as tracing tools can show what happened during a request.
They see only behaviour which was exercised. Static indexes can show imports and
references but usually retain the vocabulary of files, classes and symbols.
Dependency diagrams can show everything and thereby explain almost nothing.

The adjacent ideas were mature. The combination we wanted was not: a
framework-aware evidence model, plain-language contracts, deterministic
structural findings, an active-session working tree and a visual world intended
for engineering decisions rather than source navigation.

## Technical uncertainty

The first uncertainty was whether purpose could be recovered without being
invented.

An import is a fact. A route registration is a fact. A package descriptor which
says one package depends on another is a fact. “This subsystem owns terminal
recovery” is a stronger statement. It may follow from several facts, or it may
be a plausible story placed over an untidy implementation.

We therefore separated two conceptual graphs.

The evidence graph contained files, exports, imports, registrations, routes,
schemas, tests, Git history and exact source locations. The system graph
contained subsystems, responsibilities, capabilities, interfaces, operations,
providers, consumers and findings. Every item in the second graph needed a path
back to the first.

The second uncertainty was cross-technology consistency. Vibe64 can understand
JSKIT unusually well because we also develop JSKIT. It could not require the
authors of Laravel, Next.js or a future framework to produce Vibe64's metadata.
A common system model therefore had to be small, while extraction remained
framework-specific.

The third uncertainty was visual. A graph with seventeen subsystems may be
manageable. A graph containing hundreds of files, operations and relationships
will become tangled unless the view has stable geography, progressive detail
and a reason for showing every line. Moving that tangle into three dimensions
does not automatically improve it. It may simply make the tangle rotate.

Finally, the visual language itself could lie. If height means risk in one view
and containment in another, if client and server swap sides when the camera
turns, or if a missing connection is silently guessed, the user will form a
false mental model with great confidence. That would be worse than reading the
source.

## Competent professional assessment

The relevant fields are static analysis, software architecture recovery,
information visualisation and interactive graphics.

A competent engineer could enumerate Vibe64's imports and package descriptors.
They could also build a conventional dependency chart. Existing systems showed
that both tasks were feasible.

What could not be determined in advance was whether those technical facts could
be compiled into a smaller architectural vocabulary, rendered at the right
level of abstraction, and used by a person to answer meaningful questions
without source. That depended on the conventions in the actual Vibe64 codebase,
the completeness of the JSKIT evidence, the handling of unknowns, and human
interpretation of a novel visual world.

The only useful way to settle it was to build a narrow version against Vibe64
itself and put it in front of its designer.

## Hypothesis

The contemporaneous design discussion began at 14:21 AWST on 11 July. It did
not use tax-office prose, but its testable claim was clear:

> If framework-specific evidence can be compiled into a small common system
> model and projected through a constrained three-dimensional visual grammar,
> then a systems-minded user should be able to identify responsibilities,
> interfaces, providers, consumers and structural risks without reading the
> implementation source.

The truth spike would support the claim if Vibe64 itself could be shown as its
real subsystems; if a real operation could be followed to its provider and a
known consumer; if missing knowledge remained visibly missing; and if the world
answered at least one useful architectural question without opening a file.

It would fail in its tested form if the extracted facts could not support those
connections, if the world became an unreadable graph, or if the abstraction
left the user less certain about where things were and why.

## Experiment design

Vibe64 was both instrument and subject.

We limited the first adapter to JSKIT, but placed the adapter contract inside
Vibe64. The JSKIT implementation would emit facts into a common vocabulary;
the renderer would not know what a JSKIT package descriptor was. Unsupported
frameworks would be reported as unsupported rather than receiving a generic,
misleading approximation.

The persistent model was reduced to one compact `vibe64.system.json` file
describing the current working tree. System became an active-session tool beside
Files and Diff. There was no second mode for browsing arbitrary Git snapshots.
To inspect `main`, the user would open a clean session on `main`.

The planned visual world had a fixed grammar. Client and server occupied
opposing realms. Subsystems became territories. Server operations became
socket-like boundary points and known client consumers became plugs. Selecting
one would illuminate the proven path. Files remained available as evidence,
with physical line count controlling visible mass.

Four evidence origins were kept distinct: declared, mechanically derived,
observed at runtime and inferred. Deterministic analysis, not a language model,
would establish structural findings such as cycles.

### Variables and controls

| Role | Measure |
| --- | --- |
| Varied | Ontology, extraction ownership, level of abstraction, spatial grammar and amount of visible technical evidence |
| Held constant | Vibe64 working tree, JSKIT as the only first adapter, active-session scope and requirement for evidence-backed claims |
| Observed | Classified files and packages, resolvable relationships, unsupported or ambiguous facts, and the user's ability to orient and answer the trial questions |
| Success threshold | Real subsystems and one operation path understandable without source, with provenance and uncertainty visible |
| Failure threshold | The primary world appears detached from the implementation, requires source to explain its own layout, or produces convincing unsupported relationships |

This was an inventor-led truth spike, not a blinded comprehension study. That
limitation mattered when interpreting the result.

## Work performed

### 11 July 2026 — from code browser to system browser

- Recorded the premise that code generation was becoming cheaper while human
  responsibility for structure and decisions remained.
- Rejected exported programming-language signatures as the primary vocabulary;
  inputs and outputs needed descriptions meaningful to a non-programmer.
- Reviewed architecture maps, catalogues, semantic indexes, runtime diagrams,
  dependency tools and architecture-conformance products.
- Connected the proposal with Vibe64's existing helper-map process. That process
  already inspected responsibilities to discourage the AI from adding a second
  helper for work which existed elsewhere.
- Designed a small common ontology and the two-layer evidence/system model.
- Chose a hybrid Three.js canvas and Vue/DOM interface. The canvas would carry
  spatial meaning; the DOM would carry text, controls and accessibility.
- Rejected Mermaid as the principal surface. It remained potentially useful for
  exports and small explanations, but did not provide the live spatial world
  being tested.
- Reduced a much larger product plan to a truth spike on Vibe64.
- Made System an active-session tool and reduced persistence to one current-state
  document rather than a history of generated worlds.
- Added the client/server realm and plug/socket metaphors, while requiring the
  underlying relationship to remain an ordinary evidence-backed model fact.

### 12 July 2026 — extraction and the first world

- Created an isolated `system-world-v1` Vibe64 worktree.
- Initially placed the extraction work in JSKIT. This was challenged during the
  experiment: Vibe64 could not expect Laravel or Next.js to implement a Vibe64
  feature. The ownership decision was reversed, the JSKIT worktree was
  abandoned, and the adapter moved into Vibe64.
- Built the active-session API and the first Vibe64-owned JSKIT adapter.
- Ran it over the actual Vibe64 tree. The scan classified **600 source files
  across 17 packages**, resolved code imports, separated client and server
  reachability, and reclassified unresolved image references as assets rather
  than failed code edges.
- Built the first Three.js world with client and server realms, subsystem
  territories, connector metaphors, current-state refresh and Files/System
  navigation.
- Opened the result in the real Vibe64 interface for direct evaluation.
- At 08:35 AWST, rejected the primary representation: “It's too abstract.”

## Observations

### The difficult information was not syntax

The adapter could find a great deal. Package descriptors gave us plausible
subsystems and declared dependencies. Route registries gave server operations.
Providers and client request sites gave possible paths. Source files gave exact
mass and provenance.

The difficult step was deciding what those facts *meant* without quietly making
it up. A package description may state a responsibility, but a directory name
does not. A declared dependency may exist for load order, injection or an
ordinary import. An endpoint may have external consumers we cannot see.

This produced a rule which survived the rejection of the first world: unknown
architecture must remain visible as unknown. A missing client connection is not
automatically an unused endpoint. A high-fan-in package is not automatically a
design horror. Evidence can prompt an investigation without pretending to have
completed it.

### Adapter ownership was part of the experiment

Putting the extractor in JSKIT seemed efficient. We owned both projects and
JSKIT already knew its own conventions. It was also the wrong product boundary.

If Vibe64 supports Laravel, Vibe64 must know how to read Laravel. The framework
may provide useful commands and files, but it is not obliged to cooperate. The
common contract therefore belongs to Vibe64, as do the adapters which satisfy
it.

This was not administrative tidying. It was necessary to test whether the model
was genuinely cross-technology rather than a JSKIT feature wearing a neutral
name.

### The model worked better than the world

The scan of 600 files demonstrated that the evidence side was real. The first
world also worked as software: it loaded, rendered, selected entities and moved
between System and Files.

But the opening experience asked the user to accept our abstraction before
showing its physical basis. Territories, realms, sockets and plugs all had
definitions. They still floated above the familiar facts of a repository. The
user could not immediately see where a territory came from, what occupied it,
or whether the apparent separation corresponded to the actual files.

“Too abstract” was therefore not a request for prettier rendering. It rejected
the experimental mechanism. The visualisation had started at the end of the
reasoning process.

### A useful failure changed the order of truth

The replacement idea arrived immediately: begin with the filesystem, shown as
a city. Directories would be precincts; files would be buildings; large files
would be impossible to overlook; architecture would be attached to those
physical objects.

This did not abandon the system model. It changed the order in which the user
encountered it:

```text
physical evidence first
        ↓
logical ownership second
        ↓
architectural interpretation on demand
```

The filesystem is not the architecture, but it is a stable place from which to
question the architecture.

## Evaluation

The tested hypothesis was rejected for the first representation.

The underlying extraction achieved meaningful coverage on a substantial real
codebase. The common-adapter ownership problem was identified and corrected.
The prototype established that an active-session System tool, a current-state
model and a 3D renderer could be integrated into Vibe64.

It did not meet the primary human threshold. The inventor, evaluating the live
world, could not use its opening abstraction as the natural way into the
codebase. The model required a stronger visual and evidentiary anchor.

The timing makes the result unusually clear. The live System preview was handed
to the evaluator at 08:27 AWST. At 08:35:27—about eight minutes later—the
opening representation was rejected as “too abstract” and the filesystem-first
city was proposed. This was a rapid inventor-led falsification of the opening
experience, not a controlled usability study or a claim that every
architecture-first interface fails.

No controlled participant study was run, so this does not establish that every
architecture-first view will fail. It does establish that the tested
client/server territory world was not good enough to justify continuing on its
own assumptions.

The rejection yielded several narrower findings:

1. A Vibe64-owned adapter can recover a substantial JSKIT evidence graph from a
   real repository.
2. Framework neutrality is an ownership and contract problem, not a promise to
   implement every framework at once.
3. Provenance and explicit unknowns are necessary because architectural prose
   can sound more certain than its evidence.
4. Three-dimensional presentation does not rescue an abstraction which lacks a
   visible physical anchor.
5. The filesystem may be the right stable geography even though subsystems are
   the more important engineering concept.

### Conjectures produced by the work

**Architecture may work better as a lens than as a world.** The user can begin
with files and directories, then ask which subsystem owns them and why.

**A useful architecture view may need to reveal disagreement.** If one logical
subsystem is physically scattered through five directories, the display should
show five pieces. Neatening it into one territory would erase the finding.

**The system model may be as valuable to the AI as to the human.** An evidence-
backed list of ownership, interfaces and existing capabilities could bound an
agent's context and discourage duplication even if the 3D interface were never
used.

**The visual world should earn every abstraction.** A subsystem, connection or
warning should appear only when the user can reach the facts which caused it to
exist.

These became questions for the next experiment rather than claims carried
forward as facts.

## Logical conclusion

We could reconstruct a useful system model from Vibe64. We could render it as a
live 3D world. We could not make that first world feel like the codebase rather
than an interpretation hovering above it.

The tested architecture-first representation was therefore rejected.

The important result was not that 3D architecture was a bad idea. It was that
the order was wrong. The next prototype would begin with the most literal thing
we had—the files—and let the architecture prove itself on top of them.

## Supporting activities

The following activities were directly related to designing, conducting or
evaluating the experiment:

- reviewing prior systems and retaining the implementation guide;
- defining the common model and evidence-origin rules;
- creating and correcting the System adapter ownership boundary;
- implementing the current-state document and active-session API;
- scanning and classifying the Vibe64 working tree;
- building the first Three.js world and System/Files navigation;
- running focused model, route and renderer checks; and
- retaining the dated live-evaluation record and rejection decision.

Routine Vibe64 development, unrelated maintenance and later product polish are
outside this entry unless separately assessed. A research diary record does not
by itself establish R&amp;D Tax Incentive eligibility or the treatment of any
particular expenditure.
