#!/usr/bin/env bash
set -Eeuo pipefail

[ -z "$INPUT_TITLE" ] && INPUT_TITLE="Name"
INPUT_TITLE="$(echo "$INPUT_TITLE" | tr -d ' ')"
[ -z "$INPUT_TAG" ] && INPUT_TAG="$(date +%Y%m%d%H%M%S)"

{ gh release view "$INPUT_TAG" >/dev/null 2>&1; rc=$?; } || :

if (( rc == 0 )); then
  echo "Release $INPUT_TAG does already exists, will be overwritten..."
  gh release delete "$INPUT_TAG" --cleanup-tag --yes
  sleep 1
else
  echo $rc
fi

if [ -z "${INPUT_COMMIT}" ]; then
  if [ -z "${INPUT_BODY}" ]; then
    gh release create -t "$INPUT_TITLE" "$INPUT_TAG" --generate-notes
  else
    gh release create -t "$INPUT_TITLE" -n "$INPUT_BODY" "$INPUT_TAG" 
  fi
else
  if [ -z "$INPUT_BODY" ]; then
    gh release create --target "$INPUT_COMMIT" -t "$INPUT_TITLE" "$INPUT_TAG" --generate-notes
  else
    gh release create --target "$INPUT_COMMIT" -t "$INPUT_TITLE" -n "$INPUT_BODY" "$INPUT_TAG" 
  fi 
fi
