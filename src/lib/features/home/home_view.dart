import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/home/home_viewmodel.dart';
import 'package:my_app/ui/widgets/todo_list.dart';
import 'package:my_app/ui/widgets/add_todo_button.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.file_download),
            onPressed: viewModel.importTodos,
          ),
          IconButton(
            icon: const Icon(Icons.file_upload),
            onPressed: viewModel.exportTodos,
          ),
        ],
      ),
      body: TodoList(
        todos: viewModel.todos,
        onToggle: viewModel.toggleTodoStatus,
        onEdit: viewModel.showEditDialog,
        onDelete: viewModel.deleteTodo,
      ),
      floatingActionButton: AddTodoButton(
        onPressed: viewModel.showAddDialog,
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
