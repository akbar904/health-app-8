import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/features/todo/todo_viewmodel.dart';
import 'package:my_app/services/todo_service.dart';
import 'package:my_app/models/todo.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TodoViewModel>.reactive(
      viewModelBuilder: () => TodoViewModel(
        locator<TodoService>(),
      ),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Todo List'),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onSubmitted: viewModel.addTodo,
                  decoration: const InputDecoration(
                    hintText: 'Add a todo',
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: viewModel.todos.length,
                  itemBuilder: (context, index) {
                    final todo = viewModel.todos[index];
                    return ListTile(
                      title: Text(todo.title),
                      leading: Checkbox(
                        value: todo.isCompleted,
                        onChanged: (_) => viewModel.toggleTodoCompletion(todo.id),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => viewModel.deleteTodo(todo.id),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}