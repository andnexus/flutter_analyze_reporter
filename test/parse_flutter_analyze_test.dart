import 'dart:convert';

import 'package:test/test.dart';

import '../bin/flutter_analyze_reporter.dart';
import '../bin/git_lab_convert.dart';

void main() {
  test('Parse flutter analyze issue', () {
    var stdout = '  TYPE • DESCRIPTION • PATH:5:23 • CHECK_NAME\n  TYPE • DESCRIPTION • PATH:42:42 • CHECK_NAME';
    var issues = parseFlutterAnalyze(stdout);
    expect(issues.length, equals(2));
    expect(issues.first.raw, equals("  TYPE • DESCRIPTION • PATH:5:23 • CHECK_NAME"));
    expect(issues.first.type, equals("TYPE"));
    expect(issues.first.description, equals("DESCRIPTION"));
    expect(issues.first.checkName, equals("CHECK_NAME"));
    expect(issues.first.location.path, equals("PATH"));
    expect(issues.first.location.line, equals(5));
    expect(issues.first.location.column, equals(23));
  });

  test('Validate GitLab JSON output', () {
    var stdout = r'  TYPE • DESCRIPTION `"*?!"§$%&/()=?`)\^^^“``""" • PATH:5:23 • CHECK_NAME';
    var issues = parseFlutterAnalyze(stdout);
    var gitlabIssues = GitLabConvert().convert(issues);
    expect(issues.length, gitlabIssues.length);
    var json = jsonEncode(GitLabConvert().convert(issues));
    expect(json,
        r'[{"type":"critical","severity":"critical","check_name":"CHECK_NAME","description":"DESCRIPTION `\"*?!\"§$%&/()=?`)\\^^^“``\"\"\"","categories":["Clarity","Compatibility"],"fingerprint":"2fd07f63852f9a6e26dccfe4c70b2170","location":{"path":"PATH","positions":{"begin":{"line":5,"column":23},"end":{"line":5,"column":23}}}}]');
  });
}
