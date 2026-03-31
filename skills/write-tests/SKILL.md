---
name: write-tests
description: >
  Write, review, or improve tests for any function, class, or module. Use
  whenever the user asks to write tests, add coverage, review existing tests,
  or improve test quality. Enforces isolation, consolidation, error path
  coverage, and behavior-driven assertions.
---

# Write Tests

Before writing a single test, read the target function's docstring and its call
sites. Tests must reflect documented intent — not the current implementation.
If the expected behavior is ambiguous or undocumented, ask before writing anything.

---

## Isolation

Each test must be able to run and pass on its own. Never seed state by calling
another non-trivial method — if that method has a bug, your test breaks for the
wrong reason.

Seed state directly: insert records via a base/helper method, construct objects
manually, or set up fixtures explicitly. The only exception is integration-level
tests, where exercising the full method chain is the point.

## Consolidation

Tests that share identical setup belong in one test, not separate tests. If the
only difference between two tests is the assertion, merge them.

## Error Paths

Every test class should cover the failure cases the code is designed to handle —
not just the happy path. For each expected exception or error condition described
in the docstring or source, write at least one test.

## Test Expected Behavior, Not Implementation

- Base assertions on the docstring and how the function is used, not on what the
  code currently does
- Never hard-code expected values by running the code and copying the output
- If the implementation and the docstring conflict, flag it — don't silently test
  the wrong thing

---

## Checklist

- [ ] Each test seeds its own state directly
- [ ] Tests with identical setup are consolidated
- [ ] At least one error/edge case test per class
- [ ] Assertions reflect documented behavior, not inferred behavior
- [ ] Any behavioral ambiguity was clarified before writing
