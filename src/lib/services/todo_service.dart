import 'dart:convert';
import 'package:my_app/models/todo_model.dart';

class TodoService {
  final List<TodoModel> _todos = [];

  List<TodoModel> getAllTodos() {
    return _todos;
  }

  void addTodo(TodoModel todo) {
    _todos.add(todo);
  }

  void updateTodo(TodoModel todo) {
    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _todos[index] = todo;
    }
  }

  void deleteTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
  }

  void toggleTodoCompletion(String id) {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      final todo = _todos[index];
      _todos[index] = todo.copyWith(
        isCompleted: !todo.isCompleted,
        completedAt: !todo.isCompleted ? DateTime.now() : null,
      );
    }
  }

  String exportTodosToJson() {
    final List<Map<String, dynamic>> jsonList =
        _todos.map((todo) => todo.toJson()).toList();
    return jsonEncode(jsonList);
  }

  void importTodosFromJson(String jsonString) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    _todos.clear();
    _todos.addAll(
      jsonList.map((json) => TodoModel.fromJson(json as Map<String, dynamic>)),
    );
  }

  List<TodoModel> searchTodos(String query) {
    final lowercaseQuery = query.toLowerCase();
    return _todos.where((todo) {
      return todo.title.toLowerCase().contains(lowercaseQuery) ||
          todo.description.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }

  List<TodoModel> getCompletedTodos() {
    return _todos.where((todo) => todo.isCompleted).toList();
  }

  List<TodoModel> getPendingTodos() {
    return _todos.where((todo) => !todo.isCompleted).toList();
  }
}
