#!/bin/sh -e
export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

TEMP_PATH="$(mktemp -d)"
PATH="${TEMP_PATH}:$PATH"

echo '::group::🐶 Installing reviewdog ... https://github.com/reviewdog/reviewdog'
curl -sfL https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh | sh -s -- -b "${TEMP_PATH}" 2>&1
echo '::endgroup::'

if [ "${INPUT_USE_BUNDLER}" = "true" ]; then
  echo '::group:: Installing erb-lint via bundler'
  bundle install
  echo '::endgroup::'
fi

if [ "${INPUT_USE_BUNDLER}" = "false" ]; then
  BUNDLE_EXEC=""
else
  BUNDLE_EXEC="bundle exec "
fi

echo '::group:: Running erb-lint with reviewdog 🐶 ...'
${BUNDLE_EXEC}erblint --lint-all --format compact \
  | reviewdog \
      -efm="%f:%l:%c: %m" \
      -reporter="${INPUT_REPORTER}" \
      -filter-mode="${INPUT_FILTER_MODE}" \
      -level="${INPUT_LEVEL}" \
      -fail-on-error="${INPUT_FAIL_ON_ERROR}"
echo '::endgroup::'
