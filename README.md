# git-cr

git-cr is a code review tool with the following goals:

- Support a PR-free workflow: in small teams with high levels of trust trunk-based development can
  work well, so code can be pushed to trunk _before_ review, and reviews can be per-permit on the
  trunk branch.
- Reviews should live in the repository: reviews are as much a part of the codebase’s history as the
  commits and should live with them, not in an external system.
- Tooling should meet the developer where they are: I want to be able to review code from my terminal,
  and in the editor of my choosing, not in a web UI.

