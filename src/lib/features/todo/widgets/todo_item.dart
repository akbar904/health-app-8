import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/todo_model.dart';

class TodoItem extends StatelessWidget {
  final TodoModel todo;
  final Function(bool?) onToggle;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const TodoItem({
    Key? key,
    required this.todo,
    required this.onToggle,
    required this.onDelete,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Checkbox(
          value: todo.isCompleted,
          onChanged: onToggle,
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(
          'Created: ${DateFormat.yMMMd().format(todo.createdAt)}',
          style: const TextStyle(fontSize: 12),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
        onTap: onTap,
      ),
    );
  }
}
