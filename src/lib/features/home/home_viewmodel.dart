import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/models/todo_model.dart';
import 'package:my_app/services/todo_service.dart';
import 'package:my_app/ui/dialogs/task_dialog/task_dialog.dart';
import 'package:my_app/app/app.locator.dart';

class HomeViewModel extends BaseViewModel {
  final _todoService = TodoService();
  final _navigationService = locator<NavigationService>();

  List<TodoModel> get todos => _todoService.todos;

  Future<void> showAddDialog(BuildContext context) async {
    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (_) => const TaskDialog(),
    );

    if (result != null) {
      final todo = TodoModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: result['title']!,
        description: result['description']!,
        createdAt: DateTime.now(),
      );
      await _todoService.addTodo(todo);
      rebuildUi();
    }
  }

  Future<void> showEditDialog(TodoModel todo) async {
    final result = await showDialog<Map<String, String>>(
      context: _navigationService.navigatorKey!.currentContext!,
      builder: (_) => TaskDialog(todo: todo),
    );

    if (result != null) {
      final updatedTodo = todo.copyWith(
        title: result['title'],
        description: result['description'],
      );
      await _todoService.updateTodo(updatedTodo);
      rebuildUi();
    }
  }

  Future<void> toggleTodoStatus(String id) async {
    await _todoService.toggleTodoStatus(id);
    rebuildUi();
  }

  Future<void> deleteTodo(String id) async {
    await _todoService.deleteTodo(id);
    rebuildUi();
  }

  Future<void> exportTodos() async {
    try {
      String? outputFile = await FilePicker.platform.saveFile(
        dialogTitle: 'Save todos',
        fileName: 'todos.json',
      );

      if (outputFile != null) {
        // Implementation would use dart:io which is not shown here
        // but would write _todoService.exportToJson() to the file
      }
    } catch (e) {
      debugPrint('Error exporting todos: $e');
    }
  }

  Future<void> importTodos() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result != null) {
        // Implementation would use dart:io which is not shown here
        // but would read the file and call _todoService.importFromJson()
        rebuildUi();
      }
    } catch (e) {
      debugPrint('Error importing todos: $e');
    }
  }
}