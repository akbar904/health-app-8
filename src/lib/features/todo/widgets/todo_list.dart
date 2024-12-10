import 'package:flutter/material.dart';
import 'package:my_app/models/todo_model.dart';
import 'package:my_app/features/todo/widgets/todo_item.dart';

class TodoList extends StatelessWidget {
  final List<TodoModel> todos;
  final Function(TodoModel) onToggle;
  final Function(String) onDelete;
  final Function(String, String) onUpdate;

  const TodoList({
    super.key,
    required this.todos,
    required this.onToggle,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: todos.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        return TodoItem(
          todo: todos[index],
          onToggle: onToggle,
          onDelete: onDelete,
          onUpdate: onUpdate,
        );
      },
    );
  }
}
