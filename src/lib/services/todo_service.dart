import 'package:my_app/models/todo.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/foundation.dart';

class TodoService with ListenableServiceMixin {
  TodoService() {
    listenToReactiveValues([_todos]);
  }

  final ReactiveValue<List<Todo>> _todos = ReactiveValue<List<Todo>>([]);
  List<Todo> get todos => _todos.value;

  void addTodo(Todo todo) {
    _todos.value = [..._todos.value, todo];
    notifyListeners();
  }

  void updateTodo(Todo todo) {
    final index = _todos.value.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      final newTodos = List<Todo>.from(_todos.value);
      newTodos[index] = todo;
      _todos.value = newTodos;
      notifyListeners();
    }
  }

  void deleteTodo(String id) {
    _todos.value = _todos.value.where((todo) => todo.id != id).toList();
    notifyListeners();
  }

  void toggleTodoCompletion(String id) {
    final todo = _todos.value.firstWhere((t) => t.id == id);
    final updatedTodo = todo.copyWith(
      isCompleted: !todo.isCompleted,
      completedAt: !todo.isCompleted ? DateTime.now() : null,
    );
    updateTodo(updatedTodo);
  }

  List<Todo> getCompletedTodos() {
    return _todos.value.where((todo) => todo.isCompleted).toList();
  }

  List<Todo> getPendingTodos() {
    return _todos.value.where((todo) => !todo.isCompleted).toList();
  }
}
