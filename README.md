# GitHub Action: Run erb_lint with reviewdog 🐶

This action runs [erb_lint](https://github.com/Shopify/erb_lint) with
[reviewdog](https://github.com/reviewdog/reviewdog) on pull requests to improve
code review experience.

## Inputs

### `github_token`

`GITHUB_TOKEN`. Default is `${{ github.token }}`.

### `level`

Optional. Report level for reviewdog [`info`, `warning`, `error`].
The default is `error`.

### `fail_level`

Optional. If set to `none`, always use exit code 0 for reviewdog. Otherwise, exit code 1 for reviewdog if it finds at least 1 issue with severity greater than or equal to the given level.
Possible values: [`none`, `any`, `info`, `warning`, `error`]
Default is `none`.

### `fail_on_error`

Deprecated, use `fail_level` instead.
Optional. Exit code 1 for reviewdog if it finds errors [`true`, `false`].
The default is `false`.

### `reporter`

Optional. Reporter of reviewdog command [`github-pr-check`, `github-check`, `github-pr-review`].
The default is `github-pr-review`.

### `filter_mode`

Optional. Filtering mode for the reviewdog command [`added`, `diff_context`, `file`, `nofilter`].
Default is `added`.

### `use_bundler`

Optional. Run erb_lint with bundle exec. Default: `false`.

### `tool_name`

Optional. Tool name to be displayed in the reviewdog comment.
Useful when you have multiple linters running in a single workflow.
Default: `erb_lint`.

## Example usage

```yml
name: reviewdog
on: [pull_request]
jobs:
  erb_lint:
    name: runner / erb_lint
    runs-on: ubuntu-latest
    steps:
      - name: Check out code
        uses: actions/checkout@v1
      - uses: ruby/setup-ruby@v1
        with:
          ruby-version: 3.0.0
      - name: erb_lint
        uses: reviewdog/action-erblint@v1
```

## License

[MIT](https://choosealicense.com/licenses/mit)
