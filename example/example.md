## Usage

Usage information can be found by executing `flutter_analyze_reporter --help`

```
A parser to create reports from `flutter analyze` output.

-h, --[no-]help                  Print this usage information.
-r, --reporter                   Set output report type.

          [checkstyle]           Generate Checkstyle report.
          [console] (default)    Print output to console.
          [github]               Print out GitHub workflow messages.
          [gitlab]               Generate GitLab code quality JSON report.

-o, --output                     Output file name.
                                 (defaults to "report")
```
Usage example `flutter_analyze_reporter --output report.json --reporter gitlab`

# GitLab CI

Parse `flutter analyze` output for [GitLab Code Quality Widget](https://docs.gitlab.com/ee/ci/testing/code_quality.html).

`.gitlab-ci.yml` file:

```
stages:
  - test
code_quality:
  stage: test
  before_script:
    - export PATH="$PATH":"$HOME/.pub-cache/bin"
  script:
    - dart pub global activate flutter_analyze_reporter
    - flutter_analyze_reporter --output report.json --reporter gitlab
  artifacts: 
    reports:
      codequality: report.json
```

# GitHub CI

Parse `flutter analyze` output for [GitHub Workflow messages](https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions).

`.github/workflows/test.yml` file:

```
name: Test
on:
  push:
    branches:
      - main
jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Analyze
        run: |
          dart pub global activate flutter_analyze_reporter
          flutter_analyze_reporter --reporter github
        shell: bash
```
