# git-cr

git-cr is a code review tool with the following goals:

- Support a PR-free workflow: in small teams with high levels of trust trunk-based development can
  work well, so code can be pushed to trunk _before_ review, and reviews can be per-commit on the
  trunk branch.
- Reviews should live in the repository: reviews are as much a part of the codebase’s history as the
  commits and should live with them, not in an external system.
- Tooling should meet the developer where they are: I want to be able to review code from my terminal,
  and in the editor of my choosing, not in a web UI.

## Pre-pre-pre alpha software

`git-cr` is currently a toy experimental project that does very little and should be treated
with extreme caution.

## Requirements

- git
- jq
- mktemp

## Usage

- `git cr waiting`: show commits awaiting approval
- `git cr approve [SHA]`: mark a commit as approved (`HEAD` if `SHA` is not supplied)
- `git cr comment [SHA] -m "message"`: add a comment (`HEAD` if `SHA` is not supplied), optional arguments:
  - `--file` file the comment applies to
  - `--line` line number the comment applies to (`--file` must also be present)
  - Note this command is obviously a little clunky—the idea is to wrap this with editor tooling to make things nicer
- `git cr show [SHA]`: shows the status and all comments on commit (`HEAD` if `SHA` is not supplied)

## Future ideas:

- `review` command to easily annotate a diff
- Add datetime to comments
- Comment types (e.g. "must-change", "suggestion")
- Ability to reply to specific comments
