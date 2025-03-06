#!/usr/bin/env bash

set -euo pipefail

GIT_NOTES_REF=refs/notes/git-cr

POS_ARGS=()
while [[ $# -gt 0 ]]
do
  case $1 in
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
    *)
      POS_ARGS+=("$1")
      shift
      ;;
  esac
done

SHA=${POS_ARGS[0]:-"HEAD"}
USER="$(git config user.email)"

MESSAGE="Approved-By: ${USER}"
if git notes show $SHA &>/dev/null | grep "${MESSAGE}"
then
  echo "You have already approved this commit"
else
  git notes append $SHA --message "Approved-By: ${USER}"
fi
