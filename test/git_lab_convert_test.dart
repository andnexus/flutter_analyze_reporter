import 'package:test/test.dart';

import '../bin/flutter_analyze_reporter.dart';
import '../bin/git_lab_convert.dart';

void main() {
  test('Validate GitLab JSON output', () {
    var stdout =
        r'  TYPE • DESCRIPTION `"*?!"§$%&/()=?`)\^^^“``""" • PATH:5:23 • CHECK_NAME';
    var issues = parseFlutterAnalyze(stdout);
    var json = GitLabConvert().convert(issues);
    expect(json,
        r'[{"type":"critical","severity":"critical","check_name":"CHECK_NAME","description":"DESCRIPTION `\"*?!\"§$%&/()=?`)\\^^^“``\"\"\"","categories":["Clarity","Compatibility"],"fingerprint":"2fd07f63852f9a6e26dccfe4c70b2170","location":{"path":"PATH","positions":{"begin":{"line":5,"column":23},"end":{"line":5,"column":23}}}}]');
  });
}
