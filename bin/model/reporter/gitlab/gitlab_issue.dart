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

class GitLabLocation {
  final String path;
  final GitlabPositions positions;

  GitLabLocation({
    required this.path,
    required this.positions,
  });

  Map<String, dynamic> toJson() => {
        'path': path,
        'positions': positions,
      };
}

class GitlabPositions {
  final GitLabPosition begin;
  final GitLabPosition end;

  GitlabPositions({
    required this.begin,
    required this.end,
  });

  Map<String, dynamic> toJson() => {
        'begin': begin,
        'end': end,
      };
}

class GitLabPosition {
  final int line;
  final int column;

  GitLabPosition({
    required this.line,
    required this.column,
  });

  Map<String, dynamic> toJson() => {
        'line': line,
        'column': column,
      };
}
