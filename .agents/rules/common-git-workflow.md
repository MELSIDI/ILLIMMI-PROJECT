# Git Workflow

## Commit Message Format
```
<type>: <description>

<optional body>
```

Types: feat, fix, refactor, docs, test, chore, perf, ci

Note: ECC-managed installs set `"includeCoAuthoredBy": false` in `~/.claude/settings.json`, so commits carry no `Co-Authored-By` trailer by default. To keep Claude attribution, set `"includeCoAuthoredBy": true` or configure `attribution`; ECC never overwrites an explicit choice.

## Pull Request Workflow

When creating PRs:
1. Analyze full commit history (not just latest commit)
2. Use `git diff [base-branch]...HEAD` to see all changes
3. Draft comprehensive PR summary
4. Include test plan with TODOs
5. Push with `-u` flag if new branch

## Push Status Notification Rule (MANDATORY)

Whenever changes or modifications are made to the codebase:
- **If pushed to remote**: ALWAYS explicitly state in the final response that changes were pushed, including the target branch (e.g. `dsl_dev`), commit hash, and summary.
- **If NOT pushed to remote**: ALWAYS explicitly state in the final response that changes remain local only (not pushed to remote), noting whether they are uncommitted in the working tree or committed locally only.

> For the full development process (planning, TDD, code review) before git operations,
> see [development-workflow.md](common-development-workflow.md).
