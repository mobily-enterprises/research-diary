---
title: Can we turn source code into natural language?
id: RD-2026-004
record_id: RD-2026-004
project: program-source
core_activity: CA-01
activity_type: core
status: concluded
result: inconclusive
summary: >-
  We tested whether readable Markdown could preserve enough of a program for
  isolated AI translators to reconstruct working software. A 21-module trial
  succeeded; self-hosting exposed deeper contract failures and left the central
  claim unproven.
tax_year: "2026-27"
started: "2026-07-21"
ended: "2026-07-24"
duration_days: 4
research_hours: 32
research_hours_basis: estimated
hypothesis_recorded: "2026-07-21 12:36 +0800"
investigators:
  - Tony Mobily
tags:
  - ai
  - natural-language
  - program
  - progsync
  - code-generation
  - vibe64
example: false
evidence:
  - label: Experiment record
    type: YAML
    url: /evidence/RD-2026-004/experiment-record.yml
  - label: V1 development ledger
    type: YAML
    url: /evidence/RD-2026-004/development-ledger.yml
  - label: Recorded results by stage
    type: CSV
    url: /evidence/RD-2026-004/results.csv
next_experiment: >-
  Freeze Program, prompts, model settings and retained inputs; complete two
  independent zero-source self-host generations and require both to pass the
  untouched 73-test oracle without Program changes or implementation repair.
---

## Research question

Can we turn source code into natural language?

That sounds like a question about documentation. It isn't.

Vibe64 is meant to let anybody write software. AI has made the act of producing code dramatically easier: describe what you need, wait while an agent works, and—if everything goes well—you end up with a program. But the program is still written in JavaScript, Vue, HTML, CSS and the countless conventions sitting on top of them. We may have made it easier to *write* software while leaving it just as difficult to *read*.

This matters. If somebody cannot read the result, they cannot properly review it, reason about it or feel that it is theirs. They can ask the AI to change it, certainly, but they are still standing outside the program. The source belongs to the machine and to the small group of people who happen to know that particular programming language.

So the real question became more ambitious:

> Can a human-readable Markdown file be the program—not a summary, not a specification sitting above it, and not comments which inevitably become stale?

The corresponding JavaScript or Vue file would still exist. It would still be inspectable, testable and extremely important. But the Markdown file would carry the part of the program that ought to survive a different implementation: the functions it provides, the data they take and return, the other modules they call, the transformations they perform, the effects they cause, the failures they handle and, where it matters, the reason the behaviour exists.

Private helpers, loops, temporary variables, maps, sets and framework machinery would be left to the implementation. They are real engineering, but they are not always the program's meaning.

That distinction is the entire experiment.

## Intended new knowledge

In 1976, [Niklaus Wirth published *Algorithms + Data Structures = Programs*](https://search.worldcat.org/title/Algorithms-%2B-%28plus%29-data-structures-%28equals%29-programs/oclc/320863804). I have always loved that equation. It is blunt, memorable and basically right: a program is not the punctuation used to express it. It is data, and the algorithms which act on that data.

Nearly fifty years later, most of us still read the punctuation.

The knowledge we wanted was whether a third representation could sit above conventional source without becoming vague. We called that representation **Program**. A Program module is an ordinary Markdown file placed in a tree that mirrors the implementation:

```text
program/src/library/catalogStats.js.md
src/library/catalogStats.js
```

The Program file should be short enough to read as English, but precise enough to drive the implementation. It should say which public functions and values the module provides, which outside functions it uses, which shared data structures cross its boundary, and how data moves through its public behaviour. It should not dictate whether JavaScript uses a `Map`, an array, three private helpers or no helpers at all.

We specifically wanted to learn five things:

1. Can an AI extract Program from an existing implementation without merely narrating the source line by line?
2. Can a fresh AI, with no access to that source, construct a working implementation from Program?
3. Can Program remain readable after it contains enough information to do that?
4. Can changes move in either direction without destroying useful work already present in the implementation?
5. Can deterministic tooling surround a probabilistic translator strongly enough that a plausible but incompatible result is rejected before it reaches the project?

The fourth question needs an explanation. Our first instinct was that Program would be like C and the implementation like machine code: edit Program, compile it, discard the result whenever convenient. That analogy did not survive contact with real software. A mature implementation accumulates valuable information which is not necessarily portable Program meaning: a better algorithm, an accessibility correction, browser-specific CSS, a carefully tuned query, a workaround for a platform bug. Calling all of that a disposable build artefact would be absurd.

The emerging model was therefore stranger and more useful. Program is the readable semantic source. The implementation is the precious realization. A brand-new implementation should be possible from Program alone; once it exists, changes should normally be synchronized as small patches so its accumulated engineering survives.

We wanted to know whether this is coherent in practice, not merely attractive in a diagram.

## Existing knowledge

We searched the adjacent fields on 21 July 2026 before beginning the implementation work. Several existing ideas came close enough to be useful, but none answered the experimental question.

[WebAssembly Interface Types](https://component-model.bytecodealliance.org/design/wit.html) gives components language-neutral names, types, imports and exports. That is valuable, but deliberately stops short of expressing the actual behaviour inside a function. It can tell us that `findJob()` exists and returns a `Job`; it cannot tell us whether that job comes from supplied data, `jobStore.findById()`, a text file or an HTTP request. Those are different programs even if their public signatures happen to match.

[Model Driven Architecture](https://www.omg.org/mda/) attempted to derive implementations from platform-independent models. The general history of model-driven development is a warning: once a model becomes sufficiently complete, it often turns into another specialised programming language; when developers edit the generated implementation, keeping both sides aligned becomes painful. AI changes the available translation mechanism, but it does not repeal the information problem.

[GitHub Spec Kit's description of spec-driven development](https://github.com/github/spec-kit/blob/main/spec-driven.md) makes a specification primary and code an expression of it. This is close in direction, but Program was intended to be file-addressable programming rather than a feature specification. “Build a notification system” is a request. “Call `notificationExists()` with this signature, exclude these records, call `notifySeverityThree()` with the remaining data, and return these values” is a program expressed without JavaScript syntax.

Work on bidirectional transformations and round-trip engineering showed that maintaining two editable representations has been difficult long before LLMs appeared. It established the problem, not the result for an AI translator working one file at a time with tests and versioned baselines.

Research on [program synthesis and semantic parsing](https://www.microsoft.com/en-us/research/publication/program-synthesis-and-semantic-parsing-with-learned-code-idioms/) also established that learned systems can bridge descriptions and code, while highlighting the gap between high-level intent and exact implementation. Current coding agents demonstrate that large models can create substantial software. They do not establish that a concise natural-language module contains enough durable meaning to recreate a mature program repeatedly.

Conventional documentation, pseudocode and API definitions were not answers either:

- Documentation is normally secondary and allowed to drift.
- Pseudocode is normally disposable and has no stable links to real modules and types.
- An interface records the outside shape but omits the behaviour connecting inputs to outputs.
- Source code records everything, including large amounts of target-specific machinery a reader may not need.

The proposed space was the missing middle: more exact than documentation, more behavioural than an interface, and less entangled with implementation than source code.

Our search did not prove that nobody had attempted exactly this combination. It did establish that prior work could not tell us whether our particular Program format, prompts, validators and target files would reconstruct working software. That required an experiment.

## Technical uncertainty

The core uncertainty was an information boundary.

A short English description is pleasant to read. It may also be useless to a compiler. A complete description may be sufficient, but so detailed that we have simply invented a verbose programming language with worse tooling. We could not determine in advance whether there was a useful point between those two failures.

Consider this innocent sentence:

> It loads the books, notes and loans from their corresponding paths.

Any human can guess what it means. A translator also can—and that is precisely the problem. Which path goes to which function? Where did those paths come from? Does the function receive them directly, receive an options value containing them, or read command-line arguments? “Corresponding” conceals data flow. The AI may make the right guess today and a different one next week.

The usable Program version has to expose the wiring without exposing JavaScript:

1. Take the `booksPath`, `notesPath` and `loansPath` fields from the supplied [Garden options].
2. Call `loadBooks()`, `loadNotes()` and `loadLoans()` with those values respectively.
3. Call `buildCatalog()` with the three returned collections.

That is longer, but it is still readable. More importantly, it owns the decision.

Several uncertainties followed from this:

### Could English preserve an exact call boundary?

`runProgSyncCommand(command, args, options)` is not equivalent to one object containing all of those fields. A description which lists every name but loses the fact that they form three arguments has lost program meaning. We did not know whether fixed natural-language forms would be enough, or whether Program would need a hidden formal syntax.

### Could internal machinery disappear safely?

Private methods should not become part of Program simply because the JavaScript author introduced them. A regenerated module must be free to inline, split or replace them. But private code sometimes contains an edge rule the public function depends on. The extractor must erase the helper while preserving the behaviour. It was not known whether an AI could make that distinction consistently.

### Could one file be translated without the whole repository?

An isolated module cannot understand an imported call from its name alone. On the other hand, giving every translator the entire repository would invite non-local assumptions, make results hard to reproduce and allow one file to absorb another file's responsibilities. We needed a bounded semantic closure: the current Program, direct provider interfaces, reachable shared types, retained assets and target instructions—but not arbitrary implementation elsewhere.

### Could a probabilistic model act inside a compiler?

A conventional compiler either accepts a defined program or emits a diagnostic. An LLM can return beautiful, confident and syntactically valid code with one missing export or one renamed public field. The uncertainty was therefore not only whether the model could generate code. It was whether deterministic parsing, candidate isolation, interface checks and independent tests could turn model output into something safe enough to use.

### Could two important representations coexist?

If Program alone is authoritative, hand-tuned implementation knowledge can be lost. If implementation alone is authoritative, Program becomes documentation. If both change independently, synchronization becomes conflict resolution. We did not know whether a private accepted checkpoint—previous Program plus previous implementation—would allow the system to distinguish a change on one side from unrelated drift on both.

None of these questions could be answered by inspecting a prompt. They required failed translations, real dependency graphs, clean reconstruction and tests which had not been generated from the same description.

## Competent professional assessment

The relevant fields are software-language engineering, program synthesis, static analysis and LLM-assisted software development.

A competent software engineer could build a conventional transpiler if Program had a formal grammar and fully defined semantics. That would answer a different question. A competent engineer could also build an excellent documentation generator, but that would not establish that the documentation could recreate the implementation.

The difficult point was the combination:

- natural English as the visible behavioural surface;
- stable module, symbol and type identities;
- AI synthesis rather than a fixed code generator;
- deterministic rejection around the synthesis step;
- preservation of an existing implementation during ordinary evolution; and
- source-free reconstruction as the ultimate test of sufficiency.

The result also depended on real model behaviour. It could not be deduced from model benchmarks. ProgSync contains JavaScript parsing, Vue parsing, HTML resource extraction, Git ancestry, private checkpoints, path safety, file permissions, context hashing, concurrency checks and exact diagnostics. Whether a set of Markdown modules could regenerate all of that was not reasonably knowable without attempting it.

The competent-professional position before the trial was therefore: the proposal was technically plausible, natural language generation was demonstrably capable, and the prior art provided useful patterns and warnings; however, only controlled reconstruction could establish whether the chosen representation retained enough observable behaviour while remaining readable.

## Hypothesis

The following hypothesis was recorded when the one-way Human Code model was formulated on 21 July, before ProgSync implementation began:

> If a Markdown Program preserves public symbols, shared complex types, cross-module calls, data flow and observable behaviour while omitting private implementation mechanics, then fresh isolated model calls should be able to reconstruct a working implementation without access to the former source, because the omitted choices should be private realization rather than program meaning.

The result would support the hypothesis if:

- Program could be created for a non-trivial multi-file application and for ProgSync itself;
- every managed implementation file could be generated in a separate repository containing no original implementation;
- generated files passed structural checks;
- the rebuilt software passed an independent behavioural oracle; and
- no generated JavaScript had to be manually edited to obtain the pass.

The decisive self-hosting threshold was all **73 of 73 untouched original ProgSync tests** passing after a clean build from frozen Program and retained non-generated inputs. A repaired tree could demonstrate that the format and compiler were improvable, but it would not by itself support reproducible reconstruction.

The hypothesis would be rejected for the tested design if working behaviour required access to the former implementation during clean generation, if Program had to reproduce private JavaScript mechanics, or if generated source required manual repair outside the Program/compiler process.

## Experiment design

We used a sequence of increasingly difficult trials. Each one was allowed to teach us enough to design the next; the final self-hosting threshold remained independent of those intermediate successes.

### 1. Derive the representation from a real function

We began with an existing alert-processing method rather than a toy `add(a, b)` example. The method filtered alerts, associated them with jobs, called outside modules, suppressed duplicates, checked stored notifications, sent email and recorded results.

We repeatedly translated it into English and rejected versions which were too high-level, too close to pseudocode or polluted by private helpers. This established the working boundary:

> Program preserves exported behaviour, cross-module calls, public data flow, ordering, effects and meaningful failures. It does not preserve private helper boundaries or target-language mechanics.

### 2. Build a narrow compiler/synchronizer

We implemented ProgSync as an extraction-ready package inside Vibe64, with its own library API and command line. It could:

- import `.js`, `.mjs`, `.html` and supported Vue files into Program;
- compile Program into a missing implementation;
- compare previous and current Program with previous and current implementation;
- select the direction automatically from the pair state;
- run a fresh Codex process against one bounded module;
- reject files written outside that module;
- parse and validate the candidate before installation; and
- store accepted pairs in a private Git ref without changing the project's branch, index or ordinary history.

### 3. Exercise incremental evolution

A small live fixture established the basic loop. A Program change from “Hello” to “Welcome” produced a one-line implementation patch. An implementation change from “Welcome” to “Greetings” produced a one-line Program patch. Repeating synchronization classified the pair as unchanged and made no model call.

This was a smoke test, not evidence for the broad hypothesis. It proved that the state machinery could distinguish accepted synchronization from two independently dirty files.

### 4. Generate a real 21-module application

We wrote a text-backed Reading Garden application entirely as Program. It contained parsing, validation, file I/O, catalog construction, search, filtering, recommendations, statistics, HTML reporting and a command-line entrypoint. The retained inputs were `package.json` and three pipe-delimited data files.

The first implementation was generated one file at a time. We then preserved it, created a clean repository with Program and retained inputs only, and regenerated all 21 JavaScript files with fresh model calls. The same behavioural checks were run against the result.

### 5. Make ProgSync generate itself

The self-hosting trial was the main experiment.

Fresh source-to-Program calls produced one Program counterpart for every one of ProgSync's 33 JavaScript-family files: library modules, CLI, package descriptor, support code and all test suites. A shared `types.md` brought the Program inventory to 34 documents.

We then created a separate genesis repository containing those documents, prompts, schemas, retained package files and dependencies—but no original `.js` or `.mjs` implementation. ProgSync generated every target using isolated module calls.

Two test suites were kept separate:

- the tests regenerated from Program, which showed whether tests themselves could be expressed and reconstructed; and
- the untouched original 73-test suite, which served as the independent behavioural oracle.

The generated suite was never permitted to certify the implementation which had been generated from the same compressed source.

### Variables and controls

| Role | Measure |
| --- | --- |
| Varied | Completeness of Program boundary descriptions; Program-author prompt; JavaScript translator prompt; deterministic extraction and conformance rules |
| Held constant | Same ProgSync target, retained package inputs, original 73-test oracle, file-by-file write boundary, fresh module contexts, and no original source in clean repositories |
| Observed | Generated target count, candidate rejection, generated-test results, untouched-test results, required Program/compiler changes, repeat-sync convergence and textual versus behavioural reconstruction |
| Success threshold | All 33 ProgSync targets generated from frozen Program and all 73 untouched tests passed without Program changes or manual generated-JavaScript repair during that clean run |
| Failure threshold | Original source was required, generated JavaScript needed direct manual repair, or the frozen clean build could not satisfy the independent oracle |

The model and prompt versions, timestamps, repositories, commands and detailed run logs were retained with the private experimental record. The public evidence contains the stage results without publishing disposable model transcripts or machine-specific paths.

## Work performed

### 21 July 2026 — from idea to working vertical slice

- **11:19 AWST:** Recorded the initial problem: Vibe64 could help anybody produce a program, but the resulting code remained obscure to most people.
- Compared the idea with interfaces, model-driven development, spec-as-source systems and bidirectional synchronization.
- Used a real notification method to distinguish observable module behaviour from private implementation structure.
- Rejected early descriptions that hid outside calls, repeated private helpers or described only business outcomes.
- Adopted the name **Program** for the Markdown source tree, drawing directly on Wirth's algorithms-plus-data-structures formulation.
- Defined `## Uses`, `## Provides`, exported classes and methods, shared `[Type]` references and root-based `@/` links.
- Defined `.md.json` as a deterministic projection for fast symbol and relationship access, not as a second authored source.
- Implemented the first ProgSync package in Vibe64 ([`574c5203` — add ProgSync prototype](https://github.com/mobily-enterprises/vibe64/commit/574c5203)), then added synchronization hardening, shared-type creation and closure, and strict authoring rules in subsequent work.
- Added separate target prompts for JavaScript, HTML and Vue, with a shared atomic synchronization protocol.
- Implemented isolated Codex candidate generation, allowed-path checks, deterministic Program parsing and source-surface validation.
- Replaced ordinary Git-diff inference with accepted-pair checkpoints stored under a private worktree-local Git ref. This let both files remain dirty against `HEAD` while ProgSync still knew they had been reconciled.
- Completed the live incremental smoke test in both directions and confirmed a repeated run invoked no AI.

### 22 July 2026 — real application generation

- Finalised the rule that `[Type]` references resolve through the shared type registry while `Uses` remains reserved for operational symbols.
- Created 22 Reading Garden Program documents producing 21 JavaScript modules.
- Generated and ran the application through its real command-line boundary.
- Added transitive shared-type closure when `Catalog` required `CatalogBook`, which in turn required `Book`, `Note` and `Loan`.
- Corrected vague Program data flow such as “corresponding paths” and traced command-line data from `process.argv` through parsed options, file paths, records, catalog operations and the output report.
- Excluded runtime output from the managed source set after mass discovery attempted to treat a generated HTML report as source.
- Corrected a decimal half-rounding ambiguity in Program and a separate JavaScript floating-point translation defect.
- Performed a clean reconstruction. All 21 JavaScript files were generated without their predecessors and passed the application checks.
- Repeated synchronization; every pair reported `NO_CHANGE`, completed in 4.6 seconds and invoked no model.

### 22 July 2026 — self-hosting

- Inventoried all 33 ProgSync JavaScript-family files and established a passing 73-test original baseline.
- Generated 33 Program counterparts with fresh source-to-Program calls, plus shared types; deterministic validation passed all 34 documents.
- Added explicit Program surfaces for command files and test suites when self-hosting demonstrated that “has no exports” does not mean “has no public behaviour.”
- Created a source-free repository and generated all 33 implementations. Every candidate passed the then-current structural gate.
- Ran the generated tests and untouched oracle, classified the failures by shared root cause and began a repair loop which changed Program, prompts or deterministic tooling—not generated JavaScript by hand.
- Added canonical object-parameter grouping, imported-call grouping, exact result-field provenance, exact machine-observed literals, complete shared complex types, executable-mode preservation, bounded interface closure and repair-grade diagnostics.
- Fed trusted failing tests into module-bounded repair runs when structural checks could not observe runtime defects.
- Reached 73/73 untouched tests on a repaired source-free tree.
- Started a new clean generation from the improved Program and compiler. It initially reached 39/73, then 59/73 after one explicit completion dependency, 66/73 after a narrower call-group rule, and 73/73 after further bounded Program/compiler repairs.
- Began a third frozen clean generation intended to distinguish reproducibility from a successfully repaired tree. Five of 33 targets had completed when the recorded period ended; no final behavioural result was available.

The versioned v1 implementation and research material ran from the initial
prototype at `574c5203` to the hardened checkpoint at `c44e3356`: nine focused
commits affecting 46 ProgSync and research-record files, with 13,440 inserted
and 1,316 removed lines. These figures establish the retained development
boundary; they are not a measure of research success.

## Observations

### We were not writing documentation

The first surprise was how quickly an apparently good explanation became useless as source.

“Finds a job” is documentation. It does not say where the job comes from.

“Finds the job in the database” is still too smoky. Which module owns the database? Which function is called? What is passed to it?

A Program statement such as this is different:

> The function `findJob()` takes `jobId`, a [Job ID]. It calls `jobStore.findById()` with `jobId` and returns the [Job] returned by that call, or nothing when the call returns nothing.

That sentence contains a real software connection. A different implementation can choose its private machinery, but it cannot silently replace the store call with a text-file scan. The outside call is architecture.

This led to a useful rule: **data is king**. Every value must come from an input, an earlier result, a declared literal, module-owned state or a named outside call. Natural English is allowed. Magic is not.

### Readability sometimes means using a list

We initially tried to keep every function in compact prose. That failed for orchestration. A paragraph containing eight outside calls and six intermediate results is technically English but visually worse than code.

Numbered points worked better. They made order and data provenance visible without reintroducing loops and temporary variables. Short functions remained sentences; orchestration functions became sequences of semantic transformations.

This is a small observation, but an important one. “Natural language” does not mean “everything must be a paragraph.” Markdown gives us headings, lists, links, tables and examples. The format should use them.

### The Reading Garden worked—and immediately found things we had missed

The smaller full application was successful, but not on the first effortless pass.

It exposed missing transitive types, vague data wiring, unmanaged runtime output and an ambient-data case (`process.argv`) the JavaScript extractor did not recognise. Its clean reconstruction also produced an average rating of `4.62` where the expected decimal half-up result was `4.63`.

That rounding failure was particularly instructive. “Rounded to two decimal places” did not state how a half should be resolved. We added the semantic example `4.625 → 4.63` to Program. A fresh translation then attempted to compensate for binary floating point, but used an unscaled `Number.EPSILON` and still failed. That second failure belonged to the JavaScript translator rather than Program. After a generic translator correction and another from-zero generation, the module passed.

The final clean Reading Garden result was strong:

- 22 Program documents produced 21 working JavaScript modules;
- all application behavioural groups passed;
- all files passed syntax and Program checks;
- a second synchronization made no changes and no AI calls;
- five regenerated files were byte-identical to the previous implementation;
- sixteen were textually different but behaviourally equivalent under the checks.

The last point is exactly what we wanted to see. Program did not preserve whether the implementation used one loop or two helpers. It preserved the result.

### Making ProgSync generate itself taught us more than making it generate an example

The Reading Garden was designed in Program from the beginning. ProgSync was not. It was a mature-enough JavaScript package full of awkward edges, and that made it a much better teacher.

The first clean self-host generated all 33 target files. Every file parsed. Every file passed the structural checks available at that time.

Then only **14 of 73 untouched tests passed**.

That was the most valuable result in the four-day research period.

It showed that our structural checks could prove that functions existed while completely missing whether modules agreed on the data crossing between them. The generated code looked like software. It simply was not the same software.

The failures were not 59 unrelated hallucinations. They clustered around a handful of missing semantic contracts:

#### Argument groups had been flattened

The source contained APIs such as:

```js
runProgSyncCommand(command, args, options)
```

Early Program listed `command`, `args` and all of the option fields, but lost the fact that the last fields belonged to one object and that the complete call had three arguments. One generated function accepted eleven positional parameters; some generated callers passed one object. Every name was present. The program was still wrong.

Canonical wording—“three arguments: `command`; `args`; and one object containing…”—and deterministic parameter-group extraction removed this entire class of ambiguity.

#### Friendly field names were incompatible field names

An operation had to return a snapshot with fields named `P0`, `P1`, `I0` and `I1`. A generated implementation returned the more descriptive `previousProgram`, `currentProgram`, `previousImplementation` and `currentImplementation`.

That was a reasonable local choice and a broken program. Consumers expected the compact public contract. Program needed the exact fields and their provenance, not merely the concept “previous and current files.”

The same problem appeared in status strings, diagnostic identifiers, mode names and absence versus `null`. If another module, process, file, test or user observes a value, an equivalent-sounding replacement is not equivalent.

#### Commands and tests have behaviour without exports

A command with a shebang may export nothing, yet its arguments, output, exit status and file mode are public behaviour. A test file may export nothing, yet it registers fixtures, operations and assertions.

Self-hosting forced Program and the deterministic extractor to recognise both surfaces. It also showed that executable permission is not natural-language behaviour for the model to improvise; it is deterministic compiler responsibility.

#### Completion order can be one word with twenty consequences

During a later clean run, generated `conformance.js` called the completion-returning `extractSourceFacts()` and immediately used the unfinished result. The failure appeared throughout the test suite as `sourceFacts.exports is not iterable`.

Adding one explicit completion requirement produced a one-line `await` patch and raised the untouched result from **39/73 to 59/73**. Twenty failing tests were one missing dependency in time.

This is why raw failure counts must be interpreted carefully. They measure the damage, not necessarily the number of underlying omissions.

#### Generated tests cannot be their own independent witness

The regenerated test suite sometimes omitted or distorted the same behaviour as the regenerated implementation. On one repaired tree, the untouched suite passed 73/73 while the generated suite passed only 32/71. On a subsequent clean generation, the generated suite contained all 73 tests but initially passed only 25.

Tests written from Program are valuable. They can link expectations back to readable behaviour. They cannot prove that the original application was assimilated faithfully when both tests and implementation came from the same compressed representation.

Legacy import needs retained evidence: original tests, recorded traces, fixtures, protocol examples or another oracle not synthesized from Program.

### The observed progression

| Stage | Untouched behavioural result | What it established |
| --- | ---: | --- |
| Reading Garden clean regeneration | All 15 behavioural groups passed | A Program-native 21-module application could be rebuilt after one semantic and one generic translator correction |
| ProgSync clean self-host A | 14/73 | Structural surface parity was nowhere near behavioural equivalence |
| Repaired self-host A | 73/73 | Program/compiler repairs could recover the complete oracle without hand-editing generated JavaScript |
| ProgSync clean self-host B | 39/73 | Improvements carried into a fresh tree, but not yet completely |
| After explicit completion rule | 59/73 | One missing temporal dependency caused twenty failures |
| After call-group correction | 66/73 | Cross-module grouping remained the dominant contract weakness |
| Repaired self-host B | 73/73 | A second tree could be repaired through bounded Program/compiler changes |
| Frozen clean self-host C | Not completed | Reproducibility remained untested at the end of the record |

Two repaired 73/73 results are meaningful. Neither is the same as a frozen, zero-intervention 73/73 run.

### The AI was not the only thing being tested

The tendency with AI work is to ask whether the model is “good enough.” That question turned out to be too simple.

Some failures were model synthesis defects: a candidate forgot an export, chose an incorrect private name or failed to wait for a result even though Program implied the dependency. Some were Program omissions: the exact object fields or decimal tie behaviour were not present. Some were creator-prompt defects: source-to-Program conversion had thrown away argument grouping. Some were compiler defects: Program stated a rule, but the validator could not check it. Some were test defects: one Reading Garden expectation searched for a title which did not exist in its own fixture.

The useful unit was therefore not “the prompt.” It was the complete system:

```text
Program authoring
        ↓
deterministic Program projection
        ↓
bounded AI synthesis
        ↓
candidate parsing and boundary checks
        ↓
module and integration evidence
        ↓
accepted Program/implementation checkpoint
```

Every failure had to be assigned to the correct layer. Adding more prose to Program to compensate for a private JavaScript naming collision would have made Program worse. Patching generated JavaScript to make one test pass would have hidden whether the next clean build learned anything.

## Evaluation

The strict success threshold was not met during the recorded period.

The first Program-native application demonstrated clean reconstruction at useful scale. ProgSync itself demonstrated that complete behaviour could be recovered through Program and compiler repairs without directly editing generated JavaScript. The improvements were not cosmetic: a later source-free run began at 39/73 instead of 14/73, and specific general rules produced large, measurable gains.

However, the hypothesis required more than a repairable system. It required frozen Program and compiler inputs to reconstruct the package and pass the independent oracle without intervention. The final clean repeat had only generated five of 33 targets when the record ended. We therefore did not know whether the latest improvements generalized across the complete package.

The evidence supports several narrower findings:

1. **Source can be projected into readable Program.** Fresh model calls produced Program for all 33 ProgSync files, including commands and tests, and deterministic validation accepted 34 documents including shared types.

2. **Program can generate non-trivial working software.** The Reading Garden clean build produced 21 JavaScript modules with behaviourally equivalent but mostly textually different implementations.

3. **Module-scoped repair is practical.** Exact diagnostics repeatedly led to small corrections while rejected candidates remained isolated.

4. **Natural prose alone is insufficient.** Stable symbol links, shared types, parameter groups, public field names, imported-call groups and exact observed literals form a small deterministic spine around the English.

5. **Self-hosting is a powerful conformance test.** It exposed language and compiler gaps which a purpose-built example did not.

6. **Implementation remains valuable.** The system must preserve target-specific refinements during normal evolution even if Program can create a new implementation from nothing.

Important claims remain untested:

- whether people who do not read JavaScript understand Program more accurately or quickly;
- whether they can safely change a real program through this representation;
- whether a second target language can implement the same Program;
- whether Vue and visual work retain layout, accessibility and interaction refinements over repeated changes;
- whether multiple frozen clean generations pass consistently rather than occasionally;
- whether bounded context and dependency invalidation remain economical across hundreds of files; and
- whether the candidate runner can be hardened as a production security boundary.

### Conjectures produced by the work

The observations created several ideas worth testing rather than declaring true.

**Program may be a better review surface than source code.** A source diff often contains refactoring and framework churn around one semantic decision. A Program diff could show the decision directly. This may help experienced developers as much as non-programmers, but it needs controlled comprehension and review experiments.

**Natural-language programming may work because it is not completely natural.** The body can remain English while links, symbol names, argument groups, type references and exact literals act as formal islands. This is not a retreat from the idea. Written mathematics has used ordinary language around formal symbols for centuries.

**Reasons may be first-class program information.** Code tells us what happens and sometimes how. It often loses why. Program can retain a sentence such as “notification failures do not interrupt the caller because alert processing must continue.” A translator can use that reason when adapting the implementation, and a person can challenge the decision directly.

**A legacy project and a Program-native project need different trust models.** In a new Program-native project, omitted behaviour is simply unspecified and can be resolved before release. In a legacy import, omission means compression may have silently lost existing behaviour. Assimilation should therefore carry states such as draft, structurally closed, behaviourally checked and clean-generation proven.

**The deterministic projection could power Vibe64's City Explorer.** `Uses`, `Provides`, types and source links already form a project graph. The `.md.json` projection can make that graph fast to query without asking an LLM to rediscover it. This is useful even if Program never becomes the primary write surface.

**Self-hosting should become a permanent benchmark.** The 73-test oracle contains parsers, Git, file modes, concurrency, exact diagnostics, commands, Vue and HTML. It should be retained as a conformance corpus across prompt, model and compiler changes. A model upgrade must not silently redefine the language.

**Programming AIs may work better on Program than on source.** Program removes private machinery from the context and presents explicit module boundaries, types and external data flow. That may make feature work easier for an agent, not only for a human. We did not measure this, and it is an especially important next experiment for Vibe64.

**Portability may be possible without pretending every target is equivalent.** A Program module could compile to another supported language when the target provides its required capabilities. This is plausible for pure transformations and ordinary services. It is much less obvious for browser UI, concurrency, cryptography or performance-critical work. One second-target trial would tell us more than another hundred paragraphs of argument.

## Logical conclusion

The hypothesis remains **inconclusive**.

We did turn existing source code into natural-language Program. We used Program to generate a real 21-module application from nothing. We made ProgSync describe its own compiler, commands and tests, removed its implementation, and rebuilt all 33 files. After structural improvements and bounded repairs, the rebuilt package passed all 73 untouched tests without a human directly editing the generated JavaScript.

But the first clean self-host passed only 14 tests. The next clean self-host passed 39 before further intervention. Those failures taught us an enormous amount—especially about exact data contracts—and the repaired results reached 73/73. The final frozen repeat, which would show whether the lessons had truly become part of the system, did not finish within this record.

So the answer to “Can we turn source code into natural language?” is not yet yes.

It is also no longer a philosophical question.

There is now a real package inside Vibe64 with a CLI and library API, Program authoring instructions, target prompts, shared types, deterministic projections, AST-based conformance checks, private accepted checkpoints, isolated candidates and a substantial test suite. It is ready to be integrated into Vibe64 in controlled stages: first as a readable view and project graph, then as an opt-in source of reviewable changes.

It is not ready to become Vibe64's unquestioned source of truth. Before that happens, the same frozen Program must rebuild ProgSync cleanly more than once, the untouched oracle must pass without mid-run correction, and actual users must demonstrate that Program is easier to understand and change.

We know enough to integrate it.

We do not yet know whether it will work.

That is the honest end of the first experiment—and a much better place to be than where we started four days earlier.

The later [v2 self-hosting
experiment](/research/rd-2026-007-when-the-compiler-writes-itself/) replaced
this implementation-shaped Program graph with five deliberately smaller
Program files and obtained a stronger result. It is recorded separately
because it tested a changed architecture and hypothesis; it does not
retroactively turn this frozen v1 experiment into a successful clean repeat.

## Supporting activities

The following work was directly related to designing, conducting or evaluating the experiment:

- building the ProgSync library and CLI needed to perform isolated import, compilation and synchronization trials;
- creating deterministic Program parsers, projections and candidate validators;
- creating private Git checkpoint state so repeated experimental runs had an exact accepted baseline;
- constructing the Reading Garden fixture and its behavioural checks;
- creating clean-room self-host repositories and retaining the untouched original test oracle;
- adding regression tests for each general defect found during reconstruction;
- recording prompts, candidate diagnostics, run results and failure classifications; and
- writing the public experimental record and retaining detailed private evidence.

Routine Vibe64 interface work, production deployment, general product maintenance and any future commercial integration are outside this entry unless separately assessed and recorded. The existence of a technical uncertainty or a research diary entry does not by itself determine R&amp;D Tax Incentive eligibility or expenditure treatment.
