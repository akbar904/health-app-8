import 'package:flutter/material.dart';
import 'package:my_app/features/home/widgets/todo_item.dart';
import 'package:my_app/models/todo_model.dart';

class TodoList extends StatelessWidget {
  final List<TodoModel> todos;
  final Function(bool?, TodoModel) onTodoToggled;
  final Function(TodoModel) onTodoDeleted;
  final Function(TodoModel) onTodoEdited;

  const TodoList({
    Key? key,
    required this.todos,
    required this.onTodoToggled,
    required this.onTodoDeleted,
    required this.onTodoEdited,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) {
      return const Center(
        child: Text('No todos yet. Add one by tapping the + button!'),
      );
    }

    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoItem(
          todo: todo,
          onToggled: (value) => onTodoToggled(value, todo),
          onDelete: () => onTodoDeleted(todo),
          onEdit: () => onTodoEdited(todo),
        );
      },
    );
  }
}
