import 'package:args/args.dart';
import 'package:flutter_analyze_reporter/src/model/reporter/reporter.dart';

class FlutterAnalyzeArgParser {
  static final ArgParser _parser = ArgParser();
  static const String help = "help";
  static const String reporter = "reporter";
  static const String output = "output";

  FlutterAnalyzeArgParser() {
    _parser.addSeparator(
      'A parser to create reports from `flutter analyze` output.\n',
    );

    _parser.addFlag(
      help,
      abbr: 'h',
      help: 'Print this usage information.',
    );

    _parser.addOption(
      reporter,
      abbr: 'r',
      defaultsTo: 'console',
      help: 'Set output report type.',
      allowed: Reporter.values.map((e) => e.name),
      allowedHelp: Map<String, String>.fromEntries(
        Reporter.values.map(
          (e) {
            switch (e) {
              case Reporter.console:
                return MapEntry(e.name, 'Print output to console.');
              case Reporter.gitlab:
                return MapEntry(
                  e.name,
                  'Generate GitLab code quality JSON report.',
                );
              case Reporter.checkstyle:
                return MapEntry(e.name, 'Generate Checkstyle report.');
            }
          },
        ),
      ),
    );

    _parser.addOption(
      output,
      abbr: 'o',
      defaultsTo: 'report',
      help: 'Output file name.',
    );
  }

  ArgResults parse(List<String> args) => _parser.parse(args);

  String get usage => _parser.usage;
}
