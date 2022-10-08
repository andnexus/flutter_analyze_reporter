import 'dart:convert';

import 'package:crypto/crypto.dart';

import '../../issue.dart';
import '../converter.dart';
import 'gitlab_issue.dart';

class GitLabConvert extends Convert<GitLabIssue> {
  @override
  List<GitLabIssue> convert(List<Issue> issues) {
    final List<GitLabIssue> gitlabIssues = <GitLabIssue>[];
    for (final element in issues) {
      final type = severity(element.type);
      gitlabIssues.add(
        GitLabIssue(
          type: type,
          severity: type,
          checkName: element.checkName,
          description: element.description,
          categories: categories(element.type),
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
    return gitlabIssues;
  }

  // Map values from dart analyzer to dart code metrics for GitLab code climate widget.
  // code climate: category: Bug Risk, Clarity, Compatibility, Complexity, Duplication, Performance, Security, Style
  @override
  List<String> categories(String type) {
    final List<String> categories = <String>['Clarity'];
    switch (type) {
      case "info":
        categories.add("Style");
        break;
      case "warning":
        categories.add("Bug Risk");
        break;
      case "error":
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
  @override
  String severity(String type) {
    String severity;
    switch (type) {
      case "info":
        severity = "info";
        break;
      case "warning":
        severity = "major";
        break;
      case "error":
        severity = "blocker";
        break;
      default:
        severity = "critical";
        break;
    }
    return severity;
  }
}
