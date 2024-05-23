class Task {
  final String title;
  final String description;
  final bool isCompleted;

  Task({
    required this.title,
    this.description = '',
    this.isCompleted = false,
  });

  Task copyWith({String? title, String? description, bool? isCompleted}) {
    return Task(
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  String toString() {
    return '$title|$description|$isCompleted';
  }

  static Task fromString(String taskString) {
    final parts = taskString.split('|');
    return Task(
      title: parts[0],
      description: parts[1],
      isCompleted: parts[2] == 'true',
    );
  }
}
