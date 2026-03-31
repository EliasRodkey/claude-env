---
name: implement-issue
description: Implement a GitHub issue end-to-end — reading the issue, parent PRD, and architecture doc before writing code, then running tests, closing the issue, and opening a PR. Use when the user says "work on issue #N", "implement issue #N", or "start the next issue". Also use when the user points at a specific GitHub issue and asks Claude to work on it.
---

# Implement Issue

Implement a GitHub issue end-to-end, grounded in the parent PRD and architecture doc.

## Process

### 1. Identify the issue

If you are not already in the correct github repository:

```bash
gh --repo EliasRodkey/<repository-name>
```

If the user specified an issue number, proceed to step 2.

If the user said **"start the next issue"**, find the next unblocked issue:

```bash
gh issue list --state open --json number,title,body
```

Parse the "Blocked by" field of each issue. An issue is unblocked if every issue listed under "Blocked by" is closed. Verify blocker status with:

```bash
gh issue view <blocker-number> --json state
```

Pick the lowest-numbered unblocked issue. Confirm with the user before proceeding:

> "The next unblocked issue is #N: <title>. Shall I start on this one?"

---

### 2. Fetch the issue

```bash
gh issue view <number> --comments
```

Note:
- The **acceptance criteria** — these are your definition of done
- The **parent PRD** issue number (listed under "Parent PRD")
- The **"Blocked by"** field — confirm all blockers are closed before continuing

---

### 3. Read the parent PRD

```bash
gh issue view <prd-number> --comments
```

Understand the broader feature context, user stories, and any constraints that inform implementation decisions for this slice.

---

### 4. Read the architecture doc

```bash
cat docs/architecture.md
```

Understand the existing patterns, layer boundaries, naming conventions, and any relevant design decisions before touching the codebase.

---

### 5. Explore the codebase

Identify the files and modules most relevant to this issue. Focus on:

- Existing patterns that this issue should follow
- Entry points, interfaces, or abstractions that will be extended
- Test structure for the areas being changed

Do not explore beyond what is relevant to the issue.

---

### 6. Ask clarifying questions (if needed)

If anything is ambiguous after reading the issue, PRD, architecture doc, and codebase — ask before writing code. Be specific: quote the ambiguous part and explain what you need clarified.

If everything is clear, skip this step and proceed directly to implementation.

---

### 7. Create a branch

Create a branch before writing any code:

```bash
git checkout -b feature/issue-<number>-<short-title>
```

Where `<short-title>` is a lowercase, hyphenated summary of the issue title (3–5 words max).

Example: `feature/issue-42-add-summary-upload`

---

### 8. Implement

Write code that satisfies the acceptance criteria from the issue. Follow the patterns established in the architecture doc and existing codebase.

**On tests**: Write tests alongside the implementation. Follow the `write-tests` skill guidelines for unit tests. Note: integration test conventions are not yet established for this project — if the issue requires integration-level coverage, flag this to the user and write what you can under the existing unit test framework.

---

### 9. Run tests

Run the full test suite:

```bash
pytest
```

Fix any failures before proceeding. Do not close the issue or open a PR with a failing test suite.

---

### 10. Summarise the issue

Comment a summary of the work done:

```bash
gh issue <number> --comment "<summary>"
```

The summary should cover:
- What was implemented
- Any decisions made that weren't specified in the issue
- Anything left out of scope with a reason

---

### 11. Open a PR

```bash
gh pr create \
  --title "<issue title>" \
  --body "Closes #<number>" \
  --head feature/issue-<number>-<short-title>
```

The PR description should reference the issue so GitHub links them automatically. Do not merge the PR — leave that for the user.
