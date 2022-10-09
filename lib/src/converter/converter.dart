import 'package:flutter_analyze_reporter/src/model/issue.dart';

/// Converter interface.
abstract class Converter {
  /// Convert from Flutter analyze issues to output.
  String convert(List<Issue> issues);
}
