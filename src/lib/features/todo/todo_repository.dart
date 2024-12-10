import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'models/todo_model.dart';

class TodoRepository {
  final List<TodoModel> _todos = [];

  Future<List<TodoModel>> getTodos() async {
    try {
      return _todos;
    } catch (e) {
      debugPrint('Error getting todos: $e');
      return [];
    }
  }

  Future<void> addTodo(TodoModel todo) async {
    try {
      _todos.add(todo);
    } catch (e) {
      debugPrint('Error adding todo: $e');
      throw Exception('Failed to add todo');
    }
  }

  Future<void> updateTodo(TodoModel todo) async {
    try {
      final index = _todos.indexWhere((t) => t.id == todo.id);
      if (index != -1) {
        _todos[index] = todo;
      }
    } catch (e) {
      debugPrint('Error updating todo: $e');
      throw Exception('Failed to update todo');
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      _todos.removeWhere((todo) => todo.id == id);
    } catch (e) {
      debugPrint('Error deleting todo: $e');
      throw Exception('Failed to delete todo');
    }
  }
}
