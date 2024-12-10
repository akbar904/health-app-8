import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/home/home_viewmodel.dart';
import 'package:my_app/features/home/widgets/todo_list.dart';
import 'package:my_app/features/home/widgets/add_todo_button.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: viewModel.toggleSortOrder,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: TodoList(
              todos: viewModel.todos,
              onTodoToggled: viewModel.toggleTodoComplete,
              onTodoDeleted: viewModel.deleteTodo,
              onTodoEdited: viewModel.editTodo,
            ),
          ),
        ],
      ),
      floatingActionButton: const AddTodoButton(),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
