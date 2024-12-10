import 'package:my_app/features/todo/models/todo.dart';

class TodoRepository {
  final List<Todo> _todos = [];

  Future<List<Todo>> getTodos() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _todos;
  }

  Future<void> addTodo(Todo todo) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _todos.add(todo);
  }

  Future<void> updateTodo(Todo todo) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _todos[index] = todo;
    }
  }

  Future<void> deleteTodo(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _todos.removeWhere((todo) => todo.id == id);
  }
}
