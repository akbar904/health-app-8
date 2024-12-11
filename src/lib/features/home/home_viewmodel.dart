import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/models/todo.dart';
import 'package:my_app/services/todo_service.dart';
import 'package:my_app/enums/dialog_type.dart';
import 'package:my_app/enums/bottom_sheet_type.dart';

class HomeViewModel extends BaseViewModel {
  final _todoService = locator<TodoService>();
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  bool _showCompleted = true;
  bool get showCompleted => _showCompleted;

  List<Todo> get filteredTodos => _showCompleted
      ? _todoService.todos
      : _todoService.todos.where((todo) => !todo.isCompleted).toList();

  void toggleShowCompleted() {
    _showCompleted = !_showCompleted;
    notifyListeners();
  }

  void addTodo() {
    if (titleController.text.isEmpty) return;

    final todo = Todo(
      id: DateTime.now().toString(),
      title: titleController.text,
      description: descriptionController.text,
      createdAt: DateTime.now(),
    );

    _todoService.addTodo(todo);
    titleController.clear();
    descriptionController.clear();
    notifyListeners();
  }

  void toggleTodoCompletion(String id) {
    _todoService.toggleTodoCompletion(id);
    notifyListeners();
  }

  Future<void> showTodoDetails(String id) async {
    final todo = _todoService.todos.firstWhere((t) => t.id == id);
    await _dialogService.showCustomDialog(
      variant: DialogType.custom,
      title: 'Todo Details',
      data: {
        'title': todo.title,
        'description': todo.description,
        'showConfirmButton': true,
        'confirmationTitle': 'Done',
      },
    );
  }

  Future<void> showTodoOptions(String id) async {
    final response = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.custom,
      data: id,
    );

    if (response?.data == 'delete') {
      _todoService.deleteTodo(id);
      notifyListeners();
    } else if (response?.data == 'edit') {
      final todo = _todoService.todos.firstWhere((t) => t.id == id);
      titleController.text = todo.title;
      descriptionController.text = todo.description;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}