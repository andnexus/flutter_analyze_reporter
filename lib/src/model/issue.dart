import 'package:flutter_analyze_reporter/src/model/issue_type.dart';
import 'package:flutter_analyze_reporter/src/model/location.dart';

class Issue {
  final String raw;
  final IssueType type;
  final String description;
  final Location location;
  final String checkName;

  Issue({
    required this.raw,
    required this.type,
    required this.description,
    required this.location,
    required this.checkName,
  });
}
