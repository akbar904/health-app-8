import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/todo/todo_viewmodel.dart';
import 'package:my_app/features/todo/widgets/todo_item.dart';

class TodoView extends StatelessWidget {
  const TodoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TodoViewModel>.reactive(
      viewModelBuilder: () => TodoViewModel(),
      onViewModelReady: (model) => model.initialize(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Todo List'),
          ),
          body: model.isBusy
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: model.todos.length,
                  itemBuilder: (context, index) {
                    final todo = model.todos[index];
                    return TodoItem(
                      todo: todo,
                      onToggle: () => model.toggleTodo(todo),
                      onDelete: () => model.deleteTodo(todo.id),
                    );
                  },
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: model.showAddTodoSheet,
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
