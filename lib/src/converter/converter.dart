import 'package:flutter_analyze_reporter/src/model/issue.dart';

abstract class Converter {
  String convert(List<Issue> issues);
}
