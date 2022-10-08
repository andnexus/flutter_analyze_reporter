import 'package:test/test.dart';

import '../bin/checkstyle_convert.dart';
import '../bin/flutter_analyze_reporter.dart';
import '../bin/git_lab_convert.dart';

void main() {
  test('Validate checkstyle XML output', () {
    var stdout =
        r'  TYPE • DESCRIPTION `"*?!"§$%&/()=?`)\^^^“``""" • PATH:5:23 • CHECK_NAME';
    var issues = parseFlutterAnalyze(stdout);
    var xml = CheckstyleConvert().convert(issues);
    expect(xml,
        r'<?xml version="1.0"?><checkstyle version="10.0"><file name="PATH"><error line="5" column="23" severity="TYPE" message="DESCRIPTION `&quot;*?!&quot;§$%&amp;/()=?`)\^^^“``&quot;&quot;&quot;" source="CHECK_NAME"/></file></checkstyle>');
  });
}
