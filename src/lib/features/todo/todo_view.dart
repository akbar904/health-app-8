import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/todo/todo_viewmodel.dart';
import 'package:my_app/features/todo/widgets/todo_input.dart';
import 'package:my_app/features/todo/widgets/todo_list.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TodoViewModel>.reactive(
      viewModelBuilder: () => TodoViewModel(
        TodoService(TodoRepository()),
        DialogService(),
      ),
      onViewModelReady: (model) => model.initialize(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Todo App'),
          ),
          body: Column(
            children: [
              TodoInput(onSubmit: model.addTodo),
              Expanded(
                child: model.isBusy
                    ? const Center(child: CircularProgressIndicator())
                    : TodoList(
                        todos: model.todos,
                        onToggle: model.toggleTodoStatus,
                        onDelete: model.deleteTodo,
                        onUpdate: model.updateTodoTitle,
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
