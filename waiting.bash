#!/usr/bin/env bash

set -euo pipefail

FORMAT="%Cblue%h %Cgreen%s %Creset(%aE)"

git log --notes --grep="Approved-By:" --invert-grep --oneline --format="${FORMAT}"
