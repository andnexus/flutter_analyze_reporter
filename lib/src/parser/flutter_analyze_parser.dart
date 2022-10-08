import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:flutter_analyze_reporter/src/model/issue.dart';
import 'package:flutter_analyze_reporter/src/model/location.dart';

class FlutterAnalyzeParser {
  List<Issue> flutterAnalyze({String? stdout}) {
    if (stdout == null) {
      final ProcessResult result = Process.runSync('flutter', [
        'analyze',
        '--suppress-analytics',
        '--no-preamble',
        '--no-congratulate',
        '--no-fatal-infos',
        '--no-fatal-warnings',
      ]);
      stdout ??= result.stdout.toString();
    }
    return _parseFlutterAnalyze(stdout);
  }

  List<Issue> _parseFlutterAnalyze(String stdout) {
    // TYPE • DESCRIPTION • PATH:LINE:COLUMN • CHECK_NAME
    const String delimiterSections = " • ";
    const String delimiterLocation = ":";

    final List<Issue> result = [];
    final List<String> lines = const LineSplitter().convert(stdout);
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
      result.add(
        Issue(
          raw: issue,
          type: elements[0].trim(),
          description: elements[1],
          location: Location(
            line: int.parse(elements[2].split(delimiterLocation)[1]),
            column: int.parse(elements[2].split(delimiterLocation)[2]),
            path: elements[2].split(delimiterLocation)[0],
          ),
          checkName: elements[3],
        ),
      );
    });
    return result;
  }
}
