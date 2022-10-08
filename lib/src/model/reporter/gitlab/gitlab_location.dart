import 'package:flutter_analyze_reporter/src/model/reporter/gitlab/gitlab_positions.dart';

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
