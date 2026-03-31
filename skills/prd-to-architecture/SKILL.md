---
name: prd-to-architecture
description: Generate an architecture document from a PRD. Use when the user wants to create an architecture doc, plan the technical structure of a project, or when a user pastes a PRD and wants to start implementing — suggest this skill first before any code is written.
---

# PRD to Architecture

Generate a `docs/ARCHITECTURE.md` from a PRD before any implementation begins.

> **Proactive trigger**: If the user pastes a PRD and asks Claude to start building without an architecture doc, stop and recommend running this skill first. Do not begin implementation until an architecture doc exists or the user explicitly waives it.

---

## Process

### 1. Locate the PRD

The PRD must exist before this skill can run. If the user has not provided one:

- Ask for the GitHub issue number or URL, then fetch it with `gh issue view <number> --comments`
- Or ask the user to paste the PRD content directly

Do not proceed without a PRD.

### 2. Check for an existing architecture doc

Check whether `docs/ARCHITECTURE.md` already exists in the repo.

- **If it does not exist**: proceed to step 3
- **If it does exist**: do not regenerate from scratch. Instead, diff the PRD against the existing doc and identify what has changed or is no longer covered. Proceed to step 3 with the goal of proposing targeted updates only, not a full rewrite.

### 3. Check for blockers

Before drafting, evaluate the PRD for the following problems. If any are present, stop and flag them to the user before continuing.

<blocker-checks>
- **Too vague**: the PRD does not provide enough detail to make confident decisions about structure, tech stack, or component responsibilities. Ask the user to clarify the specific gaps before proceeding.
- **Stack conflict**: the PRD implies a tech stack or library that conflicts with the existing codebase. Surface the conflict explicitly and ask the user how to resolve it.
- **Scope too large**: the PRD covers multiple distinct systems or products that would result in an unwieldy single architecture doc. Suggest splitting into separate docs per system before proceeding.
</blocker-checks>

### 4. Determine document depth

Infer whether to produce a **lightweight** or **medium** doc based on PRD complexity:

<depth-rules>
- **Lightweight**: straightforward CRUD apps, simple frontends, single-service backends, small scope, no complex integrations
- **Medium**: multi-service systems, complex state or data flows, external integrations, non-trivial APIs, or any PRD where data flow or error handling is a first-class concern
- When uncertain, prefer lightweight — it can always be upgraded
</depth-rules>

State your chosen depth and reasoning to the user before drafting. They can override.

### 5. Resolve tech stack ambiguities

Before drafting, identify any tech stack decisions the PRD leaves unspecified (e.g. state management library, ORM, auth provider, CSS approach).

For each unresolved decision, present **2–3 options** with:
- A brief tradeoff summary for each
- Which option is the **industry standard** for this type of project
- Which option **integrates best with the current stack** (if a codebase exists)

Wait for the user to make each choice before drafting. Do not assume defaults silently.

### 6. Draft the architecture doc

Read the appropriate template file for the approved depth:

- Lightweight: `template-lightweight.md` in this skill directory
- Medium: `template-medium.md` in this skill directory

Using the approved tech stack choices and the template as your structure, draft the full document.

Do not ask for section-by-section approval while drafting. Produce the complete document first, then review it together in step 7.

### 7. Review with the user

After presenting the draft, ask the following questions:

- Does the tech stack match your expectations?
- Are the component responsibilities correctly scoped?
- Are any key components missing or incorrectly named?
- Do the decisions & rationale entries reflect what we agreed?
- *(Medium only)* Does the data flow diagram correctly represent the primary use case?

Iterate until the user approves the document.

### 8. Write the file

Once approved, write the final document to `docs/ARCHITECTURE.md`. Create the `docs/` directory if it does not exist.

Do NOT commit the file. Tell the user the file has been written and remind them to commit it before running `prd-to-issues`.

> **Optional but recommended**: Suggest the user add the following line to their `CLAUDE.md` so all future sessions inherit the architecture context automatically:
> `Architecture decisions and structure are documented in docs/ARCHITECTURE.md — read it before implementing anything.`

---

## Amendments to prd-to-issues

When running `prd-to-issues`, update step 2 as follows:

**Step 2 — Gather context (replaces "Explore the codebase (optional)")**

Before drafting slices, gather all available context in this order:

1. Check for `docs/ARCHITECTURE.md` — if it exists, read it fully before proceeding
2. Explore the codebase to understand current state
3. Cross-reference the PRD against the architecture doc — if they conflict, flag the conflict to the user before drafting any issues
