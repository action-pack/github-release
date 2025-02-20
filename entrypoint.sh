#!/usr/bin/env bash
set -Eeuo pipefail

if [ -z "${GITHUB_TOKEN:-}" ]; then
  if [ -n "$INPUT_TOKEN" ]; then
    export GITHUB_TOKEN="$INPUT_TOKEN"
  else
    echo "The token input is not set!" && exit 1
  fi
fi

[ -z "$INPUT_TITLE" ] && INPUT_TITLE="Name"
INPUT_TITLE="$(echo "$INPUT_TITLE" | tr -d ' ')"
[ -z "$INPUT_TAG" ] && INPUT_TAG="$(date +%Y%m%d%H%M%S)"

{ gh release view "$INPUT_TAG" >/dev/null 2>&1; rc=$?; } || :

if (( rc == 0 )); then
  echo "Release $INPUT_TAG does already exists, it will be deleted first..."
  gh release delete "$INPUT_TAG" --cleanup-tag --yes

  # Workaround for https://github.com/cli/cli/issues/8458
  while git fetch --tags --prune-tags; git tag -l | grep -x "$INPUT_TAG"; do
    echo "Waiting for release $INPUT_TAG to be deleted.."
    sleep 3
  done
fi

if [ -z "$INPUT_COMMIT" ]; then
  if [ -z "$INPUT_BODY" ]; then
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
