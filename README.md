# GitHub Action: Run erb-lint with reviewdog 🐶

This action runs [erb-lint](https://github.com/Shopify/erb-lint) with
[reviewdog](https://github.com/reviewdog/reviewdog) on pull requests to improve
code review experience.

## Inputs

### `github_token`

`GITHUB_TOKEN`. Default is `${{ github.token }}`.

### `level`

Optional. Report level for reviewdog [`info`, `warning`, `error`].
The default is `error`.

### `reporter`

Optional. Reporter of reviewdog command [`github-pr-check`, `github-check`, `github-pr-review`].
The default is `github-pr-review`.

### `filter_mode`

Optional. Filtering mode for the reviewdog command [`added`, `diff_context`, `file`, `nofilter`].
Default is `added`.

### `skip_install`

Optional. Do not install Rubocop or its extensions. Default: `false`.

### `use_bundler`

Optional. Run Rubocop with bundle exec. Default: `false`.

## Example usage

```yml
name: reviewdog
on: [pull_request]
jobs:
  erb-lint:
    name: runner / erb-lint
    runs-on: ubuntu-latest
    steps:
      - name: Check out code
        uses: actions/checkout@v1
      - uses: ruby/setup-ruby@v1
        with:
          ruby-version: 3.0.0
      - name: erb-lint
        uses: reviewdog/action-erblint@v1
```

## License

[MIT](https://choosealicense.com/licenses/mit)
