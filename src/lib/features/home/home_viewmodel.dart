import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/models/todo.dart';
import 'package:my_app/services/todo_service.dart';

class HomeViewModel extends BaseViewModel {
  final TodoService _todoService;
  final TextEditingController todoController = TextEditingController();

  HomeViewModel(this._todoService);

  List<Todo> get todos => _todoService.todos;

  void addTodo() {
    if (todoController.text.isNotEmpty) {
      final newTodo = Todo(
        id: DateTime.now().toString(),
        title: todoController.text,
        createdAt: DateTime.now(),
      );
      _todoService.addTodo(newTodo);
      todoController.clear();
      notifyListeners();
    }
  }

  void toggleTodo(String id) {
    _todoService.toggleTodoCompletion(id);
    notifyListeners();
  }

  void deleteTodo(String id) {
    _todoService.deleteTodo(id);
    notifyListeners();
  }

  @override
  void dispose() {
    todoController.dispose();
    super.dispose();
  }
}
