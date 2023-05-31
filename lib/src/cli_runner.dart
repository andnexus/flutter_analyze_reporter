import 'dart:core';
import 'dart:io';

import 'package:args/args.dart';
import 'package:flutter_analyze_reporter/src/converter/checkstyle_converter.dart';
import 'package:flutter_analyze_reporter/src/converter/console_converter.dart';
import 'package:flutter_analyze_reporter/src/converter/github_converter.dart';
import 'package:flutter_analyze_reporter/src/converter/gitlab_converter.dart';
import 'package:flutter_analyze_reporter/src/model/reporter/reporter.dart';
import 'package:flutter_analyze_reporter/src/parser/flutter_analyze_arg_parser.dart';
import 'package:flutter_analyze_reporter/src/parser/flutter_analyze_parser.dart';

/// Command-line interface parsing and routing.
class CliRunner {
  /// Route command-line interface arguments.
  void run(List<String> args) {
    final flutterAnalyzeArgParser = FlutterAnalyzeArgParser();
    final ArgResults results = flutterAnalyzeArgParser.parse(args);
    if (results.wasParsed(FlutterAnalyzeArgParser.help)) {
      // ignore: avoid_print
      print(flutterAnalyzeArgParser.usage);
    } else {
      final issues = FlutterAnalyzeParser().flutterAnalyze();
      final path = results[FlutterAnalyzeArgParser.output].toString();
      final reporter = Reporter.values
          .byName(results[FlutterAnalyzeArgParser.reporter].toString());
      switch (reporter) {
        case Reporter.console:
          // ignore: avoid_print
          print(ConsoleConverter().convert(issues));
          break;
        case Reporter.gitlab:
          File(path).writeAsStringSync(GitLabConverter().convert(issues));
          break;
        case Reporter.github:
          // ignore: avoid_print
          print(GitHubConverter().convert(issues));
          break;
        case Reporter.checkstyle:
          File(path).writeAsStringSync(CheckstyleConverter().convert(issues));
          break;
      }
    }
  }
}
