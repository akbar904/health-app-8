import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/features/todo/todo_viewmodel.dart';
import 'package:my_app/services/todo_service.dart';
import 'package:stacked_services/stacked_services.dart';

class TodoView extends StatelessWidget {
  const TodoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TodoViewModel>.reactive(
      viewModelBuilder: () => TodoViewModel(
        locator<TodoService>(),
        locator<DialogService>(),
      ),
      onViewModelReady: (model) => model.initialize(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Todo App'),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  onSubmitted: model.addTodo,
                  decoration: const InputDecoration(
                    hintText: 'Add a new todo...',
                  ),
                ),
              ),
              Expanded(
                child: model.isBusy
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: model.todos.length,
                        itemBuilder: (context, index) {
                          final todo = model.todos[index];
                          return ListTile(
                            title: Text(todo.title),
                            leading: Checkbox(
                              value: todo.isCompleted,
                              onChanged: (_) => model.toggleTodoStatus(todo),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => model.deleteTodo(todo.id),
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