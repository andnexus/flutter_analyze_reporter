import 'location.dart';

class Issue {
  final String type;
  final String description;
  final Location location;
  final String checkName;

  Issue({
    required this.type,
    required this.description,
    required this.location,
    required this.checkName,
  });
}
