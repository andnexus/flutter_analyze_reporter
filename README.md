Flutter Analyze Reporter is parser to create reports from `flutter analyze` output. 

Currently only useful if you would like to display lint issues within GitLab Code Quality Widget.

## Usage

Parse `flutter analyze` output for [GitLab Code Quality Widget](https://docs.gitlab.com/ee/ci/testing/code_quality.html).

Example `.gitlab-ci.yml` file:
```
stages:
  - test
code_quality:
  stage: test
  allow_failure: true
  before_script:
    - export PATH="$PATH":"$HOME/.pub-cache/bin"
  script:
    - dart pub global activate flutter_analyze_reporter
    - flutter_analyze_reporter --output=report.json --reporter=gitlab
  reports:
    codequality: report.json
```
## GitLab Code Quality Widget 

Code quality degraded

![GitLab Merge Request Code Quality Widget](https://github.com/andnexus/flutter_analyze_reporter/blob/main/assets/code_quality_degraded.png?raw=true "GitLab Merge Request Code Quality Widget")

No Changes to code quality

![GitLab Merge Request Code Quality Widget](https://github.com/andnexus/flutter_analyze_reporter/blob/main/assets/no_changes_to_code_quality.png?raw=true "GitLab Merge Request Code Quality Widget")
