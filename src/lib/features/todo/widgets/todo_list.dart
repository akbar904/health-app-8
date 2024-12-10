import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/todo/todo_viewmodel.dart';
import 'package:my_app/features/todo/widgets/todo_item.dart';

class TodoList extends ViewModelWidget<TodoViewModel> {
  const TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, TodoViewModel viewModel) {
    return ListView.builder(
      itemCount: viewModel.todos.length,
      itemBuilder: (context, index) {
        final todo = viewModel.todos[index];
        return TodoItem(
          todo: todo,
          onToggle: () => viewModel.toggleTodo(todo.id),
          onDelete: () => viewModel.deleteTodo(todo.id),
          onEdit: () => viewModel.startEditingTodo(todo),
        );
      },
    );
  }
}
