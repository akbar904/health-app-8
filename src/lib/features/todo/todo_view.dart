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
      viewModelBuilder: () => TodoViewModel(context.read()),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Todo List'),
        ),
        body: Column(
          children: [
            TodoInput(
              onSubmit: model.addTodo,
            ),
            Expanded(
              child: TodoList(
                todos: model.todos,
                onToggle: model.toggleTodo,
                onDelete: model.deleteTodo,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
