#!/usr/bin/env bash

set -euo pipefail

source shared.bash

if [ -z ${SHA:-} ]
then
  SHA="HEAD"
fi
USER="$(git config user.email)"

MESSAGE="Approved-By: ${USER}"
if git notes show $SHA &>/dev/null | grep "${MESSAGE}"
then
  echo "You have already approved this commit"
else
  git notes append $SHA --message "Approved-By: ${USER}"
fi
