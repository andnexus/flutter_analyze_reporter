import 'package:flutter_analyze_reporter/src/model/issue.dart';

abstract class Convert {
  String convert(List<Issue> issues);
}
