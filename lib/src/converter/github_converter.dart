import 'package:flutter_analyze_reporter/src/converter/converter.dart';
import 'package:flutter_analyze_reporter/src/model/issue.dart';
import 'package:flutter_analyze_reporter/src/model/issue_type.dart';

/// Print out GitHub workflow messages.
/// https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions
class GitHubConverter extends Converter {
  @override
  String convert(List<Issue> issues) {
    if (issues.isEmpty) {
      return "No issues found!";
    }
    String stdout = '';
    for (final issue in issues) {
      String type;
      switch (issue.type) {
        case IssueType.info:
          type = 'notice';
          break;
        case IssueType.warning:
          type = 'warning';
          break;
        case IssueType.error:
          type = 'error';
          break;
      }
      stdout +=
          '::$type file=${issue.location.path},line=${issue.location.line},endLine=${issue.location.line},title=${issue.checkName}::${issue.description}\n';
    }

    return stdout;
  }
}
