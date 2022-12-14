import 'package:flutter_analyze_reporter/src/converter/converter.dart';
import 'package:flutter_analyze_reporter/src/model/issue.dart';
import 'package:xml/xml.dart';

/// Convert to checkstyle XML.
class CheckstyleConverter extends Converter {
  @override
  String convert(List<Issue> issues) {
    final builder = XmlBuilder();

    builder
      ..processing('xml', 'version="1.0"')
      ..element(
        'checkstyle',
        attributes: {'version': '10.0'},
        nest: () {
          for (final issue in issues) {
            builder.element(
              'file',
              attributes: {'name': issue.location.path},
              nest: () {
                _reportIssues(builder, issue);
              },
            );
          }
        },
      );
    return builder.buildDocument().toXmlString();
  }

  void _reportIssues(XmlBuilder builder, Issue issue) {
    final locationStart = issue.location;
    builder.element(
      'error',
      attributes: {
        'line': '${locationStart.line}',
        if (locationStart.column > 0) 'column': '${locationStart.column}',
        'severity': issue.type.name,
        'message': issue.description,
        'source': issue.checkName,
      },
    );
  }
}
