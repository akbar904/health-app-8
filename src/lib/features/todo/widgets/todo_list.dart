import 'package:flutter/material.dart';
import 'package:my_app/features/todo/todo_model.dart';
import 'package:my_app/features/todo/widgets/todo_item.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;
  final Function(String) onToggle;
  final Function(String) onDelete;

  const TodoList({
    super.key,
    required this.todos,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoItem(
          todo: todo,
          onToggle: onToggle,
          onDelete: onDelete,
        );
      },
    );
  }
}
