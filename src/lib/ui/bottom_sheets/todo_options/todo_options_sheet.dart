import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/features/todo/todo_model.dart';

class TodoOptionsSheet extends StatelessWidget {
  final Function(SheetResponse)? completer;
  final SheetRequest request;

  const TodoOptionsSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todo = request.data as Todo;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit Todo'),
            onTap: () => completer?.call(SheetResponse(data: 'edit')),
          ),
          ListTile(
            leading: const Icon(Icons.delete, color: Colors.red),
            title:
                const Text('Delete Todo', style: TextStyle(color: Colors.red)),
            onTap: () => completer?.call(SheetResponse(data: 'delete')),
          ),
          ListTile(
            leading: Icon(todo.isComplete
                ? Icons.check_box
                : Icons.check_box_outline_blank),
            title: Text(
                todo.isComplete ? 'Mark as Incomplete' : 'Mark as Complete'),
            onTap: () => completer?.call(SheetResponse(data: 'toggle')),
          ),
        ],
      ),
    );
  }
}
