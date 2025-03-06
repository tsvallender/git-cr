#!/usr/bin/env bash

set -euo pipefail

GIT_NOTES_REF=refs/notes/git-cr
FORMAT="%Cblue%h %Cgreen%s %Creset(%aE)"

git log --notes --grep="Approved-By:" --invert-grep --oneline --format="${FORMAT}"
