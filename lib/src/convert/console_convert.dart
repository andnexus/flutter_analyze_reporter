import 'package:ansicolor/ansicolor.dart';
import 'package:flutter_analyze_reporter/src/convert/convert.dart';
import 'package:flutter_analyze_reporter/src/model/issue.dart';

class ConsoleConvert extends Convert {
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
        case "info":
          stdout += greenPen(row);
          break;
        case "warning":
          stdout += yellowPen(row);
          break;
        case "error":
          stdout += redPen(row);
          break;
      }
    }
    return stdout;
  }
}
