Flutter Analyze Reporter is a parser to create reports from `flutter analyze` output.

It supports [GitLab Code Quality Widget](https://docs.gitlab.com/ee/ci/testing/code_quality.html)
format
or [GitHub Workflow messages](https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions)
.

Currently only useful if you would like to display lint issues within or create a checkstyle report.

## GitLab Code Quality Widget

Code quality degraded

![GitLab Merge Request Code Quality Widget](https://raw.githubusercontent.com/andnexus/flutter_analyze_reporter/main/assets/code_quality_degraded.png "GitLab Merge Request Code Quality Widget")

No Changes to code quality

![GitLab Merge Request Code Quality Widget](https://raw.githubusercontent.com/andnexus/flutter_analyze_reporter/main/assets/no_changes_to_code_quality.png "GitLab Merge Request Code Quality Widget")

## GitHub workflow summary

Warning, error and notice messages

![GitHub Workflow Messages](https://raw.githubusercontent.com/andnexus/flutter_analyze_reporter/main/assets/github_workflow_summary.png "GitHub Workflow Summary")

## Console output

Error, warning and info colorized

![Error, warning and info colorized](https://raw.githubusercontent.com/andnexus/flutter_analyze_reporter/main/assets/console_output.png "Error, warning and info colorized")