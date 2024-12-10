import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../features/todo/models/todo_model.dart';

class TodoDetailsSheet extends StatelessWidget {
  final SheetRequest request;
  final Function(SheetResponse) completer;

  const TodoDetailsSheet({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todo = request.data as TodoModel;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                todo.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => completer(SheetResponse()),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            todo.description,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          Text(
            'Created: ${DateFormat.yMMMd().format(todo.createdAt)}',
            style: const TextStyle(color: Colors.grey),
          ),
          if (todo.completedAt != null)
            Text(
              'Completed: ${DateFormat.yMMMd().format(todo.completedAt!)}',
              style: const TextStyle(color: Colors.green),
            ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
