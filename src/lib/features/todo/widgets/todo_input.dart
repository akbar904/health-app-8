import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/todo/todo_viewmodel.dart';

class TodoInput extends ViewModelWidget<TodoViewModel> {
  const TodoInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, TodoViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: viewModel.todoController,
              decoration: const InputDecoration(
                hintText: 'Add a new todo',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  viewModel.addTodo();
                }
              },
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            onPressed: viewModel.todoController.text.isNotEmpty
                ? viewModel.addTodo
                : null,
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
