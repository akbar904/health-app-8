import 'package:flutter/material.dart';
import 'package:my_app/models/todo.dart';
import 'package:intl/intl.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const TodoItem({
    required this.todo,
    required this.onToggle,
    required this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Checkbox(
          value: todo.isCompleted,
          onChanged: (_) => onToggle(),
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(todo.description),
            const SizedBox(height: 4),
            Text(
              'Created: ${DateFormat.yMMMd().format(todo.createdAt)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            if (todo.completedAt != null)
              Text(
                'Completed: ${DateFormat.yMMMd().format(todo.completedAt!)}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: onDelete,
        ),
        isThreeLine: true,
      ),
    );
  }
}
