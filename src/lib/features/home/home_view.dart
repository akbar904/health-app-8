import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/home/home_viewmodel.dart';
import 'package:my_app/features/home/widgets/todo_list.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: viewModel.toggleFilter,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SegmentedButton<bool>(
              segments: const [
                ButtonSegment(
                  value: false,
                  label: Text('Active'),
                ),
                ButtonSegment(
                  value: true,
                  label: Text('Completed'),
                ),
              ],
              selected: {viewModel.showCompleted},
              onSelectionChanged: (Set<bool> selection) {
                viewModel.setShowCompleted(selection.first);
              },
            ),
          ),
          Expanded(
            child: TodoList(
              todos: viewModel.filteredTodos,
              onToggleTodo: viewModel.toggleTodoCompletion,
              onEditTodo: viewModel.showEditDialog,
              onDeleteTodo: viewModel.deleteTodo,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.showAddDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
