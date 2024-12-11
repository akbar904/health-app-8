class Todo {
  final String id;
  final String title;
  final bool isCompleted;
  final DateTime? completedAt;

  Todo({
    required this.id,
    required this.title,
    this.isCompleted = false,
    this.completedAt,
  });

  Todo copyWith({
    String? id,
    String? title,
    bool? isCompleted,
    DateTime? completedAt,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
    );
  }
}