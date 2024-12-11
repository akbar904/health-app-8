import 'package:flutter/material.dart';
import 'package:my_app/models/todo_model.dart';
import 'package:my_app/ui/widgets/todo_item.dart';

class TodoList extends StatelessWidget {
  final List<TodoModel> todos;
  final Function(String) onToggle;
  final Function(TodoModel) onEdit;
  final Function(String) onDelete;

  const TodoList({
    required this.todos,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.task_alt,
              size: 64,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No tasks yet',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.5),
                  ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: todos.length,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoItem(
          todo: todo,
          onToggle: () => onToggle(todo.id),
          onEdit: () => onEdit(todo),
          onDelete: () => onDelete(todo.id),
        );
      },
    );
  }
}
