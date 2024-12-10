import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/todo/todo_viewmodel.dart';
import 'package:my_app/features/todo/widgets/todo_item.dart';
import 'package:gap/gap.dart';

class TodoView extends StackedView<TodoViewModel> {
  const TodoView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, TodoViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: viewModel.todos.isEmpty
                      ? const Center(child: Text('No todos yet'))
                      : ListView.separated(
                          itemCount: viewModel.todos.length,
                          separatorBuilder: (context, index) => const Divider(),
                          itemBuilder: (context, index) {
                            final todo = viewModel.todos[index];
                            return TodoItem(
                              todo: todo,
                              onToggleComplete: (value) =>
                                  viewModel.toggleTodoComplete(todo),
                              onDelete: () => viewModel.deleteTodo(todo),
                            );
                          },
                        ),
                ),
                const Gap(16),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.showAddTodoSheet,
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  TodoViewModel viewModelBuilder(BuildContext context) => TodoViewModel();
}
