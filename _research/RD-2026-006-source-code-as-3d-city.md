---
title: Can six hundred source files become a usable three-dimensional city?
id: RD-2026-006
record_id: RD-2026-006
project: file-city
core_activity: CA-01
activity_type: core
status: concluded
result: inconclusive
summary: >-
  We turned Vibe64's 600-file working tree into an interactive File City and
  tested directory terrain, instanced rendering, exact dependency evidence,
  subsystem bundling and architectural layers. The prototype worked; whether it
  improves understanding remains unproven.
tax_year: "2026-27"
started: "2026-07-12"
ended: "2026-07-15"
duration_days: 4
research_hours: 30
research_hours_basis: estimated
hypothesis_recorded: "2026-07-12 08:35 +0800"
investigators:
  - Tony Mobily
tags:
  - ai
  - software-visualisation
  - three-js
  - file-city
  - source-code
  - vibe64
example: false
evidence:
  - label: Experiment record
    type: YAML
    url: /evidence/RD-2026-006/experiment-record.yml
  - label: Results by stage
    type: CSV
    url: /evidence/RD-2026-006/results.csv
next_experiment: >-
  Freeze representative repositories, set frame-time and interaction targets,
  and compare timed architecture questions in File City and a conventional file
  tree with participants who did not build either representation.
---

## Research question

Can six hundred source files become a usable three-dimensional city?

The first city was born as a retreat.

We had built a 3D representation of Vibe64's architecture: client on one side,
server on the other, subsystems laid out as territories, and interfaces made
visible as connections between them. It was coherent and it worked. It was also
too abstract.

That verdict changed the experiment. Instead of beginning with what the files
*meant*, we would begin with the files themselves.

A directory would become a precinct. A file would become a building. A large
file would become a skyscraper, not because size proves bad design, but because
169,000 lines of software should not look like a tidy row of equal icons.
Subdirectories would rise as terraces. Imports would become visible connections.
The logical subsystems could then be placed over this physical city, tied to the
actual buildings which gave them substance.

The question sounds whimsical until one tries to do it. A real repository is
not a model village. It contains hundreds of buildings, deeply nested folders,
several kinds of relationship, shared helpers with enormous fan-out, framework
registrations which do not appear as imports, and logical subsystems which may
be physically scattered. It must also remain responsive while somebody moves
through it.

## Intended new knowledge

We wanted to learn whether one spatial representation could preserve three
different truths at once:

1. **Physical containment:** the directory tree in which every file lives.
2. **Technical connection:** imports, dependency injection and other concrete
   ways one implementation uses another.
3. **Logical ownership:** the subsystem or responsibility a file helps to
   implement.

These truths overlap, but they are not interchangeable.

A package directory may line up beautifully with one subsystem. A client
subsystem may instead occupy several places under `src`. A declared package
dependency may have no direct import because JSKIT loads a provider by token. A
widely used helper may produce fifty perfectly correct lines which make the
entire view unreadable.

The city would be useful only if it revealed those differences rather than
smoothing them away.

There was also a hard graphics question. The first straightforward renderer
created hundreds of meshes, materials, shadows and lights. It looked like a
city, but moving through it was unpleasant. We needed to know whether the
repository could be rendered as one world without reducing the visible data to
the point where the metaphor stopped meaning anything.

## Existing knowledge

Hierarchical visualisation is well established. [D3's hierarchy
module](https://d3js.org/d3-hierarchy) explicitly lists file systems and software
packages among the structures it can represent. Its treemap recursively assigns
rectangular area to values, which makes it suitable for laying out directories
and giving files area based on physical line count.

The proposed city added elevation and interaction to that basic idea. Directory
depth could be shown as terraces while building height or footprint carried an
explicit file measure. This was not proof that people would understand the
result; it did establish a deterministic alternative to arbitrary force-directed
placement.

[Three.js `InstancedMesh`](https://threejs.org/docs/pages/InstancedMesh.html)
exists specifically to draw many objects sharing geometry and material while
reducing draw calls. That made a repository-scale skyline technically plausible.
It did not tell us how many independently selectable labels, outlines,
relationships and directory surfaces could be added before interaction
degraded.

The earlier review of C4, Backstage, Kythe and Sonar Architecture remained
relevant to the architecture overlay. The file city also had relatives in code
maps, treemaps and software-city research. Those systems established that
physical software measures can be mapped into space. They did not answer the
particular combination being tested here: a live WebGL city embedded in Vibe64,
derived from the active session, with framework-aware logical ownership and
evidence-typed connections.

Mermaid was considered and left in a supporting role. It can explain a selected
relationship or export a compact diagram. It cannot be the continuously
navigable world containing six hundred selectable buildings.

The prior work therefore supplied layout and rendering mechanisms, but no
existing result established that our chosen encodings would remain responsive,
legible and honest on Vibe64.

## Technical uncertainty

The uncertainty was not whether Three.js could draw boxes. It was whether the
boxes could retain enough meaning to justify being drawn.

### Density versus identity

Every source file needed a stable building which could be selected and traced
back to its path. Drawing each building independently was too expensive. Drawing
all of them as a single undifferentiated mesh would be fast but useless. We did
not know whether GPU instancing, picking and separate label geometry could
preserve identity at an acceptable interaction cost.

### Directory depth versus visual clutter

Fences around every directory seemed natural. In practice, nested fences
competed with buildings and labels. Colour could encode depth, directory or
runtime side, but not all three at once. A colour scheme which looked systematic
in a description became incomprehensible when applied to the city.

### Relationship truth versus the web

Showing all imports is accurate and unreadable. Showing only subsystem-to-
subsystem arrows is readable and may conceal the exact files which caused the
relationship.

The difficult case was not one import from A to B. It was twenty files in a
subsystem using the same export from another subsystem. Twenty arcs form a web;
one aggregate arc can falsely imply one physical connection. If the consuming
subsystem is scattered, even the place where the aggregate line lands becomes
an architectural claim.

### Static imports versus framework wiring

JSKIT supports ordinary imports, descriptor dependencies, runtime providers and
container tokens. A package can be required without a building in that package
being imported directly. We could not assume that `dependsOn` meant “this file
calls that file”, or that the absence of an import meant the dependency was
stale.

### Three-dimensional navigation

There is no universally understood trackpad gesture for rotating a 3D software
map. Primary drag is commonly expected to move the thing under the pointer;
wheel or two-finger vertical movement may zoom, dolly or scroll depending on the
application. A navigation system which needed explanation every minute would
undermine the claim that the city was easier to understand.

These issues interacted. More geometry made the structure clearer and the
renderer slower. More relationship lines made the evidence clearer and the
architecture less visible. More camera freedom made exploration possible and
orientation fragile.

## Competent professional assessment

The relevant fields are information visualisation, program analysis,
human-computer interaction and real-time WebGL rendering.

A competent graphics programmer would know to use instancing for repeated
geometry. A competent program-analysis engineer could resolve static imports. A
competent interface designer could provide camera controls and selection.

They could not determine from those established techniques whether the combined
representation would work for this repository and these questions. In
particular, framework-level relationships, physical fragments of logical
subsystems, and the human meaning of directory elevation required observation
against the real subject. The rendering budget also depended on the number and
shape of Vibe64's files rather than a general capability claim about WebGL.

The trial therefore used the complete Vibe64 source model and repeated live
evaluation. Rejected visual changes were treated as observations, not polished
away from the record.

## Hypothesis

At 08:35 AWST on 12 July, immediately after rejecting the abstract system
world, the following working hypothesis was recorded in the design exchange:

> If the filesystem remains the stable spatial ground truth, with directories
> as nested precincts, files as buildings sized by physical lines of code and
> architecture added as a selective overlay, then a repository of roughly six
> hundred source files can remain responsive and reveal both physical and
> logical structure without collapsing into a dependency web.

Support required the full Vibe64 source set to render at an interactively usable
speed; directory depth, file identity and large-file mass to remain visible;
selection to expose exact local relationships; and subsystem connections to be
added without drawing unsupported building-to-building claims.

The hypothesis would be rejected for the tested design if acceptable
interaction required removing the structural cues, or if adding architecture
inevitably produced a misleading or unreadable graph.

No numeric frame-time or comprehension threshold was fixed at the beginning.
“Interactively usable” was evaluated in the live interface by the inventor.
That made the spike useful for design, but it prevented a strong experimental
conclusion.

## Experiment design

The same generated model of the Vibe64 working tree was used throughout. It
contained 600 source files across 17 packages.

The initial city used deterministic hierarchical layout. Adapter-defined
campuses separated the project root, application `src` and `packages`; projects
without campus declarations would remain one city. Within a campus, directories
formed nested precincts and files received buildings based on physical line
count.

We varied the rendering strategy and the visual treatment while retaining file
identity and source measures. The principal stages were:

1. Render the complete city directly and observe interaction.
2. Replace repeated objects with instances and remove decorative GPU work.
3. Establish campus, directory and file encodings.
4. Test camera controls, labels, selection and relationship focus.
5. Add subsystem ownership and framework-aware dependencies.
6. Reduce dense subsystem relationships through evidence-preserving bundles.
7. Test whether software layering could be expressed as separate vertical
   architectural planes.

The browser carried a visible renderer revision number after stale output made
subjective comparison unreliable. Later changes were checked on the same open
page rather than assuming that a refreshed-looking screen contained new source.

### Variables and controls

| Role | Measure |
| --- | --- |
| Varied | Mesh strategy, lighting, pixel ratio, render scheduling, campus spacing, directory encoding, labels, controls, relationship filtering, bundling and subsystem elevation |
| Held constant | Vibe64 working tree, 600-file model, deterministic identities and positions, line count as the file-size measure, and evidence type for every connection |
| Observed | Live responsiveness, successful selection, visible directory and file identity, exact connection endpoints, stale-preview detection and user orientation/comments |
| Success threshold | Complete city remains usable while the required physical and logical questions can be inspected without unsupported visual claims |
| Failure threshold | Performance requires discarding the structural representation, or relationships become an unreadable web or a false simplification |

## Work performed

### 12 July 2026 — building the physical city

- Replaced the abstract architecture opening with a filesystem-first city.
- Mapped files to buildings and directories to precincts, with physical line
  count determining visible file mass.
- Observed severe sluggishness in the first direct renderer. It created separate
  geometry and materials for hundreds of buildings, shadow work and lights for
  very large files.
- Reworked the skyline into two instanced draws—buildings and roofs—merged the
  directory geometry, removed real-time shadows and per-file lights, capped
  pixel density and rendered only while the camera or scene changed.
- The same user who reported the first version sluggish described the revised
  city as “snappy”. No frame-time trace was retained for the comparison.
- Added adapter-defined campuses for the repository root, application and
  packages. Iterated the empty space between them: too little erased the
  distinction; too much made them look like unrelated cities.
- Raised nested directories as terraces. Increased and then reduced walls as it
  became clear that elevation, rather than fences, was the better depth cue.
- Added building contours, directory labels and file names on roofs and vertical
  faces. Labels were moved, reversed, removed and restored several times based
  on what was actually readable from different camera angles.
- Investigated why the user's browser repeatedly showed an old city despite
  hard reloads. Added visible renderer revisions, then traced the problem to the
  Vite module graph: the workspace package resolved through `node_modules` and
  was not watched as first-party source. An explicit `/packages/...` alias fixed
  invalidation. Revisions `002` and `003` reached the same open page through HMR
  without restart or reload.
- Repeatedly changed the trackpad and mouse controls. The discussion established
  that there was no universal rotation gesture. A visible compass/orbit control
  remained necessary even when drag, scroll, dolly and keyboard shortcuts were
  supported.
- Added selection lenses. Choosing a building revealed its connections and
  strongly greyed unrelated buildings; choosing a directory did the equivalent
  for its descendants. Unrelated slabs were later greyed as well.
- Tried a colour family per directory depth. The systematic description failed
  completely in the live city and was undone.
- Committed the first coherent File City implementation as
  [`218ae630` — Add session File City system browser](https://github.com/mobily-enterprises/vibe64/commit/218ae6305c380746f5f8da363acb17fac946b20e).

### 12–13 July 2026 — putting architecture back

- Added declared and generated subsystem ownership over the physical city.
  JSKIT packages supplied natural top-level candidates; selected application
  directories could also form subsystems.
- Added subsystem selection, responsibility text, capabilities, file counts and
  ownership anchors while keeping files and directories visible below.
- Asked whether packages which appeared self-contained truly imported nothing
  from outside. This led from subsystem summaries back to exact file evidence.
- Made external libraries and Node built-ins optional. They can matter, but
  showing them by default overwhelmed the architectural question.
- Distinguished an exact source import from a descriptor-only package
  dependency. For example, one declared dependency had no honest
  building-to-building arrow. The initial interpretation that it might be stale
  was withdrawn after considering JSKIT's dependency injection and load order.
- Defined a fixed, common set of connection kinds: imports, injection, capability
  dependency, package/load-order declaration and unresolved declaration. The
  renderer consumes those kinds; the JSKIT adapter discovers them through JSKIT
  mechanisms. A future framework can use the existing kinds or require an
  explicit model extension.
- Expanded imported-file details to show the actual exports used rather than
  stopping at file paths.
- Observed that exact relationships to shared helpers produced a dense web when
  a subsystem was selected.
- Designed subsystem bundles which collect repeated use at a proven owned
  directory. Selecting the collection point exposes the last-mile files and
  exports. A physically scattered subsystem receives several collection points,
  one for each proven fragment, rather than one fictitious home.
- Tried thick aggregate trunks. They dominated the city and were rejected.
  Bundles returned to thin lines whose darkness could indicate the number of
  underlying connections; hover and selection carried the exact explanation.
- Began testing vertical movement of subsystems. Free placement was reduced to
  discrete downward levels because the intended meaning was architectural
  layering, not arbitrary scene editing.
- Determined that the planes needed large vertical gaps. A small offset looked
  like a rendering adjustment; a categorical layer needed enough void that the
  tallest building below remained clear of the plane above.
- Ended the recorded period while the five-level selection and cumulative plane
  spacing were still being revised.

## Observations

### Performance changed the visual language

The first performance problem was not subtle. Hundreds of ordinary Three.js
objects, plus shadows and small lights, made the city unpleasant to move.

The successful response was not to show fewer files. It was to change how the
same buildings reached the GPU. Instancing preserved the identity and dimensions
of the complete skyline while collapsing repeated geometry into a few draw
operations. Directory surfaces were merged; expensive decoration was removed;
pixel density was capped; a stationary scene stopped redrawing.

This matters beyond optimisation. In this interface, performance is part of
truth. If the user must hide most buildings merely to move the camera, the
claimed “whole codebase” view does not exist in practice.

The live description “snappy” is useful evidence that the rewrite was
noticeable. It is not a benchmark. We retained no median frame time, worst-frame
distribution, input latency or fixed hardware profile. The experiment therefore
established a viable mechanism, not a quantified capacity.

### The directory tree wanted to become terrain

Fences were the first metaphor for folders. As nesting increased, they became
visual noise. Raising subdirectories produced a stronger reading: a folder was
not merely a line around buildings; it was the ground those buildings stood on.

This created its own problem. Folder names needed to be visible from above and
from several sides without producing hundreds of independent text objects.
Labels were moved onto faces, lifted, placed on tops, reversed and backed out.
The back-and-forth was not indecision around decoration. It was the practical
search for a view where the hierarchy could be read while the camera moved.

Colour was less reliable. A proposed sequence of red, amber and green families
for directory depth sounded orderly and looked terrible. It competed with
campus, subsystem and selection meaning. The change was immediately undone.

This suggests a general rule: position and containment should carry primary
structure; colour should remain available for temporary questions.

### A stale preview can corrupt an experiment

For several iterations, instructions were based on an old version of the city.
Campus spacing and building outlines were changed repeatedly because the user
could not see the changes already made.

Adding `001` to the rendering turned “I think this is stale” into an observable
condition. It still did not fix the cause. The cause was Vite resolving the
workspace package through a symlink under `node_modules`, outside the watched
first-party module path.

After the explicit source alias, two consecutive revisions reached the same
open browser page without restarting the server. That result belongs in the
research record because before it, visual comparisons were contaminated. A
perfect screenshot of the wrong build is not evidence of the change being
tested.

### Navigation had no universal answer

We tried pinch and rotate conventions, two-finger horizontal motion, modified
scrolling, dolly controls and several orbit behaviours. Each seemed natural
until used from an awkward camera distance or on a trackpad which reported the
gesture differently.

Primary drag produced the strongest expectation: the point under the cursor
should move with the cursor. Rotation needed an explicit affordance because no
trackpad convention was sufficiently universal. Camera distance also affected
pan speed and made some controls feel broken even when their arithmetic was
consistent.

The observation is not that the final controls were perfect. It is that a 3D
engineering view cannot rely on game knowledge or a hidden gesture vocabulary.
The world needs a visible compass, a reset/fit action and a canonical view from
which the user can recover.

### A connection has an epistemology

One of the most important findings began with a missing line.

The subsystem view said that Studio Setup Doctor depended on Vibe64 Adapters,
but no building in one appeared connected to a building in the other. The
declaration came from `dependsOn`; no direct source import had been found.

It would have been easy to draw a line anyway. That would have been dishonest.
It would also have been easy to call the declaration stale. That was premature.
JSKIT can connect packages through registration and container tokens, with
descriptor dependencies controlling discovery or load order.

The corrected model distinguished several statements:

- this file imports that file;
- this consumer requests a named token registered by that provider;
- this subsystem requires a capability provided by another;
- this package declares another for load order;
- this declaration exists, but its operational reason is unresolved.

All five may produce some form of visual connection. They must not produce the
same claim.

This led to an architectural decision for Vibe64 itself. The renderer supports a
small fixed vocabulary of connection kinds. A framework adapter maps its own
mechanisms into that vocabulary. The renderer does not contain JSKIT-specific
rules, and the common model does not become an unlimited plug-in ontology which
no interface can explain.

### The web was real—and still needed compression

Selecting a subsystem and drawing every exact file relationship produced the
expected web. Hiding it would remove evidence. Leaving it visible would make the
rest of the city disappear behind lines.

The useful idea was a mass connector with a last mile.

If several files under one subsystem-owned directory use the same external
export, their paths can meet at that directory's collection point. The aggregate
line travels between the relevant subsystem pieces. Clicking it restores the
exact consuming files, provider files and exports.

The collection point must be physical and proven. If the subsystem is scattered
across three unrelated directories, it gets three connections. That apparent
mess is information: the subsystem itself is scattered. Combining the pieces
into one neat line would hide the architectural problem.

Thick lines were tested and rejected. They made the aggregate count visually
obvious but dominated everything. Thin lines with increasing darkness, backed
by hover and click detail, preserved the count without turning the city into
plumbing.

### Layering was not ordinary height

The proposal to move `vibe64-core` downward began as scene editing and became a
semantic question. Core sits below many other responsibilities in the
dependency sense: it is a foundation. Showing it on a lower plane could make
that architectural relationship immediately apparent.

A small vertical offset did not work. It looked as though somebody had nudged a
slab. The layers needed categorical separation: wide empty vertical space, a
new campus floor at each occupied level, and spacing derived cumulatively so a
lower layer could not collide with the one above it.

This was an important refinement and an unfinished one. The recorded
conversation ended after specifying five possible levels, direct level
selection, fragment-aware subsystem selection and gaps based on the tallest
content below. The end state should not be backfilled into the experiment as if
it had already been evaluated.

## Evaluation

The work produced a functioning File City and several strong narrower results.

The 600-file repository could be displayed as a selectable city after replacing
per-object rendering with instanced and merged geometry. The directory hierarchy
could be represented as deterministic terrain. Exact imports could be shown at
building level. Framework declarations which lacked file endpoints could remain
visibly different. Dense subsystem use could be compressed at honest physical
collection points and expanded back to the last mile.

Focused checks at the final recorded strata iteration passed: **9 client layout
tests and 6 System route/service tests**. The relevant build/check command also
completed successfully. These checks established implementation behaviour; they
did not measure whether a new user understood the city.

The broad hypothesis remains inconclusive for three reasons.

First, the responsiveness threshold was subjective. The same evaluator reported
a large improvement, but we did not record frame time or interaction latency.

Second, the evaluator designed the representation. Rapid recognition by the
inventor cannot establish comprehension by somebody approaching the system for
the first time.

Third, the architectural overlay was still changing. Connection evidence and
bundling had become much more honest, while the five vertical architecture
levels had not completed evaluation within the recorded period.

The trial nevertheless falsified and refined several mechanisms:

| Proposed mechanism | Result in this trial |
| --- | --- |
| One ordinary mesh and rich lighting per file | Rejected as too slow |
| Instanced skyline, merged terrain and demand rendering | Viable in live use; not quantitatively benchmarked |
| Folder fences as the primary hierarchy cue | Weakened in favour of raised terrain |
| Directory depth encoded by colour families | Rejected in live evaluation |
| Every package dependency drawn as a file arrow | Rejected as unsupported |
| Every exact file relationship shown in subsystem mode | Rejected as unreadable at high fan-out |
| One aggregate line per subsystem pair | Rejected when ownership is physically scattered |
| Bundles at proven ownership fragments with last-mile expansion | Viable in the prototype |
| Small manual height offsets | Rejected as visually ambiguous |
| Discrete architectural planes | Promising but incomplete at period end |

### Conjectures produced by the work

**A city may expose architecture by refusing to tidy it.** Scattered subsystem
fragments, giant files and unexplained declarations are not rendering defects.
They may be the very facts the user needs.

**The filesystem can be a coordinate system without being the conceptual
model.** Stable physical geography lets the user learn the city. Subsystem,
runtime and dependency views can change emphasis without moving every building.

**Selection may be more important than overview.** The whole repository gives
orientation and scale. Most useful questions require a severe local lens which
greys everything unrelated.

**Dependency compression can remain truthful if it is reversible.** An
aggregate line is acceptable when it has a defined grouping rule and the exact
last-mile evidence can be recovered.

**Architectural layers may be a human declaration rather than an extracted
fact.** Static analysis can show dependency direction, but “Core belongs one
level below Execution” may be an engineering interpretation worth recording
explicitly. The interface must identify it as such.

**File City and human-readable Program may eventually meet.** A future readable
source representation could provide stronger purpose, exports and data-flow
facts for each building. That is a conjecture from two independent research
threads, not an outcome of this trial.

## Logical conclusion

We did turn source code into a three-dimensional city.

It contained all 600 classified source files. Directories became terrain. Large
files became visible mass. Imports could be inspected. Subsystems could be tied
back to physical fragments. A performance rewrite made the city subjectively
fast enough to explore, and the connection model became considerably more
honest through the failures we encountered.

We did not prove that File City makes software easier to understand.

That requires a frozen subject, measured rendering targets and people who did
not participate in inventing the metaphor. They should be asked concrete
questions—where a capability lives, which files cross a boundary, why one
package depends on another—and their accuracy and time should be compared with
a conventional file tree and source browser.

The experiment is therefore inconclusive on its broad claim and successful as a
prototype investigation. It produced a system ready for further Vibe64
integration, but not a result ready to be treated as established human-computer
interaction knowledge.

## Supporting activities

The following activities were directly related to designing, conducting or
evaluating the experiment:

- implementing deterministic file, directory, campus and subsystem layout;
- developing the Three.js renderer, instancing, picking and demand-render loop;
- diagnosing the stale Vite workspace-package preview and adding observable
  renderer revisions;
- implementing exact import evidence and framework-level relationship kinds;
- creating subsystem ownership anchors, collection points and last-mile
  projections;
- adding focused client layout and System route/model tests;
- retaining screenshots, live comments, rejected revisions and Git history; and
- recording the limitations and next comparative experiment.

Routine visual polish, unrelated Vibe64 changes and later production integration
are outside this entry unless separately assessed. The existence of a technical
uncertainty or a public research record does not by itself determine R&amp;D Tax
Incentive eligibility or expenditure treatment.
