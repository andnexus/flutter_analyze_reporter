import 'package:args/args.dart';

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
      allowed: ['console', 'gitlab'],
      allowedHelp: {
        'console': 'Print output to console.',
        'gitlab': 'Generate GitLab code quality JSON report.',
      },
    );

    _parser.addOption(
      output,
      abbr: 'o',
      defaultsTo: 'report.json',
      help: 'Output file name.',
    );
  }

  ArgResults parse(List<String> args) => _parser.parse(args);

  String get usage => _parser.usage;
}
