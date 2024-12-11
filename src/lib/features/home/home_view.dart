import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/home/home_viewmodel.dart';
import 'package:my_app/features/home/widgets/todo_input.dart';
import 'package:my_app/features/home/widgets/todo_list_item.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: viewModel.toggleShowCompleted,
          ),
        ],
      ),
      body: Column(
        children: [
          TodoInput(
            titleController: viewModel.titleController,
            descriptionController: viewModel.descriptionController,
            onSubmit: viewModel.addTodo,
          ),
          const Gap(16),
          Expanded(
            child: ListView.builder(
              itemCount: viewModel.filteredTodos.length,
              itemBuilder: (context, index) {
                final todo = viewModel.filteredTodos[index];
                return TodoListItem(
                  todo: todo,
                  onToggle: viewModel.toggleTodoCompletion,
                  onTap: viewModel.showTodoDetails,
                  onLongPress: viewModel.showTodoOptions,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
