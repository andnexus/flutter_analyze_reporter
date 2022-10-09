import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_analyze_reporter/src/converter/converter.dart';
import 'package:flutter_analyze_reporter/src/model/issue.dart';
import 'package:flutter_analyze_reporter/src/model/issue_type.dart';
import 'package:flutter_analyze_reporter/src/model/reporter/gitlab/gitlab_issue.dart';
import 'package:flutter_analyze_reporter/src/model/reporter/gitlab/gitlab_location.dart';
import 'package:flutter_analyze_reporter/src/model/reporter/gitlab/gitlab_position.dart';
import 'package:flutter_analyze_reporter/src/model/reporter/gitlab/gitlab_positions.dart';

/// Convert to GitLab Code Quality Widget JSON.
class GitLabConverter extends Converter {
  @override
  String convert(List<Issue> issues) {
    final List<GitLabIssue> gitlabIssues = <GitLabIssue>[];
    for (final element in issues) {
      final type = _severity(element.type);
      gitlabIssues.add(
        GitLabIssue(
          type: type,
          severity: type,
          checkName: element.checkName,
          description: element.description,
          categories: _categories(element.type),
          fingerprint: md5.convert(utf8.encode(element.raw)).toString(),
          location: GitLabLocation(
            path: element.location.path,
            positions: GitlabPositions(
              begin: GitLabPosition(
                line: element.location.line,
                column: element.location.column,
              ),
              end: GitLabPosition(
                line: element.location.line,
                column: element.location.column,
              ),
            ),
          ),
        ),
      );
    }
    return jsonEncode(gitlabIssues);
  }

  // Map values from dart analyzer to dart code metrics for GitLab code climate widget.
  // code climate: category: Bug Risk, Clarity, Compatibility, Complexity, Duplication, Performance, Security, Style
  List<String> _categories(IssueType type) {
    final List<String> categories = <String>['Clarity'];
    switch (type) {
      case IssueType.info:
        categories.add("Style");
        break;
      case IssueType.warning:
        categories.add("Bug Risk");
        break;
      case IssueType.error:
        categories.add("Bug Risk");
        break;
      default:
        categories.add("Compatibility");
        break;
    }
    return categories;
  }

  // Map values from dart analyzer to dart code metrics for GitLab code climate widget.
  // code climate: severity: info, minor, major, critical, blocker
  // dart analyzer: severity: info, warning, error
  String _severity(IssueType type) {
    String severity;
    switch (type) {
      case IssueType.info:
        severity = "info";
        break;
      case IssueType.warning:
        severity = "major";
        break;
      case IssueType.error:
        severity = "blocker";
        break;
      default:
        severity = "critical";
        break;
    }
    return severity;
  }
}
