import 'package:my_app/features/todo/models/todo.dart';

class TodoRepository {
  final List<Todo> _todos = [];

  TodoRepository();

  Future<List<Todo>> getTodos() async {
    return _todos;
  }

  Future<void> addTodo(Todo todo) async {
    _todos.add(todo);
  }

  Future<void> updateTodo(Todo todo) async {
    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _todos[index] = todo;
    }
  }

  Future<void> deleteTodo(String id) async {
    _todos.removeWhere((todo) => todo.id == id);
  }
}