#!/bin/sh
set -eu

INPUT_TITLE="$(echo "$INPUT_TITLE" | tr -d ' ')"

if [ -z "$INPUT_TAG" ]; then
  INPUT_TAG="$(date +%Y%m%d%H%M%S)"
fi

{ RESULT=$(gh release view "$INPUT_TAG" 2>&1); } || :

if [[ "$RESULT" != "release not found" ]]; then
  echo "Release does already exists:"
  echo $RESULT
  echo "Performing delete..."
  gh release delete "$INPUT_TAG" --cleanup-tag --yes
  sleep 1
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
