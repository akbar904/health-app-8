import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/features/todo/todo_model.dart';
import 'package:my_app/features/todo/todo_service.dart';
import 'package:my_app/ui/dialogs/todo_action/todo_action_dialog.dart';
import 'package:my_app/enums/dialog_type.dart';

class TodoViewModel extends BaseViewModel {
  final _todoService = locator<TodoService>();
  final _dialogService = locator<DialogService>();

  List<Todo> _todos = [];
  List<Todo> get todos => _todos;

  bool _sortAscending = true;
  bool get sortAscending => _sortAscending;

  Future<void> initialize() async {
    setBusy(true);
    await _loadTodos();
    setBusy(false);
  }

  Future<void> _loadTodos() async {
    try {
      _todos = await _todoService.getTodos();
      _sortTodos();
      notifyListeners();
    } catch (e) {
      setError(e);
    }
  }

  void _sortTodos() {
    _todos.sort((a, b) => _sortAscending
        ? a.createdAt.compareTo(b.createdAt)
        : b.createdAt.compareTo(a.createdAt));
  }

  void toggleSortOrder() {
    _sortAscending = !_sortAscending;
    _sortTodos();
    notifyListeners();
  }

  Future<void> addTodo(String title) async {
    if (title.trim().isEmpty) return;

    final newTodo = Todo(
      id: DateTime.now().toString(),
      title: title,
      createdAt: DateTime.now(),
    );

    _todos.add(newTodo);
    notifyListeners();
    await _todoService.saveTodos(_todos);
  }

  Future<void> toggleTodo(Todo todo) async {
    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _todos[index] = todo.copyWith(
        isComplete: !todo.isComplete,
        completedAt: !todo.isComplete ? DateTime.now() : null,
      );
      notifyListeners();
      await _todoService.saveTodos(_todos);
    }
  }

  Future<void> deleteTodo(Todo todo) async {
    _todos.removeWhere((t) => t.id == todo.id);
    notifyListeners();
    await _todoService.saveTodos(_todos);
  }

  Future<void> editTodo(Todo todo) async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.todoAction,
      data: TodoActionDialogData(
        initialTitle: todo.title,
        isEditing: true,
      ),
    );

    if (response?.confirmed == true && response?.data != null) {
      final index = _todos.indexWhere((t) => t.id == todo.id);
      if (index != -1) {
        _todos[index] = todo.copyWith(title: response!.data as String);
        notifyListeners();
        await _todoService.saveTodos(_todos);
      }
    }
  }

  Future<void> showAddTodoDialog() async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.todoAction,
      data: TodoActionDialogData(),
    );

    if (response?.confirmed == true && response?.data != null) {
      await addTodo(response!.data as String);
    }
  }
}