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

## How it works

We store code review in [git notes](https://git-scm.com/docs/git-notes), an underused git feature allowing
you to add metadata to commits without changing the commit itself. We store these under the ref `git-cr`,
so they don’t get in the way of any other uses git notes is being put to.

## Setup

By default git notes aren’t shared, so a small amount of config is necessary to make that the case. To
make git always push and fetch notes, add this to your project’s git config:

```
[remote "origin"]
    push = +refs/notes/*:refs/notes/*
    fetch = refs/notes/*:refs/notes/*
```
(replace `*` with `git-cr` if you want this to _only_ apply to git-cr notes rather than all of them.

And for quality of life, to have notes changes in your reflog, add this to your git config:
```
[core]
    logAllRefUpdates = always
```

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
