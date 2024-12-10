import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/features/todo/todo_model.dart';

class TodoOptionsSheet extends StatelessWidget {
  final SheetRequest request;
  final Function(SheetResponse) completer;

  const TodoOptionsSheet({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todos = request.data as List<Todo>;
    final completedCount = todos.where((todo) => todo.isCompleted).length;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Todo Options',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.list),
            title: Text('Total todos: ${todos.length}'),
          ),
          ListTile(
            leading: const Icon(Icons.check_circle),
            title: Text('Completed: $completedCount'),
          ),
          ListTile(
            leading: const Icon(Icons.delete_sweep),
            title: const Text('Clear completed todos'),
            onTap: () => completer(SheetResponse(confirmed: true)),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
