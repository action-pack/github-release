#!/bin/sh

INPUT_TITLE=${INPUT_TITLE//[[:blank:]]/}

if [ -z "${INPUT_TAG}" ]; then
  INPUT_TAG="$(date +%Y%m%d%H%M%S)"
fi

if [ -z "${INPUT_BODY}" ]; then
  INPUT_MSG="${INPUT_TITLE}"
else
  INPUT_MSG="${INPUT_TITLE} ${INPUT_BODY}"
fi

hub release create -m "${INPUT_MSG}" "${INPUT_TAG}" 
