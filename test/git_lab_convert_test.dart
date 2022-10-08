import 'package:flutter_analyze_reporter/src/converter/git_lab_converter.dart';
import 'package:flutter_analyze_reporter/src/parser/flutter_analyze_parser.dart';
import 'package:test/test.dart';

void main() {
  test('Validate GitLab JSON output', () {
    var stdout =
        r'  info • DESCRIPTION `"*?!"§$%&/()=?`)\^^^“``""" • PATH:5:23 • CHECK_NAME';
    var issues = FlutterAnalyzeParser().flutterAnalyze(stdout: stdout);
    var json = GitLabConverter().convert(issues);
    expect(json,
        r'[{"type":"info","severity":"info","check_name":"CHECK_NAME","description":"DESCRIPTION `\"*?!\"§$%&/()=?`)\\^^^“``\"\"\"","categories":["Clarity","Style"],"fingerprint":"0ab4021f543b794d6fe8d2766f50e8df","location":{"path":"PATH","positions":{"begin":{"line":5,"column":23},"end":{"line":5,"column":23}}}}]');
  });
}
