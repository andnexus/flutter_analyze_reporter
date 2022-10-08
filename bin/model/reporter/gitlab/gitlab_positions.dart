import 'gitlab_position.dart';

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
