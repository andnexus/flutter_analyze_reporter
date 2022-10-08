library flutter_analyze_reporter;

import 'package:flutter_analyze_reporter/src/cli_runner.dart';

// Activate locally: dart pub global activate -s path .
void main(List<String> args) {
  CliRunner().run(args);
}
