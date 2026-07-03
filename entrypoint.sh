#!/usr/bin/env bash
set -Eeuo pipefail

log() {
  printf '%s\n' "$*"
}

error() {
  printf 'ERROR: %s\n' "$*" >&2
}

setup_auth() {
  local token="${GITHUB_TOKEN:-${INPUT_TOKEN:-}}"

  if [ -z "$token" ]; then
    error "The token input is not set."
    exit 1
  fi

  # Mask it in logs as a safety net.
  echo "::add-mask::$token"

  # gh checks GH_TOKEN before GITHUB_TOKEN.
  export GH_TOKEN="$token"
  export GITHUB_TOKEN="$token"
}

release_exists() {
  gh release view "$1" >/dev/null 2>&1
}

wait_for_tag_removal() {
  local tag="$1"
  local timeout="${INPUT_DELETE_TIMEOUT:-120}"
  local elapsed=0
  local local_exists
  local remote_exists

  while :; do
    git fetch --tags --prune-tags

    local_exists=0
    remote_exists=0

    if git tag -l | grep -Fxq "$tag"; then
      local_exists=1
    fi

    if git ls-remote --exit-code --tags origin "refs/tags/$tag" >/dev/null 2>&1; then
      remote_exists=1
    fi

    if [ "$local_exists" -eq 0 ] && [ "$remote_exists" -eq 0 ]; then
      break
    fi

    if [ "$elapsed" -ge "$timeout" ]; then
      echo "ERROR: Timed out waiting for tag $tag to be deleted." >&2
      echo "Local tag exists: $local_exists" >&2
      echo "Remote tag exists: $remote_exists" >&2
      exit 1
    fi

    echo "Waiting for tag $tag to be deleted..."
    sleep 3
    elapsed=$((elapsed + 3))
  done
}

delete_release() {
  local tag="$1"
  local timeout="${INPUT_DELETE_TIMEOUT:-120}"
  local elapsed=0

  log "Release $tag already exists, deleting it first..."
  gh release delete "$tag" --cleanup-tag --yes

  # Workaround for https://github.com/cli/cli/issues/8458
  wait_for_tag_removal "$tag"
}

create_release() {
  local tag="$1"
  local title="$2"
  local body="${INPUT_BODY:-}"
  local commit="${INPUT_COMMIT:-}"

  local args=()

  if [ -n "$commit" ]; then
    args+=(--target "$commit")
  fi

  args+=(--title "$title")

  if [ -n "$body" ]; then
    args+=(--notes "$body")
  else
    args+=(--generate-notes)
  fi

  latest="${INPUT_LATEST:-}"

  if [ -z "$latest" ] || [ "${latest,,}" = "true" ]; then
    args+=(--latest)
  fi

  log "Creating release $tag..."
  gh release create "$tag" "${args[@]}"
}

setup_auth

tag="${INPUT_TAG:-}"
title="${INPUT_TITLE:-}"

if [ -z "$title" ]; then
  title="Release"
fi

if [ -z "$tag" ]; then
  tag="$(date +%Y%m%d%H%M%S)"
fi

if release_exists "$tag"; then
  delete_release "$tag"
fi

create_release "$tag" "$title"
