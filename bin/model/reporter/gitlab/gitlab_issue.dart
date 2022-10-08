import 'gitlab_location.dart';

class GitLabIssue {
  final String type;
  final String severity;
  final String checkName;
  final String description;
  final List<String> categories;
  final String fingerprint;
  final GitLabLocation location;

  GitLabIssue({
    required this.type,
    required this.severity,
    required this.checkName,
    required this.description,
    required this.categories,
    required this.fingerprint,
    required this.location,
  });

  Map<String, dynamic> toJson() => {
        'type': type,
        'severity': severity,
        'check_name': checkName,
        'description': description,
        'categories': categories,
        'fingerprint': fingerprint,
        'location': location,
      };
}
