import 'package:flutter/material.dart';
import 'package:my_app/features/todo/todo_model.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final Function(Todo) onToggle;
  final Function(Todo) onDelete;
  final Function(Todo) onEdit;

  const TodoItem({
    Key? key,
    required this.todo,
    required this.onToggle,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(todo.id),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete(todo),
      child: ListTile(
        leading: Checkbox(
          value: todo.isComplete,
          onChanged: (_) => onToggle(todo),
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.isComplete ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(
          'Created: ${todo.createdAt.toString().split('.')[0]}',
          style: const TextStyle(fontSize: 12),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () => onEdit(todo),
        ),
      ),
    );
  }
}
