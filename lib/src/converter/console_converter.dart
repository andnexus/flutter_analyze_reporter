import 'package:ansicolor/ansicolor.dart';
import 'package:flutter_analyze_reporter/src/converter/converter.dart';
import 'package:flutter_analyze_reporter/src/model/issue.dart';
import 'package:flutter_analyze_reporter/src/model/issue_type.dart';

class ConsoleConverter extends Converter {
  @override
  String convert(List<Issue> issues) {
    if (issues.isEmpty) {
      return "No issues found!";
    }
    final AnsiPen greenPen = AnsiPen()..green();
    final AnsiPen yellowPen = AnsiPen()..yellow();
    final AnsiPen redPen = AnsiPen()..red();
    String stdout = '\n';
    for (final issue in issues) {
      final row =
          '\t${issue.type}\t${issue.checkName}\t${issue.location.path}:${issue.location.line}\t${issue.description}\n';
      switch (issue.type) {
        case IssueType.info:
          stdout += greenPen(row);
          break;
        case IssueType.warning:
          stdout += yellowPen(row);
          break;
        case IssueType.error:
          stdout += redPen(row);
          break;
      }
    }
    return stdout;
  }
}
