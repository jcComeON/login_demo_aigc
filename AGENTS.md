# Codex Development Guide

This project uses a frontend/backend separated architecture.

- Backend: Java Spring Boot in `src/`
- Frontend: React in `frontend/`
- Shared agent documents: `docs/`
- Automation scripts: `scripts/`

## Codex Role

Codex is the implementation agent. Its job is to write code, update tests, run verification, and address required review feedback from Claude Code.

## Workflow

1. Read `docs/requirements.md`.
2. If `docs/review.md` exists, address the required issues first.
3. Make the smallest coherent code change for the requested login feature.
4. Add or update tests for behavior that changed.
5. Run relevant verification commands.
6. Leave the repository in a reviewable state.

## Verification Commands

Backend:

```powershell
.\gradlew.bat test
```

Frontend, when `frontend/package.json` exists:

```powershell
npm --prefix frontend install
npm --prefix frontend test
npm --prefix frontend run build
```

## Development Rules

- Keep authentication logic explicit and easy to review.
- Do not commit secrets, tokens, passwords, or private keys.
- Validate request data at the backend boundary.
- Never store plaintext passwords.
- Prefer project conventions over introducing new dependencies.
- Do not mark work complete unless verification has been run or the reason it could not run is documented.
- Do not overwrite files changed by another agent without first reading the current contents.

