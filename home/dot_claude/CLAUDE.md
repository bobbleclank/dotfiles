# Coding preferences

## General style
- No comments by default. Only add one when the WHY is non-obvious.
- No function interface comments unless asked.
- No defensive programming — don't guard against scenarios that can't happen.
- No premature abstractions — don't design for hypothetical future requirements.
- Simple, consistent rules are preferred over case-by-case judgement calls.
- Prefer return by value over out parameters.

## Naming
- Don't use refactoring as a way to avoid difficult naming decisions.
- When a variable is only used in a condition but the function has side effects, store it first with a meaningful name rather than inlining the call.

## [[nodiscard]]
- Conservative use: apply when ignoring the return value would be a bug.
- Currently scoped to functions returning error codes, expected types, or action results the caller must act on.
- Consistent application matters more than covering every possible case.

## Commit messages
- Short, active titles only. No body.
- Active voice: describe what the code does, not what was wrong.
- Happy to receive suggested improvements to commit titles.

## Ordering rules (async/callback)
- State changes before callbacks.
- Upper-layer calls before handler callbacks.
- Async socket calls after all state changes and callbacks.

## Build
- Run `bd` from project root to build.

## Review style
- When reviewing commits, check for correctness, consistency, and ordering.
- Flag missing guards, and callback ordering issues.
- Note behavioral changes even if arguably better.
- When asked to review a specific commit, user will rebase to that commit first.
