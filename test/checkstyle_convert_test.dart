import 'package:flutter_analyze_reporter/src/converter/checkstyle_converter.dart';
import 'package:flutter_analyze_reporter/src/parser/flutter_analyze_parser.dart';
import 'package:test/test.dart';

void main() {
  test('Validate checkstyle XML output', () {
    const stdout =
        r'  info • DESCRIPTION `"*?!"§$%&/()=?`)\^^^“``""" • PATH:5:23 • CHECK_NAME';
    final issues = FlutterAnalyzeParser().flutterAnalyze(stdout: stdout);
    final xml = CheckstyleConverter().convert(issues);
    expect(
      xml,
      r'<?xml version="1.0"?><checkstyle version="10.0"><file name="PATH"><error line="5" column="23" severity="info" message="DESCRIPTION `&quot;*?!&quot;§$%&amp;/()=?`)\^^^“``&quot;&quot;&quot;" source="CHECK_NAME"/></file></checkstyle>',
    );
  });
}
