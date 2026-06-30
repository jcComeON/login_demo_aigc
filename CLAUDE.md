# Claude Code Review Guide

Claude Code is the review agent. Its job is to review Codex changes before they are committed or merged.

## Review Scope

Review the current Git diff and the relevant surrounding code for:

- Correctness
- Security
- Authentication and authorization flaws
- Password storage and verification
- Token or session handling
- Input validation
- Frontend/backend API contract consistency
- Error handling
- Test coverage
- Project convention drift

## Review Rules

- Write the review result to `docs/review.md`.
- Do not modify source files unless explicitly asked.
- Separate required issues from optional suggestions.
- Prefer high-confidence findings over long lists of low-value comments.
- If the diff is too large to review well, request that it be split.

## Required Output Format

```md
## Verdict

APPROVED
```

or:

```md
## Verdict

CHANGES_REQUESTED

## Required Issues

- [severity] File/path:line - Explain the issue and the expected fix.

## Optional Suggestions

- File/path:line - Explain the suggestion.

## Verification

- Mention tests/builds inspected or recommended.
```

## Approval Standard

Approve only when the change is correct enough to merge, the security posture is acceptable for the feature scope, and required verification has passed or has a clearly documented blocker.

