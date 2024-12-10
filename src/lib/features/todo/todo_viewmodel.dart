import 'package:stacked/stacked.dart';
import 'package:my_app/models/todo_model.dart';
import 'package:my_app/services/todo_service.dart';
import 'package:stacked_services/stacked_services.dart';

class TodoViewModel extends BaseViewModel {
  final TodoService _todoService;
  final DialogService _dialogService;

  TodoViewModel(this._todoService, this._dialogService);

  List<TodoModel> _todos = [];
  List<TodoModel> get todos => _todos;

  Future<void> initialize() async {
    await loadTodos();
  }

  Future<void> loadTodos() async {
    setBusy(true);
    try {
      _todos = await _todoService.getTodos();
      notifyListeners();
    } catch (e) {
      await _dialogService.showDialog(
        title: 'Error',
        description: 'Failed to load todos: $e',
      );
    }
    setBusy(false);
  }

  Future<void> addTodo(String title) async {
    if (title.trim().isEmpty) return;

    setBusy(true);
    try {
      await _todoService.addTodo(title);
      await loadTodos();
    } catch (e) {
      await _dialogService.showDialog(
        title: 'Error',
        description: 'Failed to add todo: $e',
      );
    }
    setBusy(false);
  }

  Future<void> toggleTodoStatus(TodoModel todo) async {
    setBusy(true);
    try {
      await _todoService.toggleTodoStatus(todo);
      await loadTodos();
    } catch (e) {
      await _dialogService.showDialog(
        title: 'Error',
        description: 'Failed to update todo status: $e',
      );
    }
    setBusy(false);
  }

  Future<void> deleteTodo(String id) async {
    setBusy(true);
    try {
      await _todoService.deleteTodo(id);
      await loadTodos();
    } catch (e) {
      await _dialogService.showDialog(
        title: 'Error',
        description: 'Failed to delete todo: $e',
      );
    }
    setBusy(false);
  }

  Future<void> updateTodoTitle(String id, String newTitle) async {
    if (newTitle.trim().isEmpty) return;

    setBusy(true);
    try {
      await _todoService.updateTodoTitle(id, newTitle);
      await loadTodos();
    } catch (e) {
      await _dialogService.showDialog(
        title: 'Error',
        description: 'Failed to update todo title: $e',
      );
    }
    setBusy(false);
  }
}
