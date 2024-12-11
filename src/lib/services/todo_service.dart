import 'dart:convert';
import 'package:my_app/models/todo_model.dart';
import 'package:flutter/foundation.dart';

class TodoService {
  final List<TodoModel> _todos = [];

  List<TodoModel> get todos => List.unmodifiable(_todos);

  Future<void> addTodo(TodoModel todo) async {
    try {
      _todos.add(todo);
      _sortTodos();
    } catch (e) {
      debugPrint('Error adding todo: $e');
      rethrow;
    }
  }

  Future<void> updateTodo(TodoModel todo) async {
    try {
      final index = _todos.indexWhere((t) => t.id == todo.id);
      if (index != -1) {
        _todos[index] = todo;
        _sortTodos();
      }
    } catch (e) {
      debugPrint('Error updating todo: $e');
      rethrow;
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      _todos.removeWhere((todo) => todo.id == id);
    } catch (e) {
      debugPrint('Error deleting todo: $e');
      rethrow;
    }
  }

  Future<void> toggleTodoStatus(String id) async {
    try {
      final index = _todos.indexWhere((t) => t.id == id);
      if (index != -1) {
        final todo = _todos[index];
        _todos[index] = todo.copyWith(
          isCompleted: !todo.isCompleted,
          completedAt: !todo.isCompleted ? DateTime.now() : null,
        );
        _sortTodos();
      }
    } catch (e) {
      debugPrint('Error toggling todo status: $e');
      rethrow;
    }
  }

  void _sortTodos() {
    _todos.sort((a, b) {
      if (a.isCompleted == b.isCompleted) {
        return b.createdAt.compareTo(a.createdAt);
      }
      return a.isCompleted ? 1 : -1;
    });
  }

  String exportToJson() {
    try {
      final List<Map<String, dynamic>> jsonList =
          _todos.map((todo) => todo.toJson()).toList();
      return jsonEncode(jsonList);
    } catch (e) {
      debugPrint('Error exporting todos: $e');
      rethrow;
    }
  }

  Future<void> importFromJson(String jsonString) async {
    try {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      _todos.clear();
      _todos.addAll(
        jsonList
            .map((json) => TodoModel.fromJson(json as Map<String, dynamic>)),
      );
      _sortTodos();
    } catch (e) {
      debugPrint('Error importing todos: $e');
      rethrow;
    }
  }
}
