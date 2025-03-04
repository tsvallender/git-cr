#!/usr/bin/env bash

set -euo pipefail

POS_ARGS=()
while [[ $# -gt 0 ]]
do
  case $1 in
    -f|--file)
      FILENAME="$2"
      shift ; shift
      ;;
    -l|--line)
      LINE_NO="$2"
      shift ; shift
      ;;
    -m|--message)
      MESSAGE="$2"
      shift ; shift
      ;;
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

if [ -z ${MESSAGE:-} ]
then
  # TODO: Open an editor for the message if blank, like git-commit
  echo "Please supply a message"
  exit 1
fi

if [ -n ${LINE_NO:-} ] && [ -z ${FILENAME:-} ]
then
  echo "If supplying a line number, you must supply a filename."
  exit 1
fi

SHA=${POS_ARGS[0]:-"HEAD"}
AUTHOR="$(git config user.email)"

COMMENT=$( jq \
  --null-input \
  --compact-output \
  --arg author $AUTHOR \
  --arg message $MESSAGE \
  --arg filename "${FILENAME:-}" \
  --arg line "${LINE_NO:-}" \
  '{author: $author, message: $message} +
  (if $filename != "" then {file: $filename} else {} end) +
  (if $line != "" then {line: $line} else {} end)'
)

git notes append $SHA --message "Comment: ${COMMENT}"
