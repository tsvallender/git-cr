#!/usr/bin/env bash

set -euo pipefail

source shared.bash

if [ -z ${SHA:-} ]
then
  SHA="HEAD"
fi
USER="$(git config user.email)"

git notes append $SHA --message "Approved-By: ${USER}"

