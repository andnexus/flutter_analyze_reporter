import 'dart:core';
import 'dart:io';

import 'package:args/args.dart';
import 'package:flutter_analyze_reporter/src/model/reporter/checkstyle_convert.dart';
import 'package:flutter_analyze_reporter/src/model/reporter/console_convert.dart';
import 'package:flutter_analyze_reporter/src/model/reporter/git_lab_convert.dart';
import 'package:flutter_analyze_reporter/src/model/reporter/reporter.dart';
import 'package:flutter_analyze_reporter/src/parser/flutter_analyze_arg_parser.dart';
import 'package:flutter_analyze_reporter/src/parser/flutter_analyze_parser.dart';

class CliRunner {
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
          print(ConsoleConvert().convert(issues));
          break;
        case Reporter.gitlab:
          File(path).writeAsStringSync(GitLabConvert().convert(issues));
          break;
        case Reporter.checkstyle:
          File(path).writeAsStringSync(CheckstyleConvert().convert(issues));
          break;
      }
    }
  }
}
