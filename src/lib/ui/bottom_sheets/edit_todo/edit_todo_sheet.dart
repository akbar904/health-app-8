import 'package:flutter/material.dart';
import 'package:my_app/models/todo_model.dart';
import 'package:stacked_services/stacked_services.dart';

class EditTodoSheet extends StatelessWidget {
  final Function(SheetResponse) completer;
  final SheetRequest request;

  const EditTodoSheet({
    required this.completer,
    required this.request,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todo = request.data as TodoModel;
    final controller = TextEditingController(text: todo.title);

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Edit Todo',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Todo Title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () => completer(SheetResponse(confirmed: false)),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  final updatedTodo = todo.copyWith(
                    title: controller.text.trim(),
                  );
                  completer(SheetResponse(
                    confirmed: true,
                    data: updatedTodo,
                  ));
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
