import 'dart:convert';
import 'package:my_app/features/todo/todo_model.dart';

class TodoRepository {
  static const String _storageKey = 'todos';

  Future<List<Todo>> getTodos() async {
    try {
      // Simulated storage read
      await Future.delayed(const Duration(milliseconds: 500));
      return [];
    } catch (e) {
      throw Exception('Failed to load todos');
    }
  }

  Future<void> saveTodos(List<Todo> todos) async {
    try {
      final todosJson = todos.map((todo) => todo.toJson()).toList();
      final encodedTodos = json.encode(todosJson);
      // Simulated storage write
      await Future.delayed(const Duration(milliseconds: 500));
    } catch (e) {
      throw Exception('Failed to save todos');
    }
  }
}
