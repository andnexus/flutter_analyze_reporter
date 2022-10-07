library flutter_analyze_reporter;

import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:args/args.dart';

import 'flutter_analyze_arg_parser.dart';
import 'model/issue.dart';
import 'model/location.dart';
import 'model/reporter/gitlab/git_lab_convert.dart';
import 'model/reporter/reporter.dart';

void main(List<String> args) {
  final flutterAnalyzeArgParser = FlutterAnalyzeArgParser();
  final ArgResults results = flutterAnalyzeArgParser.parse(args);
  if (results.wasParsed(FlutterAnalyzeArgParser.help)) {
    // ignore: avoid_print
    print(flutterAnalyzeArgParser.usage);
  } else {
    _flutterAnalyze(
      output: results[FlutterAnalyzeArgParser.output].toString(),
      reporter: results[FlutterAnalyzeArgParser.reporter].toString(),
    );
  }
}

void _flutterAnalyze({required String output, required String reporter}) {
  final ProcessResult result = Process.runSync('flutter', [
    'analyze',
    '--suppress-analytics',
  ]);
  if (reporter == Reporter.console.name) {
    // ignore: avoid_print
    print(result.stdout);
    // ignore: avoid_print
    print(result.stderr);
  } else {
    final List<Issue> issues = [];
    if (result.stderr.toString().isNotEmpty) {
      issues.addAll(_parseAnalyze(result.stdout.toString()));
    }
    switch (Reporter.values.byName(reporter)) {
      case Reporter.gitlab:
        final File outputCodeClimate = File(output);
        final String json = jsonEncode(GitLabConvert().convert(issues));
        outputCodeClimate.writeAsStringSync(json);
        break;
      default:
        break;
    }
  }
}

List<Issue> _parseAnalyze(String stdout) {
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
