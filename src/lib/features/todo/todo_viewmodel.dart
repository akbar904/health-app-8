import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/features/todo/todo_model.dart';
import 'package:my_app/features/todo/todo_service.dart';

class TodoViewModel extends BaseViewModel {
  final _todoService = locator<TodoService>();
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();

  final todoController = TextEditingController();
  Todo? _editingTodo;

  List<Todo> get todos => _todoService.todos;

  @override
  void dispose() {
    todoController.dispose();
    super.dispose();
  }

  void addTodo() {
    if (todoController.text.isEmpty) return;

    if (_editingTodo != null) {
      _todoService.updateTodo(
        _editingTodo!.id,
        todoController.text,
      );
      _editingTodo = null;
    } else {
      _todoService.addTodo(todoController.text);
    }

    todoController.clear();
    notifyListeners();
  }

  void toggleTodo(String id) {
    _todoService.toggleTodo(id);
    notifyListeners();
  }

  void deleteTodo(String id) async {
    final response = await _dialogService.showDialog(
      title: 'Delete Todo',
      description: 'Are you sure you want to delete this todo?',
    );

    if (response?.confirmed ?? false) {
      _todoService.deleteTodo(id);
      notifyListeners();
    }
  }

  void startEditingTodo(Todo todo) {
    _editingTodo = todo;
    todoController.text = todo.title;
    notifyListeners();
  }

  void showOptionsBottomSheet() async {
    await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.todoOptions,
      data: todos,
    );
  }

  void clearCompletedTodos() {
    _todoService.clearCompletedTodos();
    notifyListeners();
  }
}
