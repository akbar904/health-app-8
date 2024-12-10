import 'package:flutter/material.dart';
import '../models/todo_model.dart';
import 'todo_item.dart';

class TodoList extends StatelessWidget {
  final List<TodoModel> todos;
  final Function(String) onToggle;
  final Function(String) onDelete;
  final Function(TodoModel) onTap;

  const TodoList({
    Key? key,
    required this.todos,
    required this.onToggle,
    required this.onDelete,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) {
      return const Center(
        child: Text(
          'No todos yet!\nAdd your first todo above.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoItem(
          todo: todo,
          onToggle: (value) => onToggle(todo.id),
          onDelete: () => onDelete(todo.id),
          onTap: () => onTap(todo),
        );
      },
    );
  }
}
