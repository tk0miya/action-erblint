#!/usr/bin/env bash

set -euo pipefail

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

TEMP_PATH="$(mktemp -d)"
PATH="${TEMP_PATH}:$PATH"

echo '::group::🐶 Installing reviewdog ... https://github.com/reviewdog/reviewdog'
curl -sfL https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh | sh -s -- -b "${TEMP_PATH}" 2>&1
echo '::endgroup::'

if [ "${INPUT_USE_BUNDLER}" = "true" ]; then
  echo '::group:: Installing erb_lint via bundler'
  bundle install
  echo '::endgroup::'
fi

if [ "${INPUT_USE_BUNDLER}" = "false" ]; then
  BUNDLE_EXEC=""
else
  BUNDLE_EXEC="bundle exec "
fi

if [ -z "${INPUT_CONFIG_FILE}" ]; then
  CONFIG_FILE="--config=.erb_lint.yml"
else
  CONFIG_FILE="--config=${INPUT_CONFIG_FILE}"
fi

if [ -z "${INPUT_TOOL_NAME}" ]; then
  TOOL_NAME="erb_lint"
else
  TOOL_NAME="${INPUT_TOOL_NAME}"
fi

echo '::group:: Running erb_lint with reviewdog 🐶 ...'
${BUNDLE_EXEC}erb_lint \
  --lint-all \
  --format compact \
  --fail-level F \
  "${CONFIG_FILE}" \
  | reviewdog \
      -efm="%f:%l:%c: %m" \
      -reporter="${INPUT_REPORTER}" \
      -filter-mode="${INPUT_FILTER_MODE}" \
      -level="${INPUT_LEVEL}" \
      -name="${TOOL_NAME}" \
      -fail-level="${INPUT_FAIL_LEVEL}" \
      -fail-on-error="${INPUT_FAIL_ON_ERROR}"
echo '::endgroup::'
