import 'package:flutter/material.dart';
import 'package:my_app/models/todo.dart';
import 'package:intl/intl.dart';

class TodoListItem extends StatelessWidget {
  final Todo todo;
  final Function(String) onToggle;
  final Function(String) onTap;
  final Function(String) onLongPress;

  const TodoListItem({
    Key? key,
    required this.todo,
    required this.onToggle,
    required this.onTap,
    required this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Checkbox(
          value: todo.isCompleted,
          onChanged: (_) => onToggle(todo.id),
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
        onTap: () => onTap(todo.id),
        onLongPress: () => onLongPress(todo.id),
      ),
    );
  }
}
