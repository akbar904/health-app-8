import 'package:my_app/features/todo/todo_model.dart';

class TodoRepository {
  final List<TodoModel> _todos = [];

  List<TodoModel> getTodos() {
    return _todos;
  }

  void addTodo(TodoModel todo) {
    _todos.add(todo);
  }

  void toggleTodo(String id) {
    final todoIndex = _todos.indexWhere((todo) => todo.id == id);
    if (todoIndex != -1) {
      final todo = _todos[todoIndex];
      _todos[todoIndex] = todo.copyWith(isCompleted: !todo.isCompleted);
    }
  }

  void deleteTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
  }

  void updateTodo(TodoModel updatedTodo) {
    final todoIndex = _todos.indexWhere((todo) => todo.id == updatedTodo.id);
    if (todoIndex != -1) {
      _todos[todoIndex] = updatedTodo;
    }
  }
}
