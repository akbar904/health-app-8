import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/home/home_viewmodel.dart';
import 'package:my_app/ui/widgets/todo_input.dart';
import 'package:my_app/ui/widgets/todo_item.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: Column(
        children: [
          TodoInput(
            controller: viewModel.todoController,
            onSubmit: viewModel.addTodo,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: viewModel.todos.length,
              itemBuilder: (context, index) {
                final todo = viewModel.todos[index];
                return TodoItem(
                  todo: todo,
                  onToggle: () => viewModel.toggleTodo(todo.id),
                  onDelete: () => viewModel.deleteTodo(todo.id),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) =>
      HomeViewModel(TodoService());
}
