## Usage

Usage information can be found by executing `flutter_analyze_reporter --help`

```
A parser to create reports from `flutter analyze` output.

-h, --[no-]help                  Print this usage information.
-r, --reporter                   Set output report type.

          [console] (default)    Print output to console.
          [gitlab]               Generate GitLab code quality JSON report.

-o, --output                     Output file name.
                                 (defaults to "report.json")
```
Usage example `flutter_analyze_reporter --output report.json --reporter gitlab`

# GitLab CI example

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
