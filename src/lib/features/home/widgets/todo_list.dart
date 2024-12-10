import 'package:flutter/material.dart';
import 'package:my_app/features/home/widgets/todo_item.dart';
import 'package:my_app/models/todo.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;
  final Function(String) onToggleTodo;
  final Function(String) onEditTodo;
  final Function(String) onDeleteTodo;

  const TodoList({
    required this.todos,
    required this.onToggleTodo,
    required this.onEditTodo,
    required this.onDeleteTodo,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) {
      return const Center(
        child: Text('No todos yet. Add one to get started!'),
      );
    }

    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoItem(
          todo: todo,
          onToggle: () => onToggleTodo(todo.id),
          onEdit: () => onEditTodo(todo.id),
          onDelete: () => onDeleteTodo(todo.id),
        );
      },
    );
  }
}
