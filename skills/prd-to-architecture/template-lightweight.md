# Architecture (Lightweight Template)

> This is a reference template. Use it as the structure for `docs/ARCHITECTURE.md` when the PRD complexity calls for a lightweight doc. Fill in each section based on the PRD and approved tech stack decisions. Remove this notice before writing the final file.

---

# Architecture

## Overview

One paragraph describing what this project does and its primary technical goals.

## Tech Stack

| Layer | Choice | Reason |
|-------|--------|--------|
| Language | ... | ... |
| Framework | ... | ... |
| Database | ... | ... |
| Styling | ... | ... |

Add or remove rows as appropriate for the project type.

## File & Folder Structure

```
project-root/
├── src/
│   ├── components/    # Reusable UI components
│   ├── pages/         # Top-level route pages
│   ├── services/      # External API and data access
│   └── utils/         # Shared helpers and constants
└── docs/
    └── ARCHITECTURE.md
```

Describe the purpose of each top-level directory in 1–2 sentences. Adjust the tree to reflect the actual planned structure — do not leave placeholder paths that don't apply.

## Key Components & Responsibilities

For each major component or module, describe:

- What it owns and does
- What it explicitly does NOT own (boundaries matter as much as responsibilities)

### ComponentName

...

### ModuleName

...

## Decisions & Rationale

One entry per resolved tech stack decision or meaningful architectural choice. Do not document decisions that were obvious or had no real alternatives.

### Decision: <short title>

**Chosen**: X
**Alternatives considered**: Y, Z
**Reason**: Why X was chosen over the alternatives, including any project-specific constraints that influenced the decision.

### Decision: <short title>

...
