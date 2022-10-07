library flutter_analyze_reporter;

import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:args/args.dart';
import 'package:crypto/crypto.dart';

extension BoolParsing on String {
  bool parseBool() {
    return toLowerCase() == 'true';
  }
}

void main(List<String> args) {
  final ArgParser parser = ArgParser();
  parser.addSeparator(
    'A parser to create reports from `flutter analyze` output.\n',
  );

  parser.addFlag(
    'help',
    abbr: 'h',
    help: 'Print this usage information.',
  );

  parser.addOption(
    'reporter',
    abbr: 'r',
    defaultsTo: 'console',
    help: 'Set output report type.',
    allowed: ['console', 'gitlab'],
    allowedHelp: {
      'console': 'Print output to console.',
      'gitlab': 'Generate GitLab code quality JSON report.',
    },
  );

  parser.addOption(
    'output',
    abbr: 'o',
    defaultsTo: 'report.json',
    help: 'Output file name.',
  );

  final ArgResults results = parser.parse(args);

  if (results['help'].toString().parseBool()) {
    // ignore: avoid_print
    print(parser.usage);
  } else {
    _flutterAnalyze(
      results['output'].toString(),
      results['reporter'].toString(),
    );
  }
}

_flutterAnalyze(String output, String reporter) {
  final ProcessResult result = Process.runSync('flutter', [
    'analyze',
    '--suppress-analytics',
  ]);
  if (reporter == "console") {
    // ignore: avoid_print
    print(result.stdout);
    // ignore: avoid_print
    print(result.stderr);
  } else if (reporter == "gitlab") {
    String json = "[]";
    if (result.stderr.toString().isNotEmpty) {
      // TYPE • DESCRIPTION • PATH:LINE:COLUMN • CHECK_NAME
      const String delimiterSections = " • ";
      const String delimiterLocation = ":";
      json = "[";
      final List<String> lines =
          const LineSplitter().convert(result.stdout.toString());
      lines
          .where(
        (v) =>
            v.trim().isNotEmpty &&
            // type, description, location, identifier
            v.split(delimiterSections).length == 4 &&
            // path, line, column
            v.split(delimiterSections)[2].split(delimiterLocation).length == 3,
      )
          .forEach((issue) {
        final List<String> elements = issue.split(delimiterSections);
        // Map values from dart analyzer to dart code metrics for GitLab code climate widget.
        // code climate:
        // severity: info, minor, major, critical, blocker
        // category: Bug Risk, Clarity, Compatibility, Complexity, Duplication, Performance, Security, Style
        // dart analyzer:
        // severity: info, warning, error
        final String type = elements[0].trim();
        String severity;
        final List<String> categories = <String>['Clarity'];
        switch (type) {
          case "info":
            severity = "info";
            categories.add("Style");
            break;
          case "warning":
            severity = "major";
            categories.add("Security");
            break;
          case "error":
            severity = "blocker";
            categories.add("Bug Risk");
            break;
          default:
            severity = "critical";
            categories.add("Compatibility");
            break;
        }
        severity = jsonEncode(severity);
        final String description = jsonEncode(elements[1]);
        final List<String> location = elements[2].split(delimiterLocation);
        final String path = jsonEncode(location[0]);
        final String line = location[1];
        final String column = location[2];
        final String checkName = jsonEncode(elements[3]);
        final String fingerprint =
            jsonEncode(md5.convert(utf8.encode(issue)).toString());
        json +=
            """{"type":$severity,"check_name":$checkName,"description":$description,"categories":${jsonEncode(categories)},"location":{"path":$path,"positions":{"begin":{"line":$line,"column":$column},"end":{"line":$line,"column":$column}}},"severity":$severity,"fingerprint":$fingerprint},""";
      });
      json = json.substring(0, json.length - 1); // Remove last ','
      json += "]";
    }

    final File outputCodeClimate = File(output);
    outputCodeClimate.writeAsStringSync(json);
  }
}
