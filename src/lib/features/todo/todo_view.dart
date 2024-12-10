import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'todo_viewmodel.dart';
import 'widgets/todo_input.dart';
import 'widgets/todo_list.dart';

class TodoView extends StackedView<TodoViewModel> {
  const TodoView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, TodoViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Todos'),
      ),
      body: Column(
        children: [
          TodoInput(
            onSubmit: (title, description) async {
              await viewModel.addTodo(title, description);
            },
          ),
          Expanded(
            child: TodoList(
              todos: viewModel.todos,
              onToggle: (id) => viewModel.toggleTodo(id),
              onDelete: (id) => viewModel.deleteTodo(id),
              onTap: (todo) => viewModel.showTodoDetails(todo),
            ),
          ),
        ],
      ),
    );
  }

  @override
  TodoViewModel viewModelBuilder(BuildContext context) => TodoViewModel(
        repository: TodoRepository(),
        dialogService: DialogService(),
        bottomSheetService: BottomSheetService(),
      );

  @override
  void onViewModelReady(TodoViewModel viewModel) => viewModel.initialize();
}
