---
title: When the compiler writes itself, what is the source?
id: RD-2026-007
record_id: RD-2026-007
project: program-source
core_activity: CA-01
activity_type: core
status: concluded
result: supported
summary: >-
  We replaced an implementation-shaped natural-language corpus with five small
  Program files, rebuilt ProgSync without its former source, and tested the
  result against an independent 55-case oracle. The build worked, but one clear
  synthesis error showed why verified generated code cannot be disposable.
tax_year: "2026-27"
started: "2026-07-23"
ended: "2026-07-23"
duration_days: 1
research_hours: 15
research_hours_basis: recorded
hypothesis_recorded: "2026-07-23 01:39 +0800"
investigators:
  - Tony Mobily
tags:
  - ai
  - natural-language
  - program
  - progsync
  - self-hosting
  - compiler
  - vibe64
example: false
evidence:
  - label: Experiment record
    type: YAML
    url: /evidence/RD-2026-007/experiment-record.yml
  - label: Clean-generation ledger
    type: YAML
    url: /evidence/RD-2026-007/generation-ledger.yml
  - label: Recorded generation and verification results
    type: CSV
    url: /evidence/RD-2026-007/results.csv
  - label: Completed Vibe64 v2 milestone
    type: Git
    url: https://github.com/mobily-enterprises/vibe64/commit/0ab44e2f2b277fce8f9369b10e4f80777a5ad6a7
next_experiment: >-
  Freeze the five-file Program corpus, prompts, retained inputs and model
  settings; perform two more source-free generations and require each to pass
  the complete public oracle without a Program correction, then exercise a
  deliberate change on both Program and managed implementation to test the
  three-way reconciliation model.
---

## Research question

Five Markdown files were enough to rebuild the compiler.

That was the good news.

The bad news was considerably more interesting.

The [previous experiment](/research/rd-2026-004-source-code-into-natural-language/)
ended with a natural-language version of ProgSync containing 34 Program
documents: one shared type file and one Markdown counterpart for each of the 33
JavaScript files in the package. It looked sensible. It was complete in a very
literal way. It was also based on a mistake.

We had taken an existing JavaScript implementation, inspected its files and
exports, and built a readable Program graph which largely preserved that
structure. The prose improved over several generations. Types became more
exact. Calls acquired proper argument groups. Errors and return values stopped
changing their names. Yet we were describing the wrong thing ever more
accurately.

An exported JavaScript helper is not necessarily part of a program's
architecture. It may be exported because one other file happens to use it. It
may exist because it was convenient to test in isolation. It may merely be the
place where the original programmer chose to put twenty lines of code. None of
those facts means that a human-readable source language should preserve it
forever.

The correction came just after 1:30 in the morning:

> A callable belongs in Program when it is a real external boundary, or when it
> is deliberately used by at least two distinct production Program modules.
> Tests do not count.

Everything else is private implementation owned by the nearest surviving
Program module.

That rule gave us a new research question:

> Can an AI reconstruct a working self-hosted compiler from a deliberately
> smaller Program which preserves public behaviour and intentional
> architecture, but does not preserve the former implementation's file and
> helper graph?

There was a second question hiding inside the first. If the reconstruction
worked, could its generated JavaScript be treated like object code—something
which could be deleted and recreated at any time—or would the generated
implementation itself contain knowledge worth preserving?

We expected the experiment to answer the first question. We did not expect it
to answer the second quite so decisively.

## Intended new knowledge

The purpose of the work was to identify the correct authority boundary between
Program and the code it creates.

Program is our proposed human-readable source: Markdown which names the
operations a module provides, the public operations it uses, the complex data
which crosses its boundary, and its observable behaviour, effects and
failures. The managed implementation is conventional code—JavaScript in this
experiment—which realizes that meaning on a particular target.

The earlier corpus had demonstrated that a very detailed Program could be made
to regenerate a large package after enough correction. It had not established
that the resulting Program was a good source language. If every private helper,
file boundary and testing seam survives assimilation, then Program becomes an
English transcription of JavaScript. A person must understand essentially the
same architecture, only with more words.

We wanted to learn whether aggressive architectural compression was possible.
Specifically:

1. Could the 33 target-shaped Program modules be replaced by four actual
   production modules and one shared type registry?
2. Could a new model reconstruct all necessary private files without being told
   what those files used to be called or how the old implementation divided the
   work?
3. Could an independent test oracle judge behaviour without requiring the new
   package to resemble its ancestor?
4. Could failures be separated into missing Program meaning, model synthesis
   errors, defective tests and acceptable private variation?
5. If a generated implementation acquired a verified repair, could later
   synchronization retain it without turning private mechanics into Program?

The final point changes the compiler analogy. In an ordinary compiler, generated
machine code is disposable because the compiler is intended to be
deterministic: compile the same source for the same target and it should make
the same relevant decisions again. An AI does not provide that guarantee. If it
can make a mistake despite sufficient source, then throwing away a repaired
implementation may throw away knowledge.

## Existing knowledge

The starting evidence was the first ProgSync self-hosting experiment, not a
fresh literature question.

That work had already established several useful facts:

- natural language can describe real modules rather than merely product
  requirements;
- names, signatures, parameter groups, shared types and exact observed values
  form a necessary deterministic spine around the prose;
- independent behavioural tests reveal failures which syntax and export checks
  cannot see;
- regenerated files can differ substantially from their predecessors while
  retaining tested behaviour; and
- tests generated from the same Program cannot independently certify that
  Program.

It also exposed the central weakness in our existing corpus. We had used the
former JavaScript graph as both evidence and architecture. White-box test
exports became Program functions. One-consumer helpers became cross-module
contracts. Implementation filenames appeared to carry meaning merely because
they existed.

Conventional compiler practice supplied one tempting assumption: source is
authoritative and generated output is replaceable. Conventional round-trip
engineering supplied the opposite warning: once people make valuable changes
to a generated target, regeneration can destroy them. Neither body of practice
could tell us how a probabilistic translator should divide authority between a
readable semantic source and a tested, target-specific implementation.

The relevant prior evidence therefore left two technically plausible outcomes.
A smaller Program might be a better abstraction and still generate the same
public behaviour. Or it might omit so much working knowledge that a model could
only produce a plausible imitation. Likewise, a generated implementation might
be safely reproducible from Program, or it might accumulate verified
realization details which Program deliberately does not contain.

Only a clean build and an implementation-independent oracle could distinguish
those outcomes.

## Technical uncertainty

The uncertainty was not whether an AI could write JavaScript. It plainly could.
The uncertainty was whether it could write the *right* JavaScript after we
removed most of the structure it had previously been given.

The new root Program module provided seven public operations. It did not
prescribe a parser file, a Git file, a state file, a lock file, a candidate
file, a prompt file and a service file. It simply owned any private
implementation below `src/index/`. The model could create one large file, ten
small files, or twenty private auxiliaries. It could rename private operations,
replace algorithms and choose a different checkpoint representation.

That freedom created four distinct risks.

### Compression could erase architecture rather than clarify it

The rule about two production consumers is a heuristic for identifying
intentional shared architecture. A function used by only one module may still
encode an important conceptual boundary. Conversely, a helper used by several
files may be an accident of code reuse rather than a semantic service. It was
not knowable in advance whether the rule would preserve enough of ProgSync's
meaning.

### The old test suite could smuggle the old implementation back in

A test which imports `src/index/checkpoint.js`, examines a private lock-file
shape, or demands one exact internal diagnostic sentence is not an independent
behavioural oracle. It makes the former implementation mandatory through the
back door.

The tests therefore had to use only the package root, its public CLI subpath,
the executable and the exported package descriptor. Yet they still had to
exercise concurrency, rollback, parsing, file modes, Git state, cancellation
and clean synchronization strongly enough to catch a superficially convincing
compiler.

### A correct Program could still produce incorrect code

Natural language may be sufficient while an individual translation is not.
That distinction is essential. If an observed failure always causes us to add
more prose, Program will eventually absorb every private branch of one
implementation. If every difference is dismissed as model variation, the
compiler will silently be wrong.

We needed a classification with four outcomes:

- **Program omission:** necessary observable meaning was absent or materially
  ambiguous.
- **Synthesis defect:** Program said enough, but the generated implementation
  did not honour it.
- **Oracle defect:** a test constrained a private representation or wording
  which Program intentionally left free.
- **Acceptable variation:** behaviour remained correct through a different
  private design.

### Successful generation might still lose durable knowledge

Even if a clean package passed every test, a later model invocation could make
a different mistake. We did not know whether ordinary development should
regenerate a module from Program, patch the existing implementation, or
reconcile both against their previous accepted state.

That could only become visible after the generated compiler had been asked to
take over its own maintenance.

## Competent professional assessment

The relevant fields are programming-language design, program synthesis,
software architecture, static analysis and LLM-assisted development.

A competent engineer could design a formal intermediate language and write a
deterministic compiler for it. That would not answer this question: Program is
intended to remain readable English, with formal islands for symbols, types,
links and exact values. A competent engineer could also expose every exported
JavaScript function in Program. That would produce a more predictable
translation, but would preserve the implementation architecture we were
specifically testing whether we could remove.

Existing software-engineering methods do not determine which parts of an
arbitrary implementation are its durable semantic architecture. Static
analysis can count consumers and identify exports, but it cannot by itself
decide whether an exported helper exists for public use, for testing, or by
historical accident. Nor can model capability benchmarks establish whether one
particular five-file Program corpus is sufficient to reconstruct a Git-aware,
concurrent, self-hosting compiler.

The competent-professional assessment was therefore that the reduced
architecture was plausible and informed by the previous experiment, but its
sufficiency and the durability of generated code could not be deduced in
advance. A source-free build, a withheld public oracle and a no-AI handoff were
required.

## Hypothesis

The hypothesis was recorded when the implementation-shaped corpus was rejected
and the production-surface rule was adopted:

> If Program retains only genuine external boundaries and operations
> intentionally shared by at least two distinct production Program modules,
> while expressing their complete observable behaviour and public data
> contracts, then a five-file Program corpus should be sufficient for isolated
> AI translators to reconstruct a working ProgSync package without access to
> its former source or private architecture.

The hypothesis would be supported if:

- the reduced corpus passed its deterministic Program check;
- all four production targets could be created in a clean repository containing
  no former production JavaScript or tests;
- the resulting private file graph could differ from the mature implementation;
- the generated package could be brought through Program-driven
  synchronization to pass every implementation-independent public test without
  hand-editing generated JavaScript; and
- with Codex unavailable, the generated compiler could accept its own
  verified state and subsequently report no change without altering a byte.

The hypothesis would be rejected if the former private file graph or private
test access had to be restored, or if a working result required direct manual
repair of generated JavaScript.

We also carried a secondary conjecture from the first experiment: once Program
was sufficient, managed implementation might be disposable. That was not
required to support the primary hypothesis, and the observations ultimately
rejected it.

## Experiment design

The experiment began with a non-AI production-surface audit of every export in
the mature package. For each symbol we recorded its production consumers, test
consumers, external status, whether two distinct production modules needed it,
its proposed disposition, and the Program module which would own the behaviour
if the symbol became private.

The resulting v2 corpus had five files:

| Program file | Public responsibility |
| --- | --- |
| `program/src/index.js.md` | Seven package-root operations and ownership of private `src/index/` implementation |
| `program/src/cli.js.md` | The public `runCli()` operation |
| `program/bin/progsync.js.md` | The executable command boundary |
| `program/package.descriptor.mjs.md` | The exported package descriptor |
| `program/types.md` | Shared complex data contracts |

There were no Program test modules.

A clean Git repository was then prepared with those five files and retained
inputs such as package metadata, compiler prompts, the result schema and
documentation. It contained no production `src/`, executable implementation,
descriptor implementation, former JavaScript, or tests.

Four fresh Sol/xhigh model invocations generated the executable, descriptor,
CLI and root library. The smaller targets were generated independently while
the root generation ran. Candidates were accepted only after deterministic
syntax, ownership and public-surface checks. Production source was committed
inside the experimental repository before the withheld oracle was introduced.

The oracle was audited so that it could import only documented public
boundaries. Failures were classified against Program before any change was
made. Program omissions and compiler rules could be corrected; private
implementation differences could not be turned into requirements merely to
make the new package resemble the mature one. Generated JavaScript was never
edited by hand.

Finally, Codex was removed from `PATH`. Each generated production module had to
accept a committed baseline without AI and then converge under an ordinary
invocation. Before-and-after hashes had to remain identical.

### Variables and controls

| Role | Measure |
| --- | --- |
| Varied | Program architecture: 33 implementation-shaped target modules were replaced by four production modules plus one shared type registry |
| Held constant | ProgSync target, retained package inputs, Sol/xhigh model class within each generation, bounded per-module context, candidate ownership rules and public behavioural requirements |
| Observed | Generated targets and files, candidate acceptance, Program diagnostics, public-oracle pass count, hand repairs, no-Codex convergence and byte hashes |
| Success threshold | Generate all four targets from the five-file corpus; reach a complete pass of the implementation-independent oracle using only Program/compiler reconciliation; then return `NO_CHANGE` for all four targets with Codex unavailable and byte-identical files |
| Failure threshold | Require former private source or test modules, constrain the result to the old private graph, directly edit generated JavaScript, or fail the public oracle after bounded Program/compiler correction |

The test count grew from 53 to 55 when the handoff exposed two new public
behavioural cases. This was a recorded extension of the oracle, not a reduction
of the success threshold.

## Work performed

On 23 July 2026, the following experimental work was performed:

- stopped the in-progress v1 generation when it became clear that its Program
  corpus preserved accidental JavaScript architecture;
- recorded the production-consumer rule and the distinction between public
  meaning and private realization;
- audited the complete existing export surface without using an AI to decide
  which test-only and one-consumer helpers should survive;
- rewrote the Program corpus from scratch as four production modules and one
  shared type file;
- rewrote the independent oracle so it exercised public behaviour without
  importing private helpers or requiring private storage layouts and wording;
- created several clean generation repositories while correcting general
  candidate-runner, parser, dependency and validation defects;
- executed the definitive source-free generation with separate isolated model
  calls for all four production targets;
- introduced the withheld oracle only after the generated source had been
  frozen in the experimental repository;
- classified each observed failure as Program omission, synthesis defect,
  oracle defect or acceptable variation;
- used Program-driven minimal reconciliation to evolve the generated package
  without directly editing its JavaScript;
- expanded the public oracle for forwarded exports and explicit-baseline
  precedence;
- removed Codex from the execution path and performed baseline acceptance,
  ordinary convergence and byte-hash checks;
- recorded the detailed chronology, model timings, test counts and architectural
  findings in the retained source session and experiment files linked below; and
- consolidated the completed work in [Vibe64 commit
  `0ab44e2f`](https://github.com/mobily-enterprises/vibe64/commit/0ab44e2f2b277fce8f9369b10e4f80777a5ad6a7).

The public total for this continuation is 15 research hours. Private company
time and expenditure records remain the accounting source for any later
eligibility or expenditure assessment.

## Observations

### Fewer Program files produced more implementation files

The old corpus contained 34 Program documents and attempted to preserve 33
target files. The v2 corpus contained five documents.

From those five documents, the definitive clean build produced all four
production targets. The pure-generation commit added 23 production
implementation files and four deterministic Program projections: 27 generated
files in total. Nineteen of the production files were private root auxiliaries
beneath `src/index/`. Program did not name those auxiliaries because their
names and boundaries were not part of the package's meaning.

All four production candidates were accepted on their first attempt:

| Target | Generation time |
| --- | ---: |
| Executable | approximately 58 seconds |
| Package descriptor | approximately 68 seconds |
| CLI | approximately 4 minutes 29 seconds |
| Root library | approximately 37 minutes 30 seconds |

The timing is not a performance claim. It does reveal why module boundaries
matter. Three small public boundaries could be generated independently while
the much larger root was working. It also explains why a mature root
implementation should normally receive a small reconciled patch rather than a
37-minute reconstruction.

The result supports the architectural compression. A Program module did not
need a one-to-one relationship with every private implementation file. One
readable root module could own a private implementation graph chosen by the
target translator.

### An export is not automatically architecture

The production-surface audit removed a large number of symbols from Program.
Test-only exports disappeared. One-consumer helpers disappeared. Wrapper
functions which merely duplicated a more general public operation disappeared.
Their behaviour did not disappear: it was absorbed into the public operation
which owned it.

There are necessary exceptions. A command, an HTTP handler, a package API, a
framework callback or an executable entrypoint may be genuinely public even
when no second Program module calls it. The rule is not “count to two and stop
thinking.” It is:

> Preserve intentional public collaboration. Do not preserve an implementation
> seam merely because JavaScript can import it.

This changed the role of tests. Tests constrain behaviour, but they do not
create Program symbols. If a test can only exercise an observable guarantee by
importing a private helper, the test should normally be rewritten through a
public boundary rather than promoting the helper into the source language.

### Correctness had to stop meaning resemblance

The clean implementation did not always use the mature package's private
files, names, diagnostics, lock representation or checkpoint encoding. That
was expected and desirable.

The oracle initially contained assertions which treated some of those
differences as errors. One test required a particular internal evidence-field
name. Another assumed a lock directory and owner-record schema. A retry test
expected one exact English phrase even though the generated diagnostic carried
the required symbol, provider and export facts.

Those assertions were defects in the experiment. They tested genealogy—whether
the new compiler descended visibly from the old one—rather than behaviour.
They were replaced with representation-independent checks.

This gave us a practical definition:

> A clean implementation is correct when it satisfies Program and its public
> evidence, not when it looks like the implementation from which Program was
> assimilated.

That definition prevented two opposite mistakes. We did not bloat Program with
private details merely to satisfy old tests. We also did not excuse actual
failures as creative implementation differences.

### The first public result was 44 out of 53

The definitive source-free package parsed, loaded, exposed the correct public
symbols and passed its own five-file Program check. Its first withheld oracle
run passed 44 of 53 tests.

The nine failures did not represent nine missing paragraphs. They reduced to
four observable implementation errors and one test assertion which depended
on incidental wording:

1. changing a shared type scheduled modules which did not reference it;
2. single-file synchronization treated unrelated project-wide Program
   diagnostics as fatal;
3. assimilation could not state that consumer evidence was incomplete or
   ambiguous;
4. dry-run output omitted newly created files; and
5. one test required the mature implementation's diagnostic sentence.

Program and the compiler guidance were clarified, the wording assertion was
generalized, and Sol/xhigh reconciled the owning root module. The package
reached 52/53, then 53/53 after the dry-run rule was made unambiguous. No
generated JavaScript was hand-edited.

One particularly useful correction concerned shared types. The early
implementation treated a change to `types.md` as a reason to schedule every
module. That is safe but destroys locality. The corrected compiler computes the
reachable type closure for each Program module and schedules only consumers of
the changed definitions. A shared type registry can therefore remain global
without turning every type edit into a whole-project generation.

### The compiler could compile itself—and still be wrong

Passing the oracle was not the end of the experiment. The generated compiler
then had to take over its own accepted state with Codex unavailable.

The first handoff exposed a forwarding defect. The root package publicly
re-exported an operation from one of its owned private files. The generated
validator recognised the root barrel but could not follow that public export
through the private auxiliary tree when validating a consumer. One
implementation-independent regression raised the oracle to 54 tests. A
Program-driven reconciliation changed only `src/index/validate.js`, and the
package passed 54/54.

The next handoff found the decisive defect.

ProgSync accepts an explicit Git base so that a caller can deliberately ignore
private accepted state. Program already stated that this explicit base takes
precedence. The generated compiler selected `NO_CHANGE` correctly—and then
consulted an older private dependency hash anyway, escalating the operation
back into AI generation.

This was not missing Program meaning. It was not an acceptable private choice.
The source was sufficient and the generated code was wrong.

The independent oracle made the failure reproducible as test 55. A later
Sol/xhigh reconciliation changed two conditions in one private file,
`src/index/sync.js`, while preserving the rest of the generated
implementation. Both the mature and independently generated compilers then
passed all 55 tests. The canonical package completed the suite in 72.95
seconds; the generated one completed it in 39.67 seconds. The timing difference
was observed but not investigated as a performance result.

With Codex physically unavailable, all four generated modules then accepted the
committed baseline and, on ordinary invocation, independently returned
`NO_CHANGE`. No tracked file changed and the before-and-after hashes were
identical.

The final package result was then tested in the complete Vibe64 repository, not
only in the isolated ProgSync archive. Vibe64 passed 1,433 server tests, 633
client tests, its production build, all 19 workspace package contracts and
project doctor. The final package dry run contained 48 files.

### Most of the generated compiler survived intact

The preserved Git ledger let us compare the pure-generation commit with the
final verified generated package.

Eighteen of the 23 production files were byte-for-byte unchanged. Only five
private root files changed during the complete oracle and handoff sequence:

| Private file | Reconciliation |
| --- | ---: |
| `src/index/candidate.js` | +1 / −0 lines |
| `src/index/context.js` | +31 / −15 lines |
| `src/index/source.js` | +94 / −37 lines |
| `src/index/sync.js` | +77 / −29 lines |
| `src/index/validate.js` | +140 / −25 lines |
| **Total** | **+343 / −106 lines** |

The public root, CLI, executable and descriptor implementations required no
later source edits. The large private tree was not repeatedly thrown away and
recreated: the system retained the first successful realization and changed
only the parts implicated by new evidence.

This is important because “the generated package eventually passed” could
conceal a complete rewrite. It did not. More than three quarters of the
production files survived untouched, while every later production change was
confined to five private files owned by one Program module.

### The implementation is not disposable output

The explicit-base defect changed our model of the entire system.

If we deleted the repaired generated implementation and asked the AI to rebuild
it, the next version might reintroduce that defect or make a different one.
Putting the two private conditions into Program would be the wrong response:
Program already expressed the observable precedence rule. Encoding one
JavaScript repair in English would leak realization mechanics into the semantic
source.

The verified repair belongs in the managed implementation.

The resulting model has two writable artifacts and a common ancestor:

```text
last accepted pair (P0, I0)
          + current Program P1
          + current managed implementation I1
          + independent verification evidence
          → next accepted pair
```

Program owns observable meaning and intentional public composition. The
managed implementation owns compatible accumulated realization knowledge:
verified repairs, private structure, optimizations, target-specific refinements
and visual tuning. The last accepted pair tells the synchronizer what changed
on either side. Tests and runtime evidence decide whether the result conforms,
but they are not a hidden third source which invents behaviour.

Fresh generation is still essential. It tests whether Program is sufficient
and whether another target could be built without the current realization. It
is not the normal maintenance operation for a mature module.

The most important lesson of the day can therefore be stated quite simply:

> An AI may generate the implementation, but verification makes the
> implementation valuable.

### The experiment produced a better name for the relationship

“Compiler” remains a useful analogy, but it is no longer a complete
description.

ProgSync does compile a missing implementation from Program. It also decompiles
meaningful implementation changes back into Program. More importantly, it
reconciles two overlapping representations without allowing either to erase
knowledge owned by the other.

A conventional compiler transforms one authoritative source into a derived
target. ProgSync is closer to a versioned, verification-driven reconciliation
between semantic source and realized source.

That sounds less magical than “English is the only source code.” It is also
much more likely to work.

## Evaluation

The primary hypothesis was supported for this experiment.

The implementation-shaped corpus was not necessary. Five Program files were
sufficient to generate all four production targets, comprising 23 production
files plus four deterministic projections, without access to the former source
or tests. The resulting package was evolved only through Program/compiler
reconciliation, passed the same 55-case public oracle as the mature
implementation, checked its own five Program files with zero diagnostics, and
converged byte-for-byte with Codex unavailable.

| Measure | Result |
| --- | ---: |
| Program files | 5 |
| Target-bound Program modules | 4 |
| Generated production files in the definitive clean build | 23 |
| Generated deterministic projections | 4 |
| Production files unchanged after pure generation | 18/23 |
| Production files changed during reconciliation | 5/23 |
| Total production reconciliation | +343 / −106 lines |
| Production candidates accepted on first attempt | 4/4 |
| First withheld-oracle result | 44/53 |
| Final public-oracle result, generated implementation | 55/55 |
| Final public-oracle result, mature implementation | 55/55 |
| Program diagnostics | 0 |
| Manual edits to generated JavaScript | 0 |
| No-Codex ordinary synchronizations returning `NO_CHANGE` | 4/4 |
| Tracked byte changes during final convergence | 0 |
| Complete Vibe64 server tests | 1,433 passed |
| Complete Vibe64 client tests | 633 passed |
| Workspace package contracts | 19 passed |

The support is narrower than a claim of deterministic compilation. The
definitive clean package did not pass every eventual test on its first
untouched run. Program and general compiler guidance were refined after
observable failures, and the generated implementation was incrementally
reconciled. That is evidence that the reduced representation can support a
working compiler; it is not evidence that every fresh stochastic generation
will do so without correction.

The secondary disposable-output conjecture was rejected. The explicit-base
error demonstrated a generated implementation defect despite sufficient
Program. The smallest correct response was to preserve the working
implementation and reconcile two private conditions, not to regenerate the
module or leak those conditions into Program.

Several limitations remain:

- only one complete v2 source-free reconstruction has been brought through the
  full public oracle;
- repeated stochastic reproducibility has not been demonstrated;
- the experiment concerns ProgSync and JavaScript, not arbitrary applications
  or target languages;
- no controlled user study has shown that people understand or change the
  five-file Program more successfully than conventional source;
- the generated package's faster test time was not analysed and must not be
  interpreted as a performance improvement;
- candidate isolation is not yet a complete hostile-source security boundary.

### Conjectures produced by the work

**Program may be architectural compression rather than natural-language
translation.** The useful transformation was not replacing JavaScript tokens
with English words. It was deciding which relationships deserve to survive.
The reduction from 33 target-shaped modules to four production modules may be
more important than the prose itself.

**A smaller public graph may improve both human and model reasoning.** A person
can consider seven root operations more easily than dozens of exported
helpers. A model also receives a smaller semantic surface and can choose its
own private decomposition. This may reduce coupling, but it needs comparative
experiments rather than intuition.

**Verification is part of an AI compiler's semantics.** With a deterministic
compiler, tests normally validate the program produced by the compiler. Here,
independent evidence also distinguishes a sufficient Program followed
incorrectly from an insufficient Program. The compiler architecture may need
to treat that classification as a first-class operation.

**Generated code can become more valuable over time.** Every verified repair,
optimization and target refinement increases the information held by the
managed implementation. The strange consequence is that generated code begins
as replaceable experimental output and gradually becomes precious source.

**A three-way synchronizer may be safer than pretending one side always wins.**
The accepted pair gives Program and implementation a common ancestor. That
should allow the system to preserve a CSS refinement on the implementation
side while applying a behavioural change from Program, or to reflect a genuine
implementation-side semantic change back into Program. We have established
the need for this model, not yet its behaviour under deliberate simultaneous
edits.

**A new target is now the cleanest test of portability.** Regenerating more
JavaScript demonstrates stochastic reproducibility. Generating the same Program
module in a second language would test whether Program actually owns meaning
rather than JavaScript assumptions written in English.

## Logical conclusion

The hypothesis is **supported**, with an important qualification.

ProgSync did not need a natural-language twin for every implementation file.
Four production Program modules and one shared type registry were enough to
create a complete, independently structured implementation. After
Program-driven correction, that implementation passed 55 public tests, checked
its own Program graph, took over its accepted state without Codex, and
converged without changing a byte.

That is the strongest evidence so far that Program can describe software at a
useful boundary above conventional source.

It does not establish that AI is a trustworthy drop-in replacement for a
deterministic compiler. The generated compiler violated an explicit rule. The
oracle caught it. A two-condition repair fixed it. Discarding the repaired
implementation would discard verified knowledge without improving Program.

We began the day trying to remove implementation details from the source.

We ended it understanding that implementation details and implementation
knowledge are not the same thing.

Private mechanics do not belong in Program. Verified realization knowledge
does belong in the project. Program and managed implementation must therefore
remain complementary sources, reconciled against the last accepted pair and
judged by independent evidence.

The compiler wrote itself.

It also made a mistake.

Those two facts belong together.

## Supporting activities

The following work was directly related to designing, conducting or evaluating
the experiment:

- auditing production and test consumers to define the reduced Program
  architecture;
- rewriting the self-hosting Program corpus and public behavioural oracle;
- creating source-free Git repositories and bounded candidate workspaces;
- improving deterministic parsing, linking, dependency closure, process
  cancellation and candidate validation where failures prevented the
  experiment from being conducted safely;
- adding implementation-independent regressions for observable defects found
  during generation and handoff;
- running the mature and generated packages against the same public oracle;
- recording model calls, generation durations, rejected assumptions, test
  results, file hashes and no-Codex convergence; and
- documenting the durable-implementation and three-way reconciliation finding.

Routine Vibe64 product work, deployment, marketing, unrelated test maintenance
and future user-interface integration are outside this entry unless separately
assessed and recorded. This technical record does not itself determine R&amp;D
Tax Incentive eligibility or the treatment of any expenditure.
