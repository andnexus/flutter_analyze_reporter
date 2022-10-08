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
