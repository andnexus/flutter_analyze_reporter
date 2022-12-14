import 'package:flutter_analyze_reporter/src/model/issue_type.dart';
import 'package:flutter_analyze_reporter/src/parser/flutter_analyze_parser.dart';
import 'package:test/test.dart';

void main() {
  test('Parse flutter analyze issue', () {
    const stdout =
        '  info • DESCRIPTION • PATH:5:23 • CHECK_NAME\n  info • DESCRIPTION • PATH:42:42 • CHECK_NAME';
    final issues = FlutterAnalyzeParser().flutterAnalyze(stdout: stdout);
    expect(issues.length, equals(2));
    expect(
      issues.first.raw,
      equals("  info • DESCRIPTION • PATH:5:23 • CHECK_NAME"),
    );
    expect(issues.first.type, equals(IssueType.info));
    expect(issues.first.description, equals("DESCRIPTION"));
    expect(issues.first.checkName, equals("CHECK_NAME"));
    expect(issues.first.location.path, equals("PATH"));
    expect(issues.first.location.line, equals(5));
    expect(issues.first.location.column, equals(23));
  });
}
