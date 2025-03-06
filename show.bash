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

if ! git notes show $SHA &>/dev/null
then
  echo "Commit not yet approved."
  echo "There are no comments on this commit."
  exit 0
fi

COMMENT_PREFIX="Comment: "
APPROVED_PREFIX="Approved-By: "

APPROVED_NOTICE=$(git notes show ${SHA} | grep "^${APPROVED_PREFIX}") || true
COMMENTS=( $(git notes show ${SHA} | grep "^${COMMENT_PREFIX}" | sed "s/^${COMMENT_PREFIX}//") ) || true

if [[ -n APPROVED_NOTICE ]]
then
  echo ${APPROVED_NOTICE}
  echo
else
  echo "Commit not yet approved."
  echo
fi

for COMMENT in "${COMMENTS[@]}"
do
  FILENAME=$(echo "${COMMENT}" | jq --raw-output .file)
  LINE_NO=$(echo "${COMMENT}" | jq --raw-output .line)
  if [ ${FILENAME} != "null" ] && [ ${LINE_NO} = "null" ]
  then
    REFSTRING="\n(\(.file))"
  elif [ ${FILENAME} != "null" ] && [ ${LINE_NO} != "null" ]
  then
    REFSTRING="\n(\(.file):\(.line))"
  else
    REFSTRING=""
  fi
  FORMATSTRING="\"\(.author):\n\(.message)${REFSTRING}\""
  echo "${COMMENT}" | jq --raw-output "${FORMATSTRING}"
  echo
done
